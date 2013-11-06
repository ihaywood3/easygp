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

"""A class for accessing the PCEHR at the high "Pythonic" level. 
Doesn't do preperation of CDAs or metadata.
"""

import pcehr_transport

# access reponses
DENIED=0  # access is denied
ACCESS=1  # access is granted
WITH_PASSWORD=2  # access is granted only with a password (so need to called gain_pcehr_access again)

# document types
EVENT_SUMMARY=0
SHARED_HEALTH_SUMMARY=1
DISCHARGE_SUMMARY=2
PRESCRIPTION=3
SPECIALIST_LETTER=4
MBS_RECORD=5
PBS_RECORD=6

class PCEHR(pcehr_transport.PCEHR_SOAP):

    def does_pcehr_exist(self,ihi,hpio,org_name,hpii,user_name):
        """
        test if a PCEHR exists. Only called once for a given patient
        hpio: HPI-O of the organisation making this query
        org_name: organisation name (without address)
        hpii: HPI-I of the user
        user_name: full text name of the user e.g "Dr. Ian Haywood"
        returns: DENIED, ACCESS, WITH_PASSWORD
        """
        req = '<p:doesPCEHRExist xmlns:p="http://ns.electronichealth.net.au/pcehr/xsd/interfaces/PCEHRProfile/1.0"></p:doesPCEHRExist>'
        return self.do_action('doesPCEHRExist','doesPCEHRExistRequest',ihi,hpio,org_name,hpii,user_name,req)
    
    def gain_pcehr_access(self,ihi,hpio,org_name,hpii,user_name,password=None):
        """
        Apply for acess to the PCEHR in this session
        Needs to be called for each session of access
        Parameters same meaning as does_pcehr_exist except password

        Returns a Record object, or the values DENIED or WITH_PASSWORD
        the Record remembers the ihi,hpio,org_name,hpii and user_name from this request. 
        """
        pass


class Record(object):

    def search(self,begin=None,finish=None,types=None):
        """
        Search the PCEHR for documents
        begin: datetime.Date no results before this date
        finish: no results after this date
        types: documents must be one of these types. None means any type
        if multiple search paramters they are logically ANDed: all must match

        response is a list of Documents
        """
        pass

    def upload(self,cda,metsdata):
        """
        Uploads a PCEHR document
        cda: CDA XML as a string
        metadata: "IHE metadata" as an XML fragment
        Must be for this same patient
        Attachments not supported.

        CDA will the signed by this function, CDA and signature are then packaged into a ZIP
        file as per the "CDA Package" specification, and then uploaded to the PCEHR
        """
        pass

class Document(object):
    """
    Represents a document on search results

    Object read-only attributes
    hpio: HPI-O of the authoring organisation
    org_name: organisation name (without address)
    hpii: HPI-I of the author
    user_name: full text name of the author e.g "Dr. Ian Haywood"
    type: document type, one of constants used in searching
    """

    def get_cda(self):
        """
        returns the CDA XML as a string. For search results this should download the CDA text itself.
        Attachments currently not supported.
        """
        pass

if __name__ == '__main__':
    soaper = PCEHR_SOAP()
    soaper.set_configs('../keys/nash/7499758030/private.pem','../keys/nash/7499758030/certs.pem',soap_host='b2b.ehealthvendortest.health.gov.au',soap_path='/')
    elem = soaper.does_pcehr_exist(ihi='8003608500029616',hpio='8003628233354198',org_name='DHSITESTORGD421',hpii='8003611566666859',user_name='Adrian Grignon')
    print xml.etree.ElementTree.tostring(elem)
