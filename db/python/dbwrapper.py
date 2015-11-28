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

import select, time, socket, re
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


import socket, logging, sys

try:
    import soap
except: pass

class DBError(Exception):
    pass

class DBWrapper:

    def __init__(self,config=None,no_staff=False):
        if config is None:
            config = {'database':'easygp','db_user':'ian','host':'','port':None,'password':None}
        self.config = config
        self.conn = psycopg2.connect(database=config["database"],user=config["db_user"],host=config["host"],port=config["port"],password=config["password"])
        self.staff = None
        self.tasks_staff = None
        if not no_staff:
            try:
                r = self.query("select * from admin.vwstaffinclinics where logon_name = user limit 1")
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
        self.pid = self.conn.get_backend_pid()
        self.__retry_mode = False

    def get_location_id(self):
        return self.staff['hic_location_id']

    def each_table(self,tbl='.*',typs='r'):
        """set of table names matching the provided regular expression"""
        return set((i['tblnam'] for i in self.query("select nspname || '.' || relname as tblnam from pg_class, pg_namespace where relnamespace = pg_namespace.oid and (not relname ilike 'pg_%%') and nspname<>'information_schema' and nspname || '.' || relname ~ %s and position(relkind in %s) > 0",(tbl,typs))))

    def each_table_cols(self,tbl):
        """Set of column names of the listed table"""
        return set((i['attname'] for i in self.query("select attname from pg_attribute, pg_class, pg_namespace where relnamespace = pg_namespace.oid and pg_class.oid = attrelid and nspname || '.' || relname = %s",(tbl,))))

    def column_type(self,tbl,col):
        """Type name of a particular column"""
        q= self.query("select typname from pg_type,pg_attribute, pg_class, pg_namespace where relnamespace = pg_namespace.oid and pg_class.oid = attrelid and pg_type.oid = atttypid and nspname || '.' || relname = %s and attname = %s",(tbl,col))
        if len(q) == 0: return None
        return q[0]['typname']

    def column_notnull(self,tbl,col):
        """Whether particular column has the NOT NULL constraint"""
        q= self.query("select attnotnull from pg_attribute, pg_class, pg_namespace where relnamespace = pg_namespace.oid and pg_class.oid = attrelid and nspname || '.' || relname = %s and attname = %s",(tbl,col))
        if len(q) == 0: return None
        return q[0]['attnotnull']
    
    def each_foreign_constraint(self):
        """list all foreign key constraints in the DB, dict keyed by table, dict keyed by column"""
        q = self.query("""
select k.conname, n1.nspname || '.' || c1.relname as tbl, a1.attname as col, n2.nspname || '.' || c2.relname as tbl2, a2.attname as col2  from 
pg_constraint k, 
pg_class c1, pg_namespace n1, pg_attribute a1,
pg_class c2, pg_namespace n2, pg_attribute a2
 where 
   c1.relnamespace = n1.oid and 
   c1.oid = k.conrelid and contype='f' and
   k.confrelid = c2.oid and n2.oid = c2.relnamespace and
   k.conkey[1] = a1.attnum and a1.attrelid = c1.oid and
   k.confkey[1] = a2.attnum and a2.attrelid = c2.oid
   """)
        r = {}
        for i in q:
            if not i['tbl'] in r: r[i['tbl']] = {}
            r[i['tbl']][i['col']] = {'table':i['tbl2'],'col':i['col2'],'constraint':i['conname']}
        return r

    def is_retry(self):
        """Return True if we are retrying an event after a network failure"""
        return self.__retry_mode
    
    def query(self,q,params=(),cur=None):
        if cur is None: 
            c = self.conn.cursor()
        else:
            c = cur
        c.execute(q,params)
        r = [self.__makedict(c.description,j) for j in c.fetchall()]
        if cur is None: c.close()
        return r


    def wipe_invoices(self):
        cur = self.cursor()
        cur.execute("truncate billing.invoices cascade")
        cur.execute("truncate billing.claims cascade")
        cur.close()

    def insert_table(self,tbl,fields,cur):
        fieldlist = []
        valuelist = []
        params = []
        for f,v in fields.items():
            fieldlist.append(f)
            valuelist.append('%s')
            params.append(v)
        fieldlist = ','.join(fieldlist)
        valuelist = ','.join(valuelist)
        cur.execute("insert into {} ({}) values ({}) returning (pk)".format(tbl,fieldlist,valuelist),tuple(params))
        r = cur.fetchall()
        return r[0][0]
    
    def insert_invoice(self,**kwargs):
        items = kwargs.get('items',[])
        payments = kwargs.get('payments',[])
        cur = self.cursor()
        if not 'online' in kwargs: kwargs['online'] = True
        if 'items' in kwargs: del kwargs['items']
        if 'payments' in kwargs: del kwargs['payments']
        if 'fk_staff' in kwargs: 
            kwargs['fk_staff_provided_service'] = kwargs['fk_staff']
            del kwargs['fk_staff']
        if not 'fk_staff_invoicing' in kwargs: kwargs['fk_staff_invoicing'] = kwargs['fk_staff_provided_service']
        pk = self.insert_table('billing.invoices',kwargs,cur)
        for i in items:
            if type(i) is str: # like string '23'
                i = {'item':i,'type':'Schedule Fee'}
            i['fk_invoice'] = pk
            if 'item' in i:
                if not 'type' in i: i['type'] = 'Schedule Fee'
                query = "select fk_lu_billing_type,price,fk_fee_schedule from billing.vwfees where mbs_item=%s and fee_type=%s"
                if 'number_of_patients' in i:
                    query += " and number_of_patients=%d" % i['number_of_patients']
                else:
                    query += " and number_of_patients=0"
                cur.execute(query,(i['item'],i['type']))
                x = cur.fetchone()
                del i['item']
                if 'type' in i: del i['type']
                i['fk_fee_schedule'] = x[2]
                i['fk_lu_billing_type'] = x[0]
                if not 'amount' in i: i['amount'] = x[1]
            self.insert_table('billing.items_billed',i,cur)
        for i in payments:
            i['fk_invoice'] = pk
            self.insert_table('billing.payments_received',i,cur)
        cur.close()
        self.commit()
        return pk
        
    def cursor(self):
        return self.conn.cursor()

    def commit(self):
        self.conn.commit()

    def rollback(self):
        self.conn.rollback()
    
    def __makedict(self,desc,row):
        d = {}
        for i in range(0,len(desc)):
            d[desc[i][0]] = row[i]
        return d

    def listen(self,channel,func):
        self.listeners[channel] = func
        cur = self.cursor()
        cur.execute("LISTEN {}".format(channel))
        cur.close()
        self.commit()

    def notify(self,channel,param,cur=None):
        to_close = False
        if cur is None:
            cur = self.cursor()
            to_close = True
        cur.execute("NOTIFY %s, '%s'" % (channel,param))
        if to_close: cur.close()

    def __grab_events(self):
        self.conn.poll()
        self.__has_events = False
        while self.conn.notifies:
            notify = self.conn.notifies.pop()
            logging.debug("Got NOTIFY: {} {} {}".format(notify.pid, notify.channel, notify.payload))
            self.__events.add((notify.channel,notify.payload,notify.pid))
            self.__has_events = True

    def __process_events(self):
        for evt, param, pid in self.__events.copy():
            if self.listeners.has_key(evt):
                logging.debug("calling listener for channel {}".format(param))
                self.listeners[evt] (pid,param)
                self.__retry_mode = False
                self.__events.discard((evt,param,pid))

    def wait_events(self):
        pfd = self.conn.fileno()
        time.sleep(1)
        while True:
            self.__has_events = False
            self.conn.commit()
            logging.debug("select()")
            rfd, wfds, xfds = select.select([pfd],[],[],600)
            if pfd in rfd:
                self.__grab_events()
            elif pfd in xfds:
                logging.error("fd {} returned error condition".format(pfd))
                sys.exit(1)
            else:
                # timeout
                logging.debug("timeout")
            try:
                while self.__has_events:
                    self.__process_events()
                    self.__grab_events()
            except socket.error as exc:  # network error
                logging.exception("network error")
                self.__retry_mode = True

    def noop(self):
        cur = self.cursor()
        cur.execute("select 1")
        cur.close()
        self.commit()


    def synth_event(self,evt,payload):
        """synthemise an event, for debugging"""
        self.listeners[evt] (1234,payload)

    def get_patients_to_upload(self):
        return self.query("select * from contacts.vwpatients where pcehr_consent='c' or pcehr_consent='h'")
    
    def patients_died_to_upload(self):
        return self.query("select * from contacts.vwpatients where ihi is not null and deceased and pcehr_consent='v'")

    def patient_mark_death_informed(self,fk_patient,logentry):
        cur = self.cursor()
        cur.execute("update clerical.data_patients set ihi_updated=now(),pcehr_consent='d' where pk=%s",(fk_patient,))
        fk_consult = self.make_consult(cur,fk_patient)
        self.make_audit(cur,fk_consult,logentry,fk_patient)
        cur.close()
        self.commit()

    def get_scripts(self,script_no):
        return self.query("select * from clin_prescribing.vwprescribeditems where escript_uploaded is false and script_number = %s",(script_no,))
    
    def get_prescriber_data(self,fk_consult):
        q = """
select s.*
  from admin.vwstaffinclinics s, clin_consult.consult c
where c.pk = %s and c.fk_staff = s.fk_staff"""
        r = self.query(q,(fk_consult,))
        if len(r) == 0: return None
        return r[0]

    def escript_mark_uploaded(self, script, logentry):
        cur = self.cursor()
        cur.execute("update clin_prescribing.prescribed set escript_uploaded='t' where pk=%s",(script["fk_prescribed"],))
        fk_consult = self.make_consult(cur,script['fk_patient'])
        self.make_audit(cur,fk_consult,logentry,script['fk_patient'])
        cur.close()
        self.commit()

    def get_patient(self,fk_patient=None,fk_person=None):
        if fk_person is None:
            return self.query("select * from contacts.vwpatients where fk_patient=%s", (fk_patient,))[0]
        else:
            return self.query("select * from contacts.vwpatients where fk_person=%s", (fk_person,))[0]

    def get_person_comms(self,fk_person):
        return self.query("select * from contacts.vwpersonscomms where fk_person=%s and confidential is not true",(fk_person,))

    def get_staff_comms(self,fk_person,fk_branch):
        return self.query("""
select value,note,fk_type,type,preferred_method from contacts.vwpersonscomms where fk_person=%s and confidential is not true
   union
select value,note,fk_type,type,preferred_method from contacts.vwbranchescomms where fk_branch=%s and confidential is not true""",(fk_person,fk_branch))

    def set_ihi(self,fk_patient,ihi,logentry):
        cur = self.cursor()
        cur.execute("update clerical.data_patients set ihi=%s,ihi_updated=now(),pcehr_consent='v' where pk=%s",(ihi,fk_patient))
        fk_consult = self.make_consult(cur,fk_patient)
        self.make_audit(cur,fk_consult,logentry,fk_patient)
        self.notify("ihi_update",fk_patient,cur)
        cur.close()
        self.commit()  
                     
    def set_ihi_error(self,fk_patient,logentry):
        cur = self.cursor()
        cur.execute("update clerical.data_patients set pcehr_consent='e',ihi=null where pk=%s",(fk_patient,))
        fk_consult = self.make_consult(cur,fk_patient)
        self.make_audit(cur,fk_consult,logentry,fk_patient)
        self.make_task(cur,fk_consult,"Problem with IHI for patient",logentry)
        self.notify("ihi_update",fk_patient,cur)
        cur.close()   
        self.commit()

    def ihi_duplicate_check(self,ihi,fk_patient):
        """chech for duplicate IHI, 
        if duplicate, log errors and return False
        otherwise true"""
        cur = self.cursor()
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
        self.commit()
        return False
        

    def log_simple_entry(self,fk_patient,error,fk_row=None,linked_table='clerical.data_patients'):
        cur = self.cursor()
        fk_consult = self.make_consult(cur,fk_patient)
        if fk_row is None: fk_row = fk_patient
        self.make_audit(cur,fk_consult,error,fk_patient,linked_table=linked_table)
        cur.close()
        self.commit()

    def get_ihis_for_refresh(self):
        return self.query("select * from contacts.vwpatients where age(ihi_updated) > '1 year'::interval and pcehr_consent='v' and ihi is not null limit 99")
        
    def make_consult(self,cur,fk_patient,fk_type=CONSULT_AUDIT):
        return self.query("insert into clin_consult.consult (fk_staff,fk_patient,fk_type,consult_date) values(%s,%s,%s,now()) returning (pk)",(self.staff["fk_staff"],fk_patient,fk_type),cur)[0]["pk"]

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
        q = self.query("select distinct on (fk_type) fk_type, consult_date, measurement from clin_measurements.vwmeasurements where fk_patient =%s and (fk_type = 2 or fk_type= 4) order by fk_type,consult_date desc",(fk_patient,))
        return {i['fk_type']:i for i in q}

    def create_new_oid(self,ancestor,description,sct=None):
        o = self.query("select max(substring(toid from %s for '#')::integer)+1 as newarc from coding.lu_oid where toid similar to %s", (ancestor+'.#"[0-9]+#"',ancestor+".[0-9]+"))
        c = self.cursor()
        newoid = ancestor + '.' + str(o[0]["newarc"] or 1)
        c.execute("insert into coding.lu_oid (mode,toid,description,sct) values ('c',%s,%s,%s)",(newoid,description,sct))
        c.close()
        self.commit()
        return newoid

    def get_bb_invoices_to_upload(self):
        """return bulk-billing invoices that haven't been grouped into claims yet. As a dictionary of lists of invoices keyed on (fk_branch,f_staff)"""
        inv =  self.query("select * from billing.vwinvoices where online and fk_claim is null and fk_lu_bulk_billing_type = 1")
        ret = {}
        for i in inv:
            i['items_billed'] = self.query("select * from billing.vwitemsbilled where fk_invoice = %s", (i['fk_invoice'],))
            k = (i['fk_branch'],i['fk_staff_provided_service'])
            if not k in ret: ret[k] = []
            ret[k].append(i)
        return ret

    def get_all_private_invoices_to_upload(self):
        return [i["pk"] for i in self.query("select pk from billing.invoices where result_code=4005")]

    def get_private_invoice_to_upload(self,pk_invoice):
        c = self.cursor()
        inv = self.query("select * from billing.vwinvoices where pk_invoice=%s",(pk_invoice,),c)
        if len(inv) == 0: raise DBError("No such invoice %s" % pk_invoice)
        inv = inv[0]
        inv['items_billed'] = self.query("select * from billing.vwitemsbilled where fk_invoice = %s", (inv['fk_invoice'],),c)
        n = 1
        for i in inv['items_billed']:
            s = "{0:04}".format(n)
            c.execute("update billing.items_billed set service_id=%s where pk=%s",(s,i['pk_items_billed']))
            i['service_id'] = s
            n += 1
        c.close()
        self.commit()
        return inv

    def get_claims_awaiting_processing_report(self):
        """claims successfully transmitted but no report as yet"""
        return self.query("select * from billing.claims where processing_report_run_date is null and age(claim_date) > '1 day' and result_code=0")

    def get_recent_claims(self,months):
        """all claims within last so many months"""
        return self.query("select * from billing.vwclaims where age(claim_date) < '%d month'" % months)

    def get_claims_awaiting_payment_report(self):
        """claims successfully transmitted but no report as yet"""
        return self.query("select * from billing.claims where payment_report_run_date is null and age(claim_date) > '1 day' and result_code=0")

    def get_claims_awaiting_transmission(self):
        """claims saved but needing transmission"""
        return self.query("select * from billing.claims where result_code=4008")

    def get_outstanding_claims(self):
        """The union of the above: all claims waiting for 'something' to happen to them"""
        return self.query("select * from billing.vwclaims where result_code=4008 or payment_report_run_date is null or processing_report_run_date is null")

    def get_claim(self,claim_id):
        """get a claim by its ID, surprisingly useful"""
        return self.query("select * from billing.claims where claim_id=%s",(claim_id,))[0]

    def get_invoices_on_claim(self,claim_pk):
        inv = self.query("select * from billing.vwinvoices where fk_claim=%s", (claim_pk,))
        for i in inv: 
            i['items_billed'] = self.query("select * from billing.vwitemsbilled where fk_invoice = %s", (i['fk_invoice'],))
        return inv

    def create_claim(self,fk_branch,invoices_to_link):
        c = self.cursor()
        c.execute("insert into billing.claims(fk_branch,provider_number,result_code) values (%s,%s,4008) returning (pk)",(fk_branch,invoices_to_link[0]['staff_provided_service_provider_number']))
        pk = c.fetchone()[0]
        claim_id = "{0}{1:04d}@".format(chr(ord('B')+(pk/9999)),pk % 9999)
        c.execute("update billing.claims set claim_id=%s where pk=%s",(claim_id,pk))
        logging.debug("created claim {}".format(claim_id))
        voucher = 1
        service_id = 1
        for i in invoices_to_link:
            if voucher < 10: 
                s = '0'+str(voucher)
            else:
                s = str(voucher)
            c.execute("update billing.invoices set fk_claim=%s,voucher_id=%s,result_code=4007 where pk=%s",(pk,s,i['fk_invoice']))
            i['voucher_id'] = s
            logging.debug("joining invoice PK {} to claim {} as voucher {}".format(i['fk_invoice'],claim_id,s))
            voucher += 1
            for j in i['items_billed']:
                s = "{0:04}".format(service_id)
                j['service_id'] = s
                c.execute("update billing.items_billed set service_id=%s where pk=%s",(s,j['pk_items_billed']))
                logging.debug("joining item PK {} to claim {} as service {}".format(j['pk_items_billed'],claim_id,s))
                service_id += 1
        c.close()
        self.commit()
        claim = {}
        claim['pk'] = pk
        claim['claim_id'] = claim_id
        claim['fk_branch'] = fk_branch
        return claim

  
    def set_claim_return(self,claim_id,return_code,return_text):
        c = self.cursor()
        c.execute("update billing.claims set result_code=%s,result_text=%s, claim_date=now() where claim_id=%s",(return_code,return_text,claim_id))
        logging.debug("claim {} set to {} {}".format(claim_id,return_code,repr(return_text)))
        c.close()
        self.commit()

    def set_invoice_return(self,fk_invoice,return_code,return_text,pms_claim_id=None,error_level=None):
        c = self.cursor()
        if pms_claim_id is None:
            c.execute("update billing.invoices set result_code=%s,result_text=%s,error_level=%s where pk=%s",(return_code,return_text,error_level,fk_invoice))
        else:
            c.execute("update billing.invoices set result_code=%s,result_text=%s,pms_claim_id=%s,error_level=%s where pk=%s",(return_code,return_text,pms_claim_id,error_level,fk_invoice))
        c.execute("notify invoice_print, '%s'" % fk_invoice)
        c.close()
        logging.debug("invoice PK {} set to {} {}".format(fk_invoice,return_code,repr(return_text)))
        self.commit()  

    def set_item_code(self,pk_invoice,service_id,reason_code,comment,error_level=None):
        c = self.cursor()
        c.execute("update billing.items_billed set reason_code=%s,comment=%s,error_level=%s where fk_invoice=%s and service_id=%s", (reason_code,comment,error_level,pk_invoice,service_id))
        logging.debug("item service id {} set to {} {}".format(service_id,reason_code,repr(comment)))
        c.close()


    def set_payment_report(self,pk_claim,report,pms_claim_id=None):
        c = self.cursor()
        c.execute("update billing.claims set payment_report=%s, payment_report_run_date=now() where pk=%s",(report,pk_claim))
        if pms_claim_id:
            c.execute("update billing.invoices set pms_claim_id=%s where fk_claim=%s", (pms_claim_id, pk_claim))
        c.close()
        logging.debug("setting payment report for claim PK {} to {}".format(pk_claim,repr(report)))
        self.commit()

    def set_processing_report(self,pk_claim,claim_id,report):
        c = self.cursor()
        c.execute("update billing.claims set processing_report_run_date=now() where pk=%s",(pk_claim,))
        logging.debug("setting processing report for claim {} (PK {}) to {}".format(claim_id,pk_claim,repr(report)))
        for r in report:
            inv = self.query("""
select i.result_text,i.pk as pk_invoice, b.pk as pk_item from billing.invoices i, billing.items_billed b 
where i.fk_claim=%s and b.service_id=%s and b.fk_invoice = i.pk""",(pk_claim,r['service_id']),c)
            if len(inv) != 1:
                logging.warn("couldn't find invoice for claim {} service id {}".format(claim_id,r['service_id']))
            inv = inv[0]
            c.execute("update billing.items_billed set reason_code=%s,comment=%s,error_level=%s where pk=%s", (r['reason_code'],r['comment'],r.get('error_level',None),inv['pk_item']))
            if r['amount'] > 0:
                c.execute("insert into billing.payments_received (fk_invoice,fk_lu_payment_method,referent,amount) values (%s,5,%s,%s*'$0.01'::money)", (inv['pk_invoice'],"claim {} service id {}".format(claim_id,r['service_id']),r['amount']))
            c.execute("update billing.invoices set result_code=4006 where pk=%s",(inv['pk_invoice'],))
        c.close()
        self.commit()

    def get_bank_details(self, fk_invoice):
        c = self.cursor()
        r = self.query("select bsb, account_number, account_name from billing.bank_details where fk_invoice=%s", (fk_invoice,),c)
        # don't delete yet as we need it to print invoices.
        #c.execute("delete from billing.bank_details where fk_invoice=%s",(fk_invoice,))
        c.close()
        if len(r) > 0:
            return (r[0]['account_name'],r[0]['bsb'],r[0]['account_number'])
        else:
            logging.warn("can't find bank details for invoice PK {}".format(fk_invoice))
            return (None, None, None)


if __name__=='__main__':
    import daemon
    import sys
    db = DBWrapper({"database":"easygp","user":"ian","port":5432,"host":"localhost","password":"denethor"})
    print db.get_patient(1)
    pdb.set_trace()
