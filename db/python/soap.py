#!/usr/bin/python
# -*- coding: latin-1 -*-

# Copyright (C) 2008-2012 Dr. Richard Terry, Dr. Ian Haywood

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This code is not Medicare specific and does not refer to restricted information, it is based
# on descriptions of SOAP services in the public domain, therefore
# it can be released open-source. However it is not very useful without the Medicare specific drivers.

"""A class for accessing encrypted SOAP services.
"""


from httplib import HTTPSConnection
from M2Crypto import BIO, Rand, SMIME, EVP
import hashlib, base64, uuid, time, re, pdb, os, sys, os.path
import xml.etree.ElementTree as ET

soap12 = '{http://www.w3.org/2003/05/soap-envelope}'

class SOAPError(Exception):
    """An error form the SOAP interface layer

Usually because the user is not authorised in some way
Or my XML is wrong ;-)
"""
    def __init__(self, msg, severity):
        self.msg = msg
        self.severity = severity

    def __str__(self):
        return repr(self.severity+self.msg)

    def __repr__(self):
        return repr(self.severity+self.msg)


class SOAPCrypto:
    """A utility class for doing SOAP signing

As this is based on public (albeit old and very obscure) standards I believe this can be released
as open-source code
"""

    def drop_root(self):
        """drop root privileges if euid set"""
        if self.euid is not None:
            os.seteuid(self.euid)

    def get_root(self):
        """gain root privileges if euid set"""
        if self.euid is not None:
            os.seteuid(0)
    
    def set_configs(self,priv_key,cert,log=None,euid=None,soap_host=None,soap_path=None):
        """set class-wide configuration values
        priv_key: path to the private key in PEM format
        cert: path to the X.509 certificate in PEM format
        euid: the effective user-id, if set will change to root for accessing the private key and then back to this uid, None doesn't do any uid changing
        """
        self.__cert_path = cert
        self.__private_key_path = priv_key
        self.log = log
        self.euid = euid
        if soap_host: self.soap_host = soap_host
        if soap_path: self.soap_path = soap_path

    def make_hash(self,s):
        """Make a base64-encoded SHA1 hash of the string s"""
        sha1 = hashlib.sha1()
        sha1.update(s)
        return base64.b64encode(sha1.digest())

    def soap_date(self,date=None):
        """A date in the SOAP required format"""
        if date is None: date = time.localtime()
        if time.daylight:
            tz = -time.altzone
        else:
            tz = -time.timezone
        tz = "{:0=+3}:{:0>2}".format(tz/3600,abs((tz % 3600)) / 60)
        return time.strftime("%Y-%m-%dT%H:%M:%S.00+11:00",date)

    def make_sig(self,text):
        """Make a base64-encoded RSA signature"""
        self.get_root()
        pkey = EVP.load_key(self.__private_key_path)
        self.drop_root()
        pkey.sign_init()
        pkey.sign_update(text)
        signature = pkey.sign_final()
        return base64.b64encode(signature)

    def grab_cert(self):
        """return the certificate stripped of its fluff for the SOAP message"""
        fo = file(self.__cert_path,"r")
        txt = fo.read()
        fo.close()
        txt = txt.replace("-----BEGIN CERTIFICATE-----","")
        txt = txt.replace("-----END CERTIFICATE-----","")
        txt = txt.strip()
        txt = txt.replace("\n","")
        return txt

    def do_https(self,postdata,url_tip=''):
        """Do the actual HTTPS exchange of SOAP packets
        the object must have soap_path and soap_host variables set for the HTTP path and server name respectively"""
        h = HTTPSConnection(self.soap_host,443,self.__private_key_path,self.__cert_path)
        h.request("POST",self.soap_path+url_tip,postdata,{'Content-Type':'application/soap+xml; charset=utf-8'})
        res = h.getresponse()
        return res.read()


    def clean_template(self,templ):
        """strip indentation whitespace from XML templates: do dynamically so our code is understandable"""
        templ = templ.replace("\t","")
        templ = templ.replace("\n","")
        templ = re.sub(' {2,}',' ',templ)
        templ = templ.replace("> <","><")
        templ = templ.strip()
        return templ

    def make_siginfo(self,packets_to_sign):
        """Make the SOAP SignedInfo packet. packets_to_sign is a list of tuples (name,packet), packet is an XML string.
        Note all XML must be "canonical XML" as defined by the W3C standard: http://www.w3.org/TR/xml-c14n
"""
        all_refs = ""
        returned_packets = []
        for nam, packet in packets_to_sign:
            the_uuid = nam+'-'+str(uuid.uuid4())
            the_xml = self.clean_template(packet).format(xmlid=the_uuid)
            the_sha1 = self.make_hash(the_xml)
            section = """
	  <Reference URI="#{xmlid}">
	    <Transforms>
	      <Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"></Transform>
	    </Transforms>
	    <DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"></DigestMethod>
	    <DigestValue>{sha1}</DigestValue>
	  </Reference>
"""
            r = self.clean_template(section).format(xmlid=the_uuid,sha1=the_sha1)
            all_refs += r
            # return our xmls too as we have replaced "{uuid}" with UUID we have generated
            returned_packets.append(the_xml)
        crypto_templ = """
	<SignedInfo xmlns="http://www.w3.org/2000/09/xmldsig#">
	  <CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"></CanonicalizationMethod>
	  <SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"></SignatureMethod>
{all_refs}
	</SignedInfo>"""
        siginfo = self.clean_template(crypto_templ).format(all_refs=all_refs)
        sig = self.make_sig(siginfo)
        return returned_packets, sig, siginfo

    def soap(self,action,body,signed_headers,unsigned_headers,url_tip=''):
        """Perform a soap call and returned XML-parsed result
        body -  the Body, soap 1.2 Body tags will be added.
        signed_headers - list of tuples (name,text) of SOAP header fragments that should be signed. must be {xmlid} for the xml id. name is a short arbitrary (i.e. not defined by standard) string idenitifying the header.
        unsigned_headers - list of strings, header fragments that don't need to be signed
        """
        body_xml = """<soap12:Body xmlns:soap12="http://www.w3.org/2003/05/soap-envelope" xml:id="{{xmlid}}">{body}</soap12:Body>"""
        body = body_xml.format(body=body)
        packets_to_sign = [("body",body)]
        packets_to_sign.extend(signed_headers)
        returned_packets, sig, siginfo = self.make_siginfo(packets_to_sign)
        body = returned_packets[0]
        signed_headers = returned_packets[1:]  # all except the body
        signed_headers.extend(unsigned_headers)
        headers = "".join(signed_headers)
        templ = """<?xml version="1.0" encoding="UTF-8"?>
<soap12:Envelope xmlns:soap12="http://www.w3.org/2003/05/soap-envelope" 
                 xmlns:wsa="http://www.w3.org/2005/08/addressing">
<soap12:Header>
   <wsa:Action>{action}</wsa:Action>
   <wsa:MessageID>urn:uuid:{message_uuid}</wsa:MessageID>
   <wsa:To>http://www.w3.org/2005/08/addressing/anonymous</wsa:To>
{headers}
{sigwrapper_tag}
<ds:Signature xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
{siginfo}
<ds:SignatureValue>{sig}</ds:SignatureValue>
<ds:KeyInfo><ds:X509Data><ds:X509Certificate>{cert}</ds:X509Certificate></ds:X509Data></ds:KeyInfo>
</ds:Signature>{sigwrapper_tag_close}</soap12:Header>{body}</soap12:Envelope>"""
        self.outgoing_uuid=uuid.uuid4()  # record in public variable as caller may want it for auditing or bug-reporting
        message = self.clean_template(templ).format(sigwrapper_tag=self.sigwrapper_tag,sigwrapper_tag_close=self.sigwrapper_tag_close,action=action,message_uuid=self.outgoing_uuid,headers=headers,sig=sig,cert=self.grab_cert(),siginfo=siginfo,body=body)
        #print message
        reply = self.do_https(message,url_tip)
        root = ET.fromstring(reply)
        msgid = root.find(".//{http://www.w3.org/2005/08/addressing}MessageID")
        if msgid is not None: 
            self.incoming_uuid = msgid.text # again, caller may want this
        else:
            self.incoming_uuid = None
        # look for old-style SOAP 1.0 ones too.
        fault = root.find('.//{http://schemas.xmlsoap.org/soap/envelope/}Fault')
        if fault is not None:
            msg = ET.tostring(fault)
            raise SOAPError(msg,'Error')
        return root

    
                            
