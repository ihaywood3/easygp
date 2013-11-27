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

# This code is not Medicare specific and does not refer to restricted information, therefore
# it can be released open-source. However it is not very useful without the Medicare specific drivers.

"""A basic wrapper around the EasyGP database"""

import select, time, logging, socket, re
import pdb
import psycopg2

CONSULT_TELEPHONE=2
CONSULT_EMAIL=4
CONSULT_TELECONFERENCE=7
CONSULT_ROOMS=1
CONSULT_HOME=3
CONSULT_NURSING_HOME=6
CONSULT_CONFERENCE=5
CONSULT_REVIEW=8
CONSULT_NOTES_NO_PATIENT=9
CONSULT_LEGACY_IMPORT=10
CONSULT_AUDIT=11
CONSULT_INBOX=12

AUDIT_FILE_IMPORT=20
AUDIT_PCEHR=36

def html(esc):
    esc = esc.replace("&","&amp;")
    esc = esc.replace("<","&lt;")
    esc = esc.replace(">", "&gt;")
    esc = esc.replace("\"","&quot;")
    return esc


import soap, socket, logging, sys

class DBWrapper:

    def __init__(self,config=None):
        if config is None:
            config = {'database':'easygp','db_user':'ian','host':'','port':None,'password':None}
        self.config = config
        self.conn = psycopg2.connect(database=config["database"],user=config["db_user"],host=config["host"],port=config["port"],password=config["password"])
        self.staff = None
        self.tasks_staff = None
        try:
            r = self.__query("select * from admin.vwstaffinclinics where logon_name = user limit 1")
            if len(r) == 0:
                logging.critical("no staff member found")
            else:
                self.staff = r[0]
                logging.debug("fk_staff is {}".format(self.staff["fk_staff"]))
            if self.config.has_key('tasks_user') and self.config['tasks_user'] != 'nobody':
                r = self.__query("select * from admin.vwstaffinclinics where logon_name = %s",(self.config["tasks_user"],))
                self.tasks_staff = r[0]
                logging.debug("tasks fk_staff is {}".format(self.tasks_staff["fk_staff"]))
            else:
                self.tasks_staff = self.staff
        except psycopg2.ProgrammingError as e:
            logging.critical(repr(e))
            self.conn.rollback()
        self.listeners = {}
        self.__events = set()
        self.__retry_mode = False

    def each_table(self,tbl,typs):
        """set of table names matching the provided regular expression"""
        return set((i['tblnam'] for i in self.__query("select nspname || '.' || relname as tblnam from pg_class, pg_namespace where relnamespace = pg_namespace.oid and (not relname ilike 'pg_%%') and nspname<>'information_schema' and nspname || '.' || relname ~ %s and position(relkind in %s) > 0",(tbl,typs))))

    def each_table_cols(self,tbl):
        """Set of column names of the listed table"""
        return set((i['attname'] for i in self.__query("select attname from pg_attribute, pg_class, pg_namespace where relnamespace = pg_namespace.oid and pg_class.oid = attrelid and nspname || '.' || relname = %s",(tbl,))))

    def each_foreign_constraint(self):
        """list all foreign key constraints in the DB"""
        return self.__query("select nspname || '.' || relname as tblnam, conname from pg_constraint, pg_class, pg_namespace where relnamespace = pg_namespace.oid and pg_class.oid = conrelid and contype='f'")

    def is_retry(self):
        """Return True if we are retrying an event after a network failure"""
        return self.__retry_mode
    
    def __query(self,q,params=()):
        cur = self.conn.cursor()
        cur.execute(q,params)
        r = [self.__makedict(cur.description,j) for j in cur.fetchall()]
        cur.close()
        return r
    
    def __makedict(self,desc,row):
        d = {}
        for i in range(0,len(desc)):
            d[desc[i][0]] = row[i]
        return d

    def __cmd(self,q,params):
        cur = self.conn.cursor()
        cur.execute(q,params)
        cur.close()
        self.conn.commit()
        
    def __cmd_query(self,q,params):
        cur = self.conn.cursor()
        cur.execute(q,params)
        r = [self.__makedict(cur.description,j) for j in cur.fetchall()]
        cur.close()
        self.conn.commit()
        return r

    def listen(self,channel,func):
        self.listeners[channel] = func
        self.__cmd("LISTEN {}".format(channel),())

    def notify(self,channel,param,cur=None):
        to_close = False
        if cur is None:
            cur = self.conn.cursor()
            to_close = True
        cur.execute("NOTIFY %s, '%s'" % (channel,param))
        if to_close: cur.close()

    def wait_events(self):
        pfd = self.conn.fileno()
        time.sleep(1)
        while True:
            logging.debug("select()")
            rfd, wfds, xfds = select.select([pfd],[],[],600)
            if pfd in rfd:
                self.conn.poll()
                while self.conn.notifies:
                    notify = self.conn.notifies.pop()
                    logging.debug("Got NOTIFY: {} {} {}".format(notify.pid, notify.channel, notify.payload))
                    self.__events.add((notify.channel,notify.payload))
            elif pfd in xfds:
                logging.error("fd {} returned error condition".format(pfd))
                sys.exit(1)
            else:
                # timeout
                logging.debug("timeout")
            try:
                for evt, param in self.__events.copy():
                    if self.listeners.has_key(notify.channel):
                        logging.debug("calling listener for channel {}".format(notify.channel))
                        self.listeners[notify.channel] (notify.pid,notify.payload)
                        self.__retry_mode = False
                        self.__events.discard((evt,param))
            except socket.error as exc:  # network error
                logging.exception("network error")
                self.__retry_mode = True

    def noop(self):
        cur = self.conn.cursor()
        cur.execute("select 1")
        cur.close()
        self.conn.commit()


    def synth_event(self,evt,payload):
        """synthemise an event, for debugging"""
        self.listeners[evt] (1234,payload)

    def get_patients_to_upload(self):
        return self.__query("select * from contacts.vwpatients where pcehr_consent='c' or pcehr_consent='h'")
    
    def patients_died_to_upload(self):
        return self.__query("select * from contacts.vwpatients where ihi is not null and deceased and pcehr_consent='v'")

    def patient_mark_death_informed(self,fk_patient,logentry):
        cur = self.conn.cursor()
        cur.execute("update clerical.data_patients set ihi_updated=now(),pcehr_consent='d' where pk=%s",(fk_patient,))
        fk_consult = self.make_consult(cur,fk_patient)
        self.make_audit(cur,fk_consult,logentry,fk_patient)
        cur.close()
        self.conn.commit()

    def get_scripts(self,script_no):
        return self.__query("select * from clin_prescribing.vwprescribeditems where escript_uploaded is false and script_number = %s",(script_no,))
    
    def get_prescriber_data(self,fk_consult):
        q = """
select s.*
  from admin.vwstaffinclinics s, clin_consult.consult c
where c.pk = %s and c.fk_staff = s.fk_staff"""
        r = self.__query(q,(fk_consult,))
        if len(r) == 0: return None
        return r[0]

    def escript_mark_uploaded(self, script, logentry):
        cur = self.conn.cursor()
        cur.execute("update clin_prescribing.prescribed set escript_uploaded='t' where pk=%s",(script["fk_prescribed"],))
        fk_consult = self.make_consult(cur,script['fk_patient'])
        self.make_audit(cur,fk_consult,logentry,script['fk_patient'])
        cur.close()
        self.conn.commit()

    def get_patient(self,fk_patient):
        return self.__query("select * from contacts.vwpatients where fk_patient=%s", (fk_patient,))[0]
    
    def get_person_comms(self,fk_person):
        return self.__query("select * from contacts.vwpersonscomms where fk_person=%s and confidential is not true",(fk_person,))

    def get_staff_comms(self,fk_person,fk_branch):
        return self.__query("""
select value,note,fk_type,type,preferred_method from contacts.vwpersonscomms where fk_person=%s and confidential is not true
   union
select value,note,fk_type,type,preferred_method from contacts.vwbranchescomms where fk_branch=%s and confidential is not true""",(fk_person,fk_branch))

    def set_ihi(self,fk_patient,ihi,logentry):
        cur = self.conn.cursor()
        cur.execute("update clerical.data_patients set ihi=%s,ihi_updated=now(),pcehr_consent='v' where pk=%s",(ihi,fk_patient))
        fk_consult = self.make_consult(cur,fk_patient)
        self.make_audit(cur,fk_consult,logentry,fk_patient)
        self.notify("ihi_update",fk_patient,cur)
        cur.close()
        self.conn.commit()  
                     
    def set_ihi_error(self,fk_patient,logentry):
        cur = self.conn.cursor()
        cur.execute("update clerical.data_patients set pcehr_consent='e',ihi=null where pk=%s",(fk_patient,))
        fk_consult = self.make_consult(cur,fk_patient)
        self.make_audit(cur,fk_consult,logentry,fk_patient)
        self.make_task(cur,fk_consult,"Problem with IHI for patient",logentry)
        self.notify("ihi_update",fk_patient,cur)
        cur.close()   
        self.conn.commit()

    def ihi_duplicate_check(self,ihi,fk_patient):
        """chech for duplicate IHI, 
        if duplicate, log errors and return False
        otherwise true"""
        cur = self.conn.cursor()
        cur.execute("select fk_patient, wholename, birthdate from contacts.vwpatients where fk_patient <> %s and ihi = %s", (fk_patient, ihi))
        r = cur.fetchall()
        if len(r) == 0: return True
        other_fk_patient = r[0][0]
        other_patient_details = "%s DOB: %s" % (r[0][1], r[0][2].strftime("%d/%m/%Y"))
        cur.execute("select wholename, birthdate from contacts.vwpatients where fk_patient = %s",(fk_patient,))
        other_patient_details = "%s DOB: %s" % (r[0][1], r[0][2].strftime("%d/%m/%Y"))
        r = cur.fetchall()
        patient_details = "%s DOB: %s" % (r[0][0], r[0][1].strftime("%d/%m/%Y"))
        fk_consult = self.make_consult(cur,fk_patient)
        self.make_audit(cur,fk_consult,"Medicare returned IHI %s, but it is the same as for patient '%s' who is already in the darabase" % (ihi,other_patient_details),fk_patient)
        self.make_task(cur,fk_consult, "Duplicate IHIs","Medicare returned IHI %s for patient %s, but our database has the same IHI for patient %s" % (ihi,patient_details,other_patient_details))
        fk_consult = self.make_consult(cur,other_fk_patient)
        self.make_audit(cur,fk_consult,"Medicare returned the same IHI for another patient %s" % patient_details,other_fk_patient)
        # Medicare specs require both patients IHIs be disabled
        cur.execute("update clerical.data_patients set pcehr_consent='e' where pk=%s",(fk_patient,))
        cur.execute("update clerical.data_patients set pcehr_consent='e' where pk=%s",(other_fk_patient,))
        self.notify("ihi_update",fk_patient,cur)
        self.notify("ihi_update",other_fk_patient,cur)
        cur.close()
        self.conn.commit()
        return False
        

    def log_simple_entry(self,fk_patient,error,fk_row=None,linked_table='clerical.data_patients'):
        cur = self.conn.cursor()
        fk_consult = self.make_consult(cur,fk_patient)
        if fk_row is None: fk_row = fk_patient
        self.make_audit(cur,fk_consult,error,fk_patient,linked_table=linked_table)
        cur.close()
        self.conn.commit()

    def get_ihis_for_refresh(self):
        return self.__query("select * from contacts.vwpatients where age(ihi_updated) > '1 year'::interval and pcehr_consent='v' and ihi is not null limit 99")
        
    def make_consult(self,cur,fk_patient,fk_type=CONSULT_AUDIT):
        cur.execute("insert into clin_consult.consult (fk_staff,fk_patient,fk_type,consult_date) values(%s,%s,%s,now()) returning (pk)",(self.staff["fk_staff"],fk_patient,fk_type))
        return cur.fetchone()[0]

    def make_audit(self,cur,fk_consult,logentry,fk_row=0,fk_audit_action=AUDIT_PCEHR,linked_table='clerical.data_patients'):
        cur.execute("insert into clin_consult.progressnotes (fk_consult,linked_table,fk_row,fk_section,fk_audit_action,notes) values (%s,%s,%s,0,%s,%s)",(fk_consult,linked_table,fk_row,fk_audit_action,logentry))
    
    def make_task(self,cur,fk_consult,title,description):
        # need to clean up HTML tags here
        description = re.sub('<[^>]+>','',description)
        description = description.replace('&amp;','&')
        description = description.replace('&lt;','<')
        description = description.replace('&gt;','>')
        cur.execute("insert into clerical.tasks (related_to,fk_staff_filed_task,fk_role_can_finalise) values (%s,%s,7) returning (pk)",(title,self.staff["fk_staff"]))
        pk_task = cur.fetchone()[0]
        cur.execute("""
insert into clerical.task_components (fk_task,fk_consult,date_logged,fk_staff_allocated,details,fk_staff_filed) 
        values (%s,%s,now(),%s,%s,%s)
""",(pk_task,fk_consult,self.tasks_staff["fk_staff"],description,self.staff["fk_staff"])) 

    def get_obs(self,fk_patient):
        q = self.__query("select distinct on (fk_type) fk_type, consult_date, measurement from clin_measurements.vwmeasurements where fk_patient =%s and (fk_type = 2 or fk_type= 4) order by fk_type,consult_date desc",(fk_patient,))
        return {i['fk_type']:i for i in q}

if __name__=='__main__':
    import daemon
    import sys
    db = DBWrapper({"database":"easygp","user":"ian","port":5432,"host":"localhost","password":"denethor"})
    print db.get_patient(1)
    pdb.set_trace()
