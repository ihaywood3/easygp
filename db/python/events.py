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

import sys, os, os.path, traceback, time, logging, re, socket, logging, datetime
import pdb
import psycopg2
import soap, dbwrapper

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
        if self.hi_service is not None: self.refresh_old_ihis()

    def translate_gender(self,sex):
        # translate EasyGP gender codes
        if sex == "H": sex = "I" # EasyGP uses the older term hermaphrodite = Intersex
        if sex == "T": sex = "F" # bit cheeky, Medicare has no transgender code: most "transgender" are phenotypically female.
        if sex == "U": sex = "N"
        return sex

    def patient_death(self,pid,payload):
        for patient in self.db.patients_died_to_upload():
            sex = self.translate_gender(patient["sex"])
            if not patient['date_deceased'] is None:
                died = patient["date_deceased"]
            else:
                died = datetime.date.today()
            died = died.strftime("%Y-%m-%d")
            try:
                ihi, record_status, status, messages = self.hi_service.notify_death(self.config["db_user"],patient["ihi"],sex,died)
            except soap.SOAPError as exc:
                logging.exception("SOAP failure")
                logstring = "<p>Tried to report patient death: A SOAP network error occurred: <tt>{}</tt></p>".format(str(exc))
                logstring += self.logstring_boilerplate(patient)
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
                logstring += self.logstring_boilerplate(patient)
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
        patients = self.db.get_patients_to_upload()
        for patient in patients:
            self.do_ihi_search(patient)
        if len(patients) == 0:
            logging.warn("event newihi but nothing to do")
            self.db.noop()


    def refresh_old_ihis(self):
        batch = []
        allpatients = {}
        for patient in self.db.get_ihis_for_refresh():
            b = {}
            allpatients[patient['fk_patient']] = patient
            b['dob'] = patient["birthdate"].strftime("%Y-%m-%d")
            b['sex'] = self.translate_gender(patient["sex"])
            b['surname'] = patient["surname"][:40]  # spec sez when sending to HI service no loonger than 40 chars
            b['firstname'] = patient["firstname"][:40]
            b['ihi'] = patient["ihi"]
            b['fk_patient'] = patient['fk_patient']
            batch.append(b)
        # in this context all exceptions can go to toplevel and be logged
        results = self.hi_service.search_ihi_batch(self.config["db_user"],batch)
        for fk_patient in results.keys():
            patient = allpatients[fk_patient]
            ihi, record_status, status, messages = results[fk_patient]
            self.deal_with_ihi_result(ihi,record_status,status,messages,patient,batch=True)

    def do_ihi_search(self,patient):
        dob = patient["birthdate"].strftime("%Y-%m-%d")
        sex = self.translate_gender(patient["sex"])
        surname = patient["surname"][:40]  # spec sez when sending to HI service no longer than 40 chars
        firstname = None
        if patient["firstname"] is not None: firstname = patient["firstname"][:40]
        mcn = patient["medicare_number"]
        irn = patient["medicare_ref_number"]
        dva = patient["veteran_number"]
        ihi = patient["ihi"]
        try:
            if ihi is not None:
                ihi, record_status, status, messages = self.hi_service.search_ihi(self.config["db_user"],surname,firstname,dob,sex,ihi=ihi)
            elif dva is not None:
                ihi, record_status, status, messages = self.hi_service.search_ihi(self.config["db_user"],surname,firstname,dob,sex,None,None,dva)
            elif mcn is not None:
                ihi, record_status, status, messages = self.hi_service.search_ihi(self.config["db_user"],surname,firstname,dob,sex,mcn,irn)
            else:
                ihi, record_status, status, messages = self.hi_service.search_ihi(self.config["db_user"],surname,firstname,dob,sex)
        except soap.SOAPError as exc:
            logging.exception("SOAP failure")
            logstring = "<p>A SOAP network error occurred: <tt>{}</tt></p>".format(dbwrapper.html(str(exc)))
            logstring += self.logstring_boilerplate(patient)
            self.db.set_ihi_error(patient["fk_patient"],logstring)

        except socket.error as exc:
            if not self.db.is_retry():
                self.db.log_simple_entry(patient["fk_patient"],"Tried to get IHI but network down")
            raise  # try again later but don't tag patient as not completed.
        else:
            logging.info("search IHI returns {}".format(repr((ihi,record_status,status,messages))))
            if ihi is None and firstname is not None and len(messages) == 1 and messages[0]['code'] == '01439': # try again without firstname
                patient["firstname"] = None
                self.do_ihi_search(patient)
            else:
                self.deal_with_ihi_result(ihi,record_status,status,messages,patient)

    def deal_with_ihi_result(self,ihi,record_status,status,messages,patient,batch=False):
        error = False
        logstring = ""
        if record_status is None or status is None:
            error = True
        else:
            record_status = record_status.lower()
            status = status.lower()
        if batch:
            logstring += "<p>Running automatic refresh on IHI</p>"
        if ihi is None:
            error = True
            logstring = "<p>No IHI returned</p>"
        else:
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
            logstring += "<p>Retired means retired in the Medicare database. Contact Medicare to update details.</p>"
        if status == "expired":
            error = True
            logstring += "<p>Expired in the Medicare database, cannot be used. Contact Medicare to update details.</p>"
        if status == "resolved":
            error = True
            logstring += "<p>IHI is marked as &quot;resolved&quot; in the Medicare database. Contact Medicare to update details.</p>"
        if not error and status != "deceased" and status != "active":
            error = True
            logstring += "Unknown status, cannot be used. Contact Medicare for details"
        logstring += self.messages_to_table(messages)
        logstring += self.logstring_boilerplate(patient)
        if error:
            self.db.set_ihi_error(patient["fk_patient"],logstring)
        else:
            if self.db.ihi_duplicate_check(ihi,patient["fk_patient"]):
                if status == 'deceased':
                    self.db.mark_death_informed(patient["fk_patient"],logstring)
                else:
                    if "ihi" in patient and patient["ihi"] is not None and patient["ihi"] != ihi:
                        logstring += 'Previous IHI %s being replaced' % patient["ihi"]
                    self.db.set_ihi(patient["fk_patient"],ihi,logstring)
    
    def logstring_boilerplate(self,patient):
        logstring = "<p><table><tr><td>SOAP Request ID</td><td>{}</td></tr>".format(self.hi_service.soaper.outgoing_uuid)
        logstring += "<tr><td>SOAP reply ID</td><td>{}</td></tr>".format(self.hi_service.soaper.incoming_uuid)
        logstring +="<tr><td>Local record ID</td><td>{}</td></tr>".format(patient["fk_patient"])
        logstring += "<tr><td>Staff HPI-I</td><td>{}</td></tr>".format(self.db.staff["hpii"])
        logstring += "<tr><td>HPI-O</td><td>{}</td></tr>".format(self.db.staff["hpio"])
        logstring += "<tr><td>Web Service</td><td>{}</td></tr>".format(self.hi_service.ws_name)
        logstring += "<tr><td>Web Service Version</td><td>{}</td></tr>".format(self.hi_service.ws_version)
        logstring += "</table></p>"
        return logstring

    def script_printed(self,pid,payload):
        pdb.set_trace()
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
            request_code, receipt_code = self.medisecure.submit_script(items,consult_data,patient_data,observations)
        except:
            self.db.log_simple_entry(items[0]['fk_patient'],'MediSecure e-script error: %s' % dbwrapper.html(repr(sys.exc_info()[1])),linked_table='clin_prescribing.prescribed',fk_row=script_no)
        else:
            self.db.log_simple_entry(items[0]['fk_patient'],'MediSecure submitted. Request ID %s Response ID %s' % (request_code,receipt_code),linked_table='clin_prescribing.prescribed',fk_row=script_no)
            
    def invoice(self,pid,payload):
        if pid == self.db.pid:
            logging.debug('ignoring as PID is the same as ours')
            return # don't do anything with events we have caused
        for pk in self.db.get_all_private_invoices_to_upload():
            self.mo.upload_private_invoice(pk)
        self.db.commit()
