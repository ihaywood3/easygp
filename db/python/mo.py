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

# This code does not refer to any restricted information, it communicates
# with a closed-source Java module using a line-based API spec developed
# by myself (Ian Haywood)

"""A class for making Medicare Online billing submissions
"""

import subprocess, os.path, pdb, time, logging, re, datetime, time, select

medicare_flags = {
            'A':'Patient identification amended', 
            'I':'Patient Medicare Issue number changed, new number {} - {}', 
            'C':'Patient Medicare Number changed to {} - {}', 
            'W':'Patient card used will expire shortly', 
            'S':'Patient card expired. Future services may be rejected. New number may be {} - {}', 
            'X':'Old Medicare issue number for patient. Future services may be rejected. New number may be {} - {}', 
            ' ':'No change'}

class MedicareError(Exception):
    def __init__(self,line,number=4012):
        m = re.match("ERROR:(.*): *([0-9]+)",line)
        if m:
            number = int(m.group(2))
            line = m.group(1)
        Exception.__init__(self,line)
        self.number = number

class MedicareOnline:
    def __init__(self, java_path, passphrase, sender, location_id):
        self.passphrase = passphrase
        self.java_path = java_path
        self.sender = sender
        self.location_id = location_id
        self.start_process()

    def start_process(self):
        logging.info("starting Java slave process hiconline.sender={} hiconline.location_id={} java path {}".format(self.sender,self.location_id,self.java_path))
        self.pro = subprocess.Popen(["/usr/bin/java","-classpath","lib:lib/*:build","-Djava.library.path=lib","-Dhiconline.sender={}".format(self.sender),"-Dhiconline.passphrase={}".format(self.passphrase),"-Dhiconline.location_id={}".format(self.location_id),"HICOnline"],cwd=self.java_path,stdin=subprocess.PIPE,stderr=subprocess.STDOUT,stdout=subprocess.PIPE,close_fds=True)
        self.logic_packs = {}
        self.get_cert_expiry()

    def cycle_process(self):
        try:
            self.pro.kill()
        except:
            logging.exception("problem killing process")
        self.pro = None
        self.start_process()

    def clean(self,s,maxlen=40):
        s = ''.join(c for c in s if ord(c) >= 32)
        s = s[:maxlen]
        return s

    def _write(self,cmd,*params):
        try:
            s = cmd+"|"+"|".join((str(s) for s in params))+"\n"
            #logging.debug("_write {}".format(repr(s)))
            self.pro.stdin.write(s)
            self.pro.poll()
        except IOError:
            e = self.pro.stdout.read()
            logging.error("java process had IOError on _write returning %r" % e)
            raise MedicareError(e)
        if not self.pro.returncode is None and self.pro.returncode <> 0:
            line = self.pro.stdout.read()
            logging.error("java process had non-zero exit on _write returning %r" % line)
            self._setup()
            raise MedicareError(line)

    def _read(self,extra=None):
        cont = True
        f = self.pro.stdout
        while cont:
            r, w, e = select.select([ f ], [], [], 120.0)
            if not f in r: raise MedicareError("Java slave has hanged")
            line = f.readline()
            self.pro.poll()
            if not self.pro.returncode is None and self.pro.returncode <> 0:
                logging.error("java layer had IOError on _read returning %r" % line)
                self._setup()
                raise MedicareError(line)
            r = line.strip()
            m = re.match("ERROR:.*",r)
            if m:
                logging.error("Java layer sent us ERROR line: %r" % line)
                raise MedicareError(line)
            try:
                v = int(r)
                cont = False
            except ValueError:
                logging.debug("extra data: {}".format(repr(r)))
        if extra:
            line = self.pro.stdout.readline()
            line = line.strip()
            #logging.debug("-> {} {}".format(v, repr(line)))
            return (v, line)
        else:
            #logging.debug("-> {}".format(v))
            return v

    def create_object(self, obj, path, value):
        desc = "CreateBusinessObject({},{},{})".format(repr(obj),repr(path),repr(value))
        logging.debug(desc)
        self._write("CBO",obj, path, value)
        v, val = self._read(True)
        if v != 0: raise MedicareError("{} returned {}".format(desc,v),v)
        return val

    def set(self, path, elem, value):
        desc = "SetBusinessObject({},{},{})".format(repr(path),repr(elem),repr(value))
        logging.debug(desc)
        if value is None:
            logging.warn("not setting as None value")
        self._write("SBO", path, elem, value)
        v = self._read()
        if v == 9201: raise MedicareError("{} has invalid format for value".format(desc),9201)
        if v == 9202: raise MedicareError("{} has invalid value".format(desc),9202)
        if v != 0: raise MedicareError("{} returned code {}".format(desc,v),v)

    def get_logic_pack(self, pack):
        if pack in self.logic_packs:
            return self.logic_packs[pack]
        self._write("GLPV", pack)
        code, s = self._read(True)
        if code != 0: raise MedicareError("GLP returned "+str(v),v)
        s = s.strip()[1:-1].split(",")[0]
        self.logic_packs[pack] = s
        return s

    def get_cert_expiry(self):
        self._write("GCEX")
        code, v = self._read(True)
        if code != 0: raise MedicareError("GCEX returned "+str(v),v)
        days = int(v)
        d = datetime.date.fromordinal(days+datetime.date.today().toordinal())
        if days > 30:
            logging.info("Location certificate has %d days to expiry, that's %s" % (days,d.strftime('%A, %d %B %Y')))
        else:
            logging.warn("Location certicate will expire in %d days, that's %s" % (days,d.strftime('%A, %d %B %Y')))
        

    def create_report(self, report, param):
        l = "CreateReport({},{})".format(repr(report),repr(param))
        logging.debug(l)
        self._write("CR",report, param)
        v = self._read()
        if v == 0: return True
        if v == 8002: return False
        if v == 2023: return False
        if v != 0: raise MedicareError("{} returned {}".format(l,v),v)

    def get(self, elem):
        logging.debug("GetReportElement({})".format(repr(elem)))
        self._write("GRE", elem)
        v, val = self._read(True)
        if v == 9205: return None  # 9205 == "requested data item is empty"
        if v != 0: raise MedicareError("GRE returned "+str(v),v)
        return val

    def next(self):
        logging.debug("NextReportRecord")
        self._write("NRR")
        v = self._read()
        if v == 0: return True
        if v == 8002: return False
        raise MedicareError("NRR returned "+str(v),v)

    def accept(self):
        logging.debug("acceptContent()")
        self._write("ACT")
        v = self._read()
        if v == 0: return
        raise MedicareError("ACT returned "+str(v),v)


    def is_report_available(self):
        self._write("IRA")
        logging.debug("IsReportAvailable")
        v = self._read()
        if v == 0 or v == 9501: return True
        if v == 2027 or v == 8002: return False
        raise MedicareError("IRA returned "+str(v),v)

    def send_content(self,content_type):
        logging.debug("SendContent")
        self._write("SC", content_type)
        return self._read()

    def quit(self):
        self._write("QUIT")
        self._read()
        self.pro.close()

    def reset(self):
        self._write("RST")
        v = self._read()
        if v != 0: raise MedicareError("RST returned "+v,v)

    def prepare_bb_reports(self,fk_staff_only=None):
        bb = self.db.get_bb_invoices_to_upload()
        claims = []
        for k in bb:
            fk_branch, fk_staff = k
            if fk_staff_only is not None and fk_staff != fk_staff_only: continue
            invoices = bb[k]
            invoices = sorted(invoices,key=lambda x: x['visit_date'])
            #if len(invoices) < 10:
            #    if datetime.date.today().toordinal() - invoices[0]['visit_date'].toordinal() < 14: continue
            while len(invoices) > 0:
                claims.append(self.db.create_claim(fk_branch,invoices[:50]))
                invoices = invoices[50:]
        return claims
    
    def transmit_claim(self,claim, invoices=None):
        claim_id = claim["claim_id"]
        try:
            logic_pack = self.get_logic_pack("HIC/HolClassic")
            if invoices is None: invoices = self.db.get_invoices_on_claim(claim['pk'])
            content_type = "HIC/HolClassic/DirectBillClaim@"+logic_pack
            path = self.create_object(content_type,"","")
            self.set(path, "PmsClaimId", claim_id)
            self.set(path, "ServicingProviderNum", invoices[0]['staff_provided_service_provider_number'])
            if (not invoices[0]['payee_provider_number'] is None) and invoices[0]['payee_provider_number'] <> invoices[0]['staff_provided_service_provider_number']:
                self.set(path,"PayeeProviderNum", invoices[0]['payee_provider_number'])
            typ = 'O'
            if 'referrer_provider_number' in invoices[0] and not invoices[0]['referrer_provider_number'] is None:
                typ = 'S'
            notes = invoices[0]['notes']
            if notes:
                notes = notes.lower()
                if 'lost referral' in notes or 'emergency referral' in notes:
                    typ = 'S'
            self.set(path, "ServiceTypeCde",typ)  # O=GP, S=Specialist
            pts = {}
            invoices = sorted(invoices,key=lambda x:x['voucher_id'])  # yes the java layer cracks it if the vouchers aren't loaded in order. Sigh.
            for inv in invoices:
                voucher_path = self.create_object("Voucher",'./'+path,inv['voucher_id'])
                if not inv['fk_patient'] in pts:
                    pts[inv['fk_patient']] = self.db.get_patient(inv['fk_patient'])
                pt = pts[inv['fk_patient']]
                self.set(voucher_path,"BenefitAssignmentAuthorised","Y")
                self.set(voucher_path,"PatientDateOfBirth",pt['birthdate'].strftime('%d%m%Y'))
                self.set(voucher_path,"PatientFamilyName",self.clean(pt['surname']))
                self.set(voucher_path,"PatientFirstName",self.clean(pt['firstname']))
                self.set(voucher_path,"PatientMedicareCardNum",pt['medicare_number'])
                self.set(voucher_path,"PatientReferenceNum",pt['medicare_ref_number'])
                self.set_voucher_items(voucher_path,inv)
            send_code = self.send_content(content_type)
            old_send_code = send_code
            if send_code == 0: send_code = 4010 # successfull BB transmission
            self.db.set_claim_return(claim_id,send_code,"")
            self.reset()
            return {'send_code':old_send_code}
        except MedicareError as e:
            self.db.set_claim_return(claim_id,e.number,str(e))
            self.cycle_process()
            return {'error':str(e)}
        except Exception as e:
            self.db.set_claim_return(claim_id,4009,str(e))
            self.cycle_process()
            return {'error':str(e)}

    def amount_to_cents(self,amt):
        m = re.match("\$([0-9]+)\.([0-9]+)",amt)
        return (int(m.group(1)) * 100)+int(m.group(2))

    def set_voucher_items(self,voucher_path,inv,set_patient_contrib=False):
        self.set(voucher_path,"DateOfService",inv['visit_date'].strftime('%d%m%Y'))
        inv_service_text = inv['notes'] or ""
        if not inv['referrer_provider_number'] is None:
            self.set(voucher_path,"ReferringProviderNum",inv['referrer_provider_number'])
            self.set(voucher_path,"ReferralIssueDate",inv['referral_date'].strftime("%d%m%Y"))
            if inv['referral_duration'] > 12:
                ref_typ = "I" # indefinate
            elif inv['referral_duration'] == 3 or inv['referral_duration'] == 12:
                ref_typ = "S" # "standard", 3 for specialists, 12 for GPs
            else:  # there is a third code, "N", for nonstandard referral durations, which must then be specified in the ServiceText
                ref_typ = "N"
                inv_service_text += " referral duration is %s months" % inv['referral_duration']
            self.set(voucher_path,"ReferralPeriodTypeCde",ref_typ)
        if 'lost referral' in inv_service_text.lower():
            self.set(voucher_path,"ReferralOverrideTypeCde","L")
        else:
            if 'emergency referral' in inv_service_text.lower():
                self.set(voucher_path,"ReferralOverrideTypeCde","E")
        # sort items by largest first, as this will usually be the one whole-invoice comments should
        # be attached to
        items = sorted(inv['items_billed'], key=lambda x: x['amount'])
        total_paid = inv['total_paid']
        for item in items:
            item_path = self.create_object("Service","./"+voucher_path,item['service_id'])
            self.set(item_path,"ChargeAmount",str(self.amount_to_cents(item['amount'])))
            if set_patient_contrib:
                if total_paid < 0:
                    logging.warn("tried to have negative payment %s" % total_paid)
                    total_paid = 0
                    contrib = 0
                elif total_paid == 0:
                    contrib = 0
                elif total_paid >= item['amount']:  # we are fully paying this item, any money left over is for the other items on the bill
                    total_paid = total_paid - item['amount']
                    contrib = item['amount']
                else:
                    contrib = total_paid
                    total_paid = 0
                if contrib < 1.00: contrib = 0 # Medicare business rule: no payment less than $1.00
                self.set(item_path,"PatientContribAmt",str(self.amount_to_cents(contrib)))
            self.set(item_path,"ItemNum",item['mbs_item'])
            inv_service_text = self.parse_service_text(inv_service_text,item)
            if item['multiple_procedure']:
                self.set(item_path,'MultipleProcedureOverrideInd',"Y")
            if item['duplicate']:
                self.set(item_path,'DuplicateServiceOverrideInd',"Y")
            if item['aftercare']:
                self.set(item_path,'AfterCareOverrideInd',"Y")
            if item['separate_sites']:
                self.set(item_path,'RestrictiveOverrideCde',"SP")
            if item['not_related']:
                self.set(item_path,'RestrictiveOverrideCde',"NR")
            if item['procedure_duration'] > 0:
                d = item['procedure_duration']
                if d % 15 != 0:
                    d = (d / 15) * 15
                    logging.warn("Procedure duration must be multiple of 15, rounding down to %d" % d)
                self.set(item_path,'TimeDuration',"{:0>3}".format(d))
            if item['field_quantity'] > 0:
                if item['field_quantity'] > 99:
                    logging.warn("field quantity cannot be more than 99")
                    item['field_quantity'] = 99
                self.set(item_path,'FieldQuantity',str(item['field_quantity']))
            if item['number_of_patients'] > 0:
                self.set(item_path,"NoOfPatientsSeen",str(item['number_of_patients']))
            inv_service_text = inv_service_text.strip()
            if inv_service_text != "":
                self.set(item_path,"ServiceText",inv_service_text)
                inv_service_text = ""
    
    """semi-temporary measure: parse the service text to determine special Medicare flags
    big weakness is hard to use and can only apply to the first item
    """
    def parse_service_text(self,service_text,item):
        for reg,field in [(['multiple proc',r'\bmp\b'],'multiple_procedure'),
                  (['nnac','aftercare','after-care','complication'],'aftercare'),
                  (['duplicate','seen twice','same day'],'duplicate'),
                  (['separate sites','two sites','two places'],'separate_sites'),
                  (['not related','care plan','separate issue'],'not_related'),
                  (['duration ?=?:? ?([0-9]+)','time ?=?:? ?([0-9]+)'],'procedure_duration'),
                  (['quantity ?=?:? ?([0-9]+)'],'field_quantity')]:
            for i in reg:
                m = re.search(i,service_text,re.I)
                if m:
                    service_text = service_text[:m.start()] + service_text[m.end():] # remove the matched text
                    val = True
                    try:
                        val = int(m.group(1))
                    except IndexError: pass
                    item[field] = val
        return service_text

    def claim_query(self, claim):
        pn = claim['provider_number']
        while len(pn) < 8:
            pn = "0"+pn
        return pn+claim['claim_id']+claim['claim_date'].strftime("%d%m%Y")

    def get_bb_processing_report(self, claim):
        try:
            has_row = self.create_report("DBProcessingReport",self.claim_query(claim))
            lines = []
            while has_row: # report exists
                line = {}
                line['service_id'] = self.get("ServiceId")
                line['amount'] = int(self.get('ServiceBenefitAmount'))
                medicare_flag = self.get('MedicareCardFlag') 
                if medicare_flag != " " and medicare_flag != "":
                    medicare_number = self.get("PatientMedicareCardNum")
                    medicare_ref_number = self.get('PatientReferenceNum')
                    if medicare_flags.has_key(medicare_flag):
                        line['comment'] = medicare_flags[medicare_flag].format(medicare_number, medicare_ref_number)
                    else:
                        line['comment'] = "Unknown flag {}".format(medicare_flag)
                else:
                    line['comment'] = None
                line['reason_code'] = self.get("ExplanationCode")
                lines.append(line)
                has_row = self.next()
            self.reset()
            if len(lines) > 0:
                self.db.set_processing_report(claim['pk'],claim['claim_id'],lines)
                return lines
        except MedicareError as e:
            self.db.set_claim_return(claim['claim_id'],4009,str(e))
            self.cycle_process()
            return {'error':str(e),'claim_id':claim['claim_id']}

    def convert_charge(self, n):
        if n is None: return "$0.00"
        if len(n) < 3: return "$"+n
        return "$"+n[:-2]+'.'+n[-2:]


    def get_bb_payment_report(self, claim):
        try:
            has_row = self.create_report("DBPaymentReport",self.claim_query(claim))
            ret = []
            while has_row:
                d = {}
                r = ""
                for i in ["BSBCode","BankAccountNum","BankAccountName",'ClaimDate','ClaimBenefitPaid','ClaimChargeAmount','DepositAmount',"PaymentRunDate","PaymentRunNum",'PmsClaimId']:
                    try:
                        val = self.get(i)
                        r += "{}: {}\n".format(i,val)
                        d[i] = val
                    except MedicareError as e:
                        pass
                if d:
                    self.db.set_payment_report(claim['pk'],r,d['PmsClaimId'])
                    ret.append(d)
                has_row = self.next()
            self.reset()
            return ret
        except MedicareError as e:
            self.db.set_payment_report(claim['pk'],str(e),None)
            self.cycle_process()
            return {'error':e,'claim':claim['claim_id']}

    # receive same-day elete events
    # postgres param is in form fk_invoice/sdd_code as two integers
    def same_day_delete(self, pid, param):
        pdb.set_trace()
        try:
            fk_invoice, sdd_code = param.split("/")
            fk_invoice = int(fk_invoice)
            inv = self.db.get_private_invoice_to_upload(fk_invoice)
            pt = self.db.get_patient(inv['fk_patient'])
            logic_pack = self.get_logic_pack("HIC/HolClassic")
            content_type = "HIC/HolClassic/SameDayDeleteClaim@"+logic_pack
            path = self.create_object(content_type,"","")

            self.set(path,"DateOfLodgement",inv["date_invoiced"].strftime("%d%m%Y"))  # of the claim to be deleted
            self.set(path,"PatientFamilyName",self.clean(pt['surname']))
            self.set(path,"PatientFirstName",self.clean(pt['firstname']))
            self.set(path,"PatientMedicareCardNum",pt['medicare_number'])
            self.set(path,"PatientReferenceNum",pt['medicare_ref_number'])
            self.set(path,"TimeOfLodgement",inv["date_invoiced"].strftime("%H%M%S"))  # of the claim to be deleted
            self.set(path,"SDDReasonCode",sdd_code)
            #001 = Incorrect Patient Selection 
            #002 = Incorrect Provider Details 
            #003 = Incorrect Date of Service 
            #004 = Incorrect Item Number Claimed 
            #005 = Omitted Text on Original Claim 
            #006 = Incorrect Payment Type (ie Paid / Unpaid) 
            #007 = Other 
            send_code = self.send_content(content_type)
            if send_code == 0:
                # success
                self.db.set_invoice_return(inv['pk_invoice'],4013,None,None)
                logging.info("successfully did same-day delete on invoice PK {}".format(fk_invoice))
                self.reset()
            else: # something else
                self.db.set_invoice_return(inv['fk_invoice'],send_code,None)
                logging.warn("****WEIRD result code: %d" % send_code)
                self.cycle_process()
        except MedicareError as e:
            self.cycle_process()
            self.db.set_invoice_return(fk_invoice,e.number,str(e))
        except Exception as e:
            self.cycle_process()
            self.db.set_invoice_return(fk_invoice,4012,str(e))


    def upload_private_invoice(self, fk_invoice):
        try:
            inv = self.db.get_private_invoice_to_upload(fk_invoice)
            pt = self.db.get_patient(inv['fk_patient'])
            logic_pack = self.get_logic_pack("HIC/HolClassic")
            content_type = "HIC/HolClassic/InteractivePatientClaim@"+logic_pack
            path = self.create_object(content_type,"","")
            if inv['total_paid'] == inv['total_bill']:
                self.set(path,"AccountPaidInd","Y")
            else:
                self.set(path,"AccountPaidInd","N")
            self.set(path,"AccountReferenceId",inv['pk_invoice'])
            if 'bank_details_upload' in inv and inv['bank_details_upload']:
                acct_name, bsb, acct_number = self.db.get_bank_details(inv['fk_invoice'])
                self.set(path,"BankAccountName",acct_name)
                self.set(path,"BankAccountNum",acct_number)
                self.set(path,"BSBCode",bsb)
            if not inv['fk_payer_person'] is None:
                payer = self.db.get_patient(fk_person=inv['fk_payer_person'])
                if 'claimant_address_upload' in inv and inv['claimant_address_upload']:
                    self.set(path,"ClaimantAddressLine1",self.clean(payer['street1']))
                    self.set(path,"ClaimantAddressLine2",self.clean(payer['street2']))
                    self.set(path,"ClaimantAddressLocality",self.clean(payer['town']))
                    self.set(path,"ClaimantAddressPostcode",payer['postcode'])
                self.set(path,"ClaimantDateOfBirth",payer['birthdate'].strftime('%d%m%Y'))
                self.set(path,"ClaimantFamilyName",self.clean(payer['surname']))
                self.set(path,"ClaimantFirstName",self.clean(payer['firstname']))
                self.set(path,"ClaimantMedicareCardNum",payer['medicare_number'])
                self.set(path,"ClaimantReferenceNum",payer['medicare_ref_number'])
                for c in self.db.get_person_comms(payer['fk_person']):
                    if c['type'] in [7,4,0,1,11]:
                        self.set(path,"ContactPhoneNum",self.clean(c['value'],10))
                        break
            self.set(path,"ClaimSubmissionAuthorised","Y")
            self.set(path,"DateOfLodgement",inv["date_invoiced"].strftime("%d%m%Y"))
            self.set(path,"PatientDateOfBirth",pt['birthdate'].strftime('%d%m%Y'))
            self.set(path,"PatientFamilyName",self.clean(pt['surname']))
            self.set(path,"PatientFirstName",self.clean(pt['firstname']))
            self.set(path,"PatientMedicareCardNum",pt['medicare_number'])
            self.set(path,"PatientReferenceNum",pt['medicare_ref_number'])
            #PayeeProviderNum
            self.set(path,"ServicingProviderNum",inv['staff_provided_service_provider_number'])
            self.set(path,"TimeOfLodgement",inv["date_invoiced"].strftime("%H%M%S"))
            voucher_path = self.create_object("Voucher","./"+path,"01")
            self.set_voucher_items(voucher_path,inv,True)
            send_code = self.send_content(content_type)
            if send_code == 0:
                # success
                has_row = self.is_report_available()
                result = None
                if not has_row:
                    result = "No report available, contact Medicare "
                else:
                    claim_id = self.get("PmsClaimId")
                    while has_row:
                        service_id = self.get("ServiceId")
                        amount = int(self.get('ServiceBenefitAmount'))
                        reason_code = self.get("ExplanationCode")
                        self.db.set_item_code(inv['pk_invoice'],service_id,reason_code,"benefit ${:.2f}".format(amount/100.0))
                        has_row = self.next()
                self.db.set_invoice_return(inv['pk_invoice'],0,result,claim_id)
                logging.info("***SUCCESSFUL CLAIM PMS claim ID %r" % claim_id)
                self.reset()
            elif send_code == 9501:
                # failure
                #self.reset()
                has_row = self.is_report_available()
                result = ""
                if not has_row:
                    error_code = 4011
                    claim_id = None
                    error_level = 'U'
                else:
                    claim_id = self.get("PmsClaimId")
                    error_code = self.get("ClaimErrorCode")
                    if error_code is None:
                        error_code = 4006 # = "see item status"
                    else:
                        error_code = int(error_code)
                    error_level = self.get("ClaimErrorLevel")
                    if error_code == 9634:
                        result += "Medicare advises that the claimant's Medicare number is {} - {}".format(self.get("CurrentClaimantMedicareCardNum"),self.get("CurrentClaimantReferenceNum"))
                    if error_code == 9633:
                        result += "Medicare advises that the patient's Medicare number is {} - {}".format(self.get("CurrentPatientMedicareCardNum"),self.get("CurrentPatientReferenceNum"))
                    logging.warn("***INVOICE ERROR: code: %s level: %s PMS claim ID: %s" % (error_code,error_level,claim_id))
                    bad_service_error_level = False
                    while has_row:
                        service_id = self.get("ServiceId")
                        reason_code = self.get("ServiceErrorCode")
                        service_error_level = self.get("ServiceErrorLevel")
                        self.db.set_item_code(fk_invoice,service_id,reason_code,None,service_error_level)
                        logging.warn("***ITEM ERROR service %s code %s level %s" % (service_id,reason_code,service_error_level))
                        if service_error_level == 'U':
                            bad_service_error_level = True
                        has_row = self.next()
                self.db.set_invoice_return(fk_invoice,error_code,result,claim_id,error_level)
                if error_level == 'A' and not bad_service_error_level:
                    # a problem occurred, but we can ram it through to a human at the Medicare end using a special system call
                    self.accept()
                self.reset()
            else: # something else
                self.db.set_invoice_return(inv['fk_invoice'],send_code,None)
                logging.warn("****WEIRD result code: %d" % send_code)
                self.cycle_process()
        except MedicareError as e:
            self.cycle_process()
            self.db.set_invoice_return(fk_invoice,e.number,str(e))
            
