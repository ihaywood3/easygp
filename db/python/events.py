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

# This code is uses public APIs of the 'driver' modules and so does not refer to 
# restricted information, therefore it can be released open-source. 
# However it is not very useful without the 4 drivers: mo, hi_service, pcehr 
# and medisecure

"""Event handlers called by dbwrapper."""

import sys, os, os.path, traceback, time, logging, re, socket, logging
import pdb
import psycopg2
import soap
import dbwrapper

class Event:

    def __init__(self, db, daemon):
        self.pcehr_soap = None
        self.db = db
        self.daemon = daemon
        self.config = daemon.config
        self.medisecure = None
        self.mo = None
        self.hi_service = None

    def overnight(self):
        """run one a day tasks for overnight"""
        if self.pcehr_soap is not None: pass
        if self.medisecure is not None: pass
        if self.mo is not None: pass
        if self.hi_service is not None: pass

    def translate_gender(self,sex):
        # translate EasyGP gender codes
        if sex == "H": sex = "I" # EasyGP uses the older term hermaphrodite = Intersex
        if sex == "T": sex = "F" # bit cheeky, Medicare has no transgender code: 90% of "transgender" are phenotypically female.
        if sex == "U": sex = "N"
        return sex

    def patient_death(self,pid,payload):
        for patient in self.db.patients_died_to_upload():
            sex = self.translate_gender(patient["sex"])
            died = patient["date_deceased"].strftime("%Y-%m-%d")
            try:
                ihi, record_status, status, messages = self.hi_service.notify_death(self.config["user"],patient["ihi"],sex,died)
            except soap.SOAPError as exc:
                logging.exception("SOAP failure")
                logstring = "<p>Tried to report patient death: A SOAP network error occurred: <tt>{}</tt></p>".format(str(exc))
                self.db.set_ihi_error(patient["fk_patient"],logstring)
            except socket.error as exc:
                logging.exception("network error")
                if self.db.event_failed("death"):
                    self.db.log_simple_entry(patient["fk_patient"],"Tried to get IHI but network down")
                raise # try again later but don't tag patient as not completed.
            else:
                logging.info("notify death returns {}".format(repr((ihi,record_status,status,messages))))
                status = status.lower()
                if status == "deceased":
                    logstring = "<p>Death successfully reported to Medicare.</p>"
                else:
                    logstring = "<p>Tried to report death but problems</p>"
                    logstring += "<p>IHI: {}</p><p>Record status: {}</p><p>Status: {}</p>".format(ihi,record_status,status)
                logstring += self.messages_to_table(messages)
                logstring += "<p>SOAP Request ID: {}</p><p>SOAP reply ID: {}</p>".format(self.soap.outgoing_uuid,self.soap.incoming_uuid)
                self.db.patient_mark_death_informed(patient["fk_patient"],logstring)

    def messages_to_table(self,messages):
        logstring = ""
        if len(messages) > 0:
            logstring = "<p><table><tr><th>Message</th><th>Code</th><th>Severity</th></tr>"
            for message in messages:
                logstring += "<tr><td>{reason}</td><td>{code}</td><td>{severity}</td></tr>".format(**message)
            logstring += "</table></p>"
        return logstring

    def new_ihi(self,pid,payload):
        for patient in self.db.get_patients_to_upload():
            dob = patient["birthdate"].strftime("%Y-%m-%d")
            sex = self.translate_gender(patient["sex"])
            surname = patient["surname"][:40]  # spec sez when sending to HI service no loonger than 40 chars
            firstname = patient["firstname"][:40]
            try:
                ihi, record_status, status, messages = self.hi_service.search_ihi(self.config["db_user"],surname,firstname,dob,sex,patient["medicare_number"],patient["medicare_ref_number"],patient["veteran_number"])
            except soap.SOAPError as exc:
                logging.exception("SOAP failure")
                error = True
                logstring = "<p>A SOAP network error occurred: <tt>{}</tt></p>".format(dbwrapper.html(str(exc)))
            except socket.error as exc:
                if not self.db.is_retry():
                    self.db.log_simple_entry("Tried to get IHI but network down")
                raise  # try again later but don't tag patient as not completed.
            else:
                error = False
                logstring = ""
                logging.info("search IHI returns {}".format(repr((ihi,record_status,status,messages))))
                if ihi is None:
                    error = True
                    logstring += "<p>No IHI returned</p>"
                else:
                    record_status = record_status.lower()
                    status = status.lower()
                    logstring += "<p>Medicare returned IHI {} [status: {}, record status: {}]<p>".format(ihi,status,record_status) 
                    if record_status == "unverified":
                        error = True
                        logstring += "<p>Unverified IHI cannot be used. The patient needs to provide further identification to Medicare</p>"
                    if record_status == "provisional":
                        error = True
                        logstring += "<p>Provisional IHI cannot be used. The patient needs to contact Medicare to complete their registration.</p>"
                    if not error and record_status != "verified":
                        error = True
                        logstring += "<p>Unknown record status. Contact Medicare for clarification</p>"
                    if status == "deceased":
                        pass
                    if status == "retired":
                        error = True
                        logstring += "<p>Retired means reitred in the Medicare database. Contact Medicare to update details.</p>"
                    if status == "expired":
                        error = True
                        logstring += "<p>Expired in the Medicare database, cannot be used. Contact Medicare to update details.</p>"
                    if status == "resolved":
                        error = True
                        logstring += "<p>IHI is marked as &quot;resolved&quot; in the Medicare database. Contact Medicare to update details.</p>"
                    if not error and status != "deceased" and status != "active":
                        error = True
                        logstring += "Unknown status, cannot be used. Contact Medicare for details</p>"
                logstring += self.messages_to_table(messages)
                if error:
                    logstring += "<p>SOAP Request ID: {}</p><p>SOAP reply ID: {}</p>".format(self.soap.outgoing_uuid,self.soap.incoming_uuid)
                else:
                    logstring += "<p>Successfully obtained IHI {} from Medicare HI Service.</p>".format(ihi)
            if error:
                self.db.set_ihi_error(patient["fk_patient"],logstring)
            else:
                if self.db.ihi_duplicate_check(ihi,patient["fk_patieht"]):
                    if status == 'deceased':
                        self.db.mark_death_informed(patient["fk_patient"],logstring)
                    else:
                        if "ihi" in patient and patient["ihi"] is not None and patient["ihi"] != ihi:
                            logstring += 'Previous IHI %s being replaced' % patient["ihi"]
                        self.db.set_ihi(patient["fk_patient"],ihi,logstring)
    
    def script_printed(self,pid,payload):
        script_no = int(payload)
        items = self.db.get_scripts(script_no)
        if len(items) == 0:
            logging.error("script no %d no scripts found in DB" % script_no)
            return
        consult_data = self.db.get_prescriber_data(items[0]['fk_consult'])
        patient_data = self.db.get_patient(items[0]['fk_patient'])
        patient_data['comms'] = self.db.get_person_comms(patient_data['fk_person'])
        consult_data['comms'] = self.db.get_staff_comms(consult_data['fk_person'],consult_data['fk_branch'])
        observations = self.db.get_obs(items[0]['fk_patient'])
        try:
            receipt_code = self.medisecure.submit_script(items,consult_data,patient_data,observations)
        except:
            self.db.log_simple_entry(items[0]['fk_patient'],'MediSecure e-script error: %s' % dbwrapper.html(repr(sys.exc_info()[0])),linked_table='clin_prescribing.prescribed',fk_row=script_no)
        else:
            self.db.log_simple_entry(items[0]['fk_patient'],'MediSecure submitted %s' % receipt_code,linked_table='clin_prescribing.prescribed',fk_row=script_no)
            
