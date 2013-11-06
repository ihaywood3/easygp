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

# This code does not refer to restricted information, it is based on information
# provided at https://vendors.nehta.gov.au/ that was obtained without signing any
# NDA.

"""A class for basic transport to the PCEHR via SOAP
"""

import soap
import xml.etree.ElementTree

class PCEHR_SOAP(soap.SOAPCrypto):
    """A descendant class of SOAPCrypto optimised for doing PCEHR SOAP requests"""

    def __init__(self):
        self.sigwrapper_tag = '<h:signature xmlns:h="http://ns.electronichealth.net.au/pcehr/xsd/common/CommonCoreElements/1.0">'
        self.sigwrapper_tag_close = '</h:signature>'
        #self.pcehr_mode = True

    def do_action(self,url_tip,action,ihi,hpio,org_name,hpii,user_name,req):
        """Do a PCEHR SOAP action
        - action: the action, minus the prefix URL
        - ihi: the patient's Individual Health Identifier
        - hpio: the organisations's HPI-O
        - org_name: the free-string name of the organisation
        - hpii: the HPI-I of the user
        - user_name: the free-string name of the user making the request
        - reg: the request as "canonicalised" XML
        """
        action = "http://ns.electronichealth.net.au/pcehr/svc/PCEHRProfile/1.1/PCEHRProfilePortType/" + action
        header_templ = """
            <h:PCEHRHeader xmlns:h="http://ns.electronichealth.net.au/pcehr/xsd/common/CommonCoreElements/1.0" xml:id="{{xmlid}}">
                                <h:User>
                                    <h:IDType>HPII</h:IDType>
                                    <h:ID>{hpii}</h:ID>
                                    <h:userName>{user_name}</h:userName>
                                    <h:useRoleForAudit>false</h:useRoleForAudit>
                                </h:User>
                                <h:ihiNumber>{ihi}</h:ihiNumber>
                                <h:productType>
                                    <h:vendor>DrsDesk</h:vendor>
                                    <h:productName>EasyGP</h:productName>
                                    <h:productVersion>1.0</h:productVersion>
                                    <h:platform>Linux</h:platform>
                                </h:productType>
                                <h:clientSystemType>CIS</h:clientSystemType>
                                <h:accessingOrganisation>
                                    <h:organisationID>{hpio}</h:organisationID>
                                    <h:organisationName>{org_name}</h:organisationName>
                                </h:accessingOrganisation>
            </h:PCEHRHeader>"""
        hdr = self.clean_template(header_templ).format(ihi=ihi,hpio=hpio,hpii=hpii,org_name=org_name,user_name=user_name)
        time_templ = """
    <h:timestamp xmlns:h="http://ns.electronichealth.net.au/pcehr/xsd/common/CommonCoreElements/1.0" xml:id="{{xmlid}}">
              <h:created>{tim}</h:created>
    </h:timestamp>"""
        tim = self.clean_template(time_templ).format(tim=self.soap_date())
        return self.soap(action,req,[('time',tim),('hdr',hdr)],[],url_tip=url_tip)

