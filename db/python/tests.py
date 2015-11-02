# this is an auto-generated file using the xl spread sheet provided by medicare for all the tests we need to do
# what some slave has to do is to go through every test def and write the python code to get the test done.
# as an example:

# fk_invoice = d.db.insert_invoice(visit_date=yester(1),fk_staff=2,fk_branch=1,items=['36'],fk_patient=2,result_code=PRIVATE_WAITING)
# error_code, claim_id = d.mo.upload_private_invoice(fk_invoice)
# generating the report... o= open the file to write > put in thes stuff, close the file
# print >>o, "Private bill claim\nClaim ID: %s\nResult code: %s\n" % (claim_id,error_code)
#
# in otherwords, need to cut and past code like this and put it after the def bit.
# ignore Create a claim for a consultation with Not Normal Aftercare
# This can only be done the GUI client, its here for reference

# for example pick one to do eg bulk billing one:use sample code
# the def will deine the item number to use
# cut and past into the print>>o part of the text and the last \n
# it must end up looking like e.g this:  print >>o, "4.1.1 \n-----\n Submit a 23 bulk-bill\nClaim ID: %s" % claims[0]['claim_id']
# print >>o, "4.1.1 \n-----\n 
# to run the test on the comamnd line type the def number followed by wildcard e.g python mo_test.py 4.1.1*
# the 4.1 are all bulk biling for cretins like richard the clue is in the 'mae a claim'
# when trying these always change the day otherwise medicare will crack the shits and won't allow the service on same day 
# To set special flags as per example 4_1_4  instead of a simple string have to have a python dictionary {}
# and to items in the dictionary are keyed to billing.items_billed e.g 
#When doing a specialist billing, must include the referral info all fields in invoices table
#    i) referrer_providernumber
#   ii) referral_date
#  iii) referral_duration (no defaults) in montths
# fake doctors GP who can write  12 months referrals: provider_number = 2054781W 
# fake specialsit who can write 3 month referrals 2121331W

import datetime

BULK_BILL_WAITING=4003 #magic code belonging to Ian which he made up means invoices waiting to be uploaded for bulk billing
PRIVATE_WAITING=4005   #magic code belonging to Ian which he made up means a private invoice waiting to upload

def create_date_x_days_in_past(n): # so many days in the past from today's date
    return datetime.date.fromordinal(datetime.date.today().toordinal()-n)


def test_3_3_14_prelim(o,d):
    """
Check the Location certificates expiry date.
The expiry date is displayed correctly.
    """
    print >>o, "3.3.14\n------\n"


# This can only be done the GUI client, its here for reference
def test_3_4_2_prelim(o,d):
    """
Enter a valid provider number.
The provider number is accepted.
    """
    print >>o, "3.4.2\n-----\n"


# This can only be done the GUI client, its here for reference
def test_3_4_4_prelim(o,d):
    """
Enter a valid referring provider number.
The referring provider number is accepted.
    """
    print >>o, "3.4.4\n-----\n"


# This can only be done the GUI client, its here for reference
def test_3_6_1_prelim(o,d):
    """
Update the Medicare Benefit Schedule (MBS) used in the PMS
The user was successfully able to update the MBS. (Please provide screen shots of this process).
    """
    print >>o, "3.6.1\n-----\n"



def test_4_1_1_prelim(o,d): #done and seems to test ok
    """
Create a claim for a standard consultation with a Date of Service MORE than 6 months PAST from todays date but LESS than 2 years PAST from TODAYS DATE. (Item 23)
The claim is transmitted successfully and a statement is printed correctly.
    """
    d.db.insert_invoice(visit_date=create_date_x_days_in_past(202),fk_staff=2,fk_branch=1,items=['23'],fk_patient=2,result_code=BULK_BILL_WAITING,fk_lu_bulk_billing_type=1)
    claims = d.mo.prepare_bb_reports()
    d.mo.transmit_claim(claims[0])
    print >>o, "4.1.1 \n-----\n Submit a 23 bulk-bill\nClaim ID: %s" % claims[0]['claim_id']



def test_4_1_3_prelim(o,d): #done and seems to test ok
    """
Create a claim for a standard consultation with service text applied that is greater than 50 characters. (Item 23)
The PMS should not allow more than 50 characters to be TRANSMITTED as service text. More than 50 characters can be displayed on the statement.
    """
   
    d.db.insert_invoice(visit_date=create_date_x_days_in_past(203),
			fk_staff=2,fk_branch=1,items=['23'],
			fk_patient=2,result_code=BULK_BILL_WAITING,
			fk_lu_bulk_billing_type=1,
			notes="the quick brown fox jumped over the lazy dog and tripped on a branch this must be longer than 50 chars")
    claims = d.mo.prepare_bb_reports()
    d.mo.transmit_claim(claims[0])
    print >>o, "4.1.3 \n-----\n Submit a 23 bulk-bill\nClaim ID: %s" % claims[0]['claim_id']



def test_4_1_4_prelim(o,d): #done and seems to test ok
    """
Create a claim for a consultation (Item 23) and items 30061 and 30071.  Set the RestrictiveOverrideCde to SP (separate sites).
The claim is transmitted successfully and the accompanying statement is printed correctly.   
Data Elements to be included in transmission:                                                                                                                                                                                                               The RestrictiveOverrideCde = SP
    """
    d.db.insert_invoice(visit_date=create_date_x_days_in_past(202),fk_staff=2,fk_branch=1,items=['23',{'item':'30061','separate_sites':True},{'item':'30071','separate_sites':True}],fk_patient=2,result_code=BULK_BILL_WAITING,fk_lu_bulk_billing_type=1)
    claims = d.mo.prepare_bb_reports()
    d.mo.transmit_claim(claims[0])
    print >>o, "4.1.4\n-----\n Submit a 23 and items 30061 and 30071 bulk-bill RestrictiveOverrideCde to SP\nClaim ID: %s" % claims[0]['claim_id']



def test_4_1_5_prelim(o,d):  #done and seems to test ok
    """
Create a claim using item 723 for patient Leif Glynis, Medicare card number 3950039702 (IRN 1), use the generalist provider from your test data, set the RestrictiveOverrideCde to NR (Not Related care plan). (DOB 24061959)
The claim is successfully transmited and the accompanying statement is printed correctly.
Data Elements to be included in transmission:                                                                                                                                                                                                               The RestrictiveOverrideCde - NR
    """
    d.db.insert_invoice(visit_date=create_date_x_days_in_past(202),fk_staff=2,fk_branch=1,items=[{'item':'723','not_related':True}],fk_patient=26,result_code=BULK_BILL_WAITING,fk_lu_bulk_billing_type=1)
    claims = d.mo.prepare_bb_reports()
    d.mo.transmit_claim(claims[0])
    print >>o, "4.1.5\n-----\n Submit a 723 RestrictiveOverrideCde to NR (Not Related care plan)\nClaim ID: %s" % claims[0]['claim_id']

def test_4_1_7_prelim(o,d):  #done and seems to test ok
    """
Create a claim for a consultation with Not Normal Aftercare flagged
(Item 23)
A statement is printed with 'NNAC' next to the service.
Data Elements to be included in transmission:                                                                                                                                                                                                               AfterCareOverrideInd=Y
    """
    d.db.insert_invoice(visit_date=create_date_x_days_in_past(202),fk_staff=2,fk_branch=1,items=[{'item':'23','aftercare':True}],fk_patient=2,result_code=BULK_BILL_WAITING,fk_lu_bulk_billing_type=1)
    claims = d.mo.prepare_bb_reports()
    d.mo.transmit_claim(claims[0])
    print >>o, "4.1.7\n-----\n Submit a Create a claim for a consultation with Not Normal Aftercare\nClaim ID: %s" % claims[0]['claim_id']




def test_4_1_10_prelim(o,d): #not done
    """
Create a claim with a multiple attendance item (4) with the number of patients seen (12).
A statement is printed with the number of patients printed next to the service.
Data Elements to be included in transmission:                                                                                                                                                                                                               ServiceTypeCde  = O
NoOfPatientsSeen = 12
In our DB vwItemsAndInvoices has a field number_of_patients which comes from vwItemsBilled which comes from fee.schedule
Ian to fix the python code
    """
    d.db.insert_invoice(visit_date=create_date_x_days_in_past(7),fk_staff=2,fk_branch=1,items=[{'item':'4'}],fk_patient=2,result_code=BULK_BILL_WAITING,fk_lu_bulk_billing_type=1)
    claims = d.mo.prepare_bb_reports()
    d.mo.transmit_claim(claims[0])
    print >>o, "4.1.10\n-----\n Submit a multiple attendance item (4) with the number of patients seen (12)\nClaim ID: %s" % claims[0]['claim_id']


def test_4_1_13_prelim(o,d): # done and checked
    """
Create a claim for a hyperbaric therapy service (Item 13025) with the time in minutes set (270 mins).
A statement is printed with the total time against the item 13025.
Data Elements to be included in transmission:                                                                                                                                                                                                               ServiceTypeCde  = O
TimeDuration = 270
    """
    d.db.insert_invoice(visit_date=create_date_x_days_in_past(7),fk_staff=2,fk_branch=1,items=[{'item':'13025','procedure_duration':270}],fk_patient=2,result_code=BULK_BILL_WAITING,fk_lu_bulk_billing_type=1)
    claims = d.mo.prepare_bb_reports()
    d.mo.transmit_claim(claims[0])
    print >>o, "4.1.13\n-----\n hyperbaric therapy service (Item 13025) with the time in minutes set (270 mins)\nClaim ID: %s" % claims[0]['claim_id']




def test_4_2_1_prelim(o,d):
    """
Create a claim for an initial specialist consultation with a  Date of Service MORE than 6 months PAST from todays date but LESS than 2 years PAST from TODAYS DATE (Item 104)
The claim is transmitted successfully and a statement is printed correctly.
    """
  
    d.db.insert_invoice(visit_date=create_date_x_days_in_past(200),fk_staff=2,fk_branch=1,referral_date=create_date_x_days_in_past(300), referral_duration=12, referrer_provider_number='2054781W',items=[{'item':'104'}],fk_patient=2,result_code=BULK_BILL_WAITING,fk_lu_bulk_billing_type=1)
    claims = d.mo.prepare_bb_reports()
    d.mo.transmit_claim(claims[0])
    print >>o, "4.2.1\n-----\ninitial specialist consultation with a  Date of Service MORE than 6 months PAST from todays date but LESS than 2 years PAST from TODAYS DATE (Item 104)\nClaim ID: %s" % claims[0]['claim_id']



def test_4_2_4_prelim(o,d):
    """
Create a claim with an Initial specialist consultation with a non-standard referral period (4 Months, supporting text required)
(Item 104)
The claim will have referral details (referring provider, referral date, and referral period entered as text) included and printed on the statement. (Period of Referral needs to populated as '4 months' on the statement).
Data Elements to be included in transmission:                                                                                                                                                                                                                                                                                                                                                                                                          ServiceTypeCde  = S
ReferralIssueDate
ReferringProviderNum
ReferralPeriodTypeCde = N
Service Text = "4 Months"
    """
    print >>o, "4.2.4\n-----\n"



def test_4_2_5_prelim(o,d):
    """
Create a claim with an Initial specialist consultation with an indefinite referral period
(Item 104)
The claim will have referral details (referring provider, referral date, and referral period stated as Indefinite Referral) included and printed on the statement.
Data Elements to be included in transmission:                                                                                                                                                                                                                                                                                                                                                                                                           ServiceTypeCde  = S
ReferralIssueDate
ReferringProviderNum
ReferralPeriodTypeCde = I
    """
    print >>o, "4.2.5\n-----\n"



def test_4_2_7_prelim(o,d):
    """
Create a claim with an Initial specialist consultation with an emergency referral.
(Item 104)
"Emergency Referral" will be printed on the statement. This is not transmitted as service text.
Data Elements to be included in transmission:                                                                                                                                                                                                                                                                                                                                                                                                           ServiceTypeCde  = S
ReferralOverrideTypeCde=E
    """
    print >>o, "4.2.7\n-----\n"



def test_4_2_8_prelim(o,d):
    """
Create a claim with an Epidural Infusion lasting 1 hour and 30 minutes.
Base Item     18226
Derived Fee   18227
Note: Each block of 15mins or less = 1 time unit (FieldQuantity)
(NB:Ensure that the patient used is female)
A statement is printed with the total time against the item 18227.
Data Elements to be included in transmission:                                                                                                                                                                                                                                                                                                                                                                                                           ServiceTypeCde  = S
ItemNum = 18226
ItemNum = 18227
FieldQuantity= 2
    """
    print >>o, "4.2.8\n-----\n"



def test_4_2_12_prelim(o,d):
    """
Using a "Specialist" for the Servicing Provider, create a claim with 2 services:
- a referred consultation (item 104) with referral details and
- a non requested item 57524 with LSPN (14) without supporting request details
Referral details and LSPN will be printed on the statement.
Data Elements to be included in transmission:                                                                                                                                                                                                                                                                                                                                                                                                                     
ServiceTypeCde = S
ReferringProviderNum
ReferralIssueDate
ReferralPeriodTypeCde
Item =104
Item = 57524
    """
    print >>o, "4.2.12\n------\n"



def test_4_2_13_prelim(o,d):
    """
Using a "Specialist" for the Servicing Provider, create a claim 
- a referred consultation (item 104) with referral details and
- a requested diagnostic item 55252 with LSPN (14) and supporting request details
Referral, Request and LSPN details will be printed on the statement. Two vouchers will need to be submitted.
Data Elements to be included in transmission:                                                                                                                                                                                                                                                                                                                                                                                                          ServiceTypeCde = S

ItemNum = 104
ReferringProviderNum
ReferralIssueDate
ReferralPeriodTypeCde

ItemNum = 55252
LSPNum = 14
RequestingProviderNum
RequestIssueDate
RequestTypeCde = D
    """
    print >>o, "4.2.13\n------\n"



def test_4_6_1_prelim(o,d):
    """
Create a claim where a patient has 3 services on separate days within a month, that the provider is submitting on the one invoice in a batch
(Item 304)
The statement will show all services with correct dates of service.
The transmission will show the 3 separate vouchers with different dates of service.
Data Elements to be included in transmission:                                                                                                                                                                                                     Voucher 1:
ItemNumber
DateofService
Voucher 2:
ItemNumber
DateofService
Voucher 3:
ItemNumber
DateofService
    """
    print >>o, "4.6.1\n-----\n"



def test_4_6_2_prelim(o,d):
    """
Create a claim where a patient has 15 items performed in a single visit.
(Item 30195)
Only 14 services are allowed per voucher.
PMS should prompt at 14 and allow no more services to be added
or
PMS gives the option to manually split the invoice into two vouchers.                                                                                                                                                                                   or
PMS automatically splits the invoice into two vouchers.                                                                                                                                                                                               The printed statement indicates all services from the visit.
    """
    print >>o, "4.6.2\n-----\n"



def test_4_6_3_prelim(o,d):
    """
Create a claim where the benefit is paid to a payee provider
The Servicing & Payee Provider details are printed on the statement and are present in the transmission.
    """
    print >>o, "4.6.3\n-----\n"



def test_4_7_1_prelim(o,d):
    """
Batch and transmit an out of hospital claim
The claim ID is prefixed with an alpha.
    """
    print >>o, "4.7.1\n-----\n"



def test_4_7_3_prelim(o,d):
    """
Batch and transmit an in hospital claim
The claim ID is prefixed with a #.
    """
    print >>o, "4.7.3\n-----\n"



def test_4_7_6_prelim(o,d):
    """
Create a claim where there is more than 80 vouchers awaiting batching
If the total number of vouchers is greater than 80 (maximum) then:
The PMS splits the vouchers into 2 claims                                                                                                                                                                                                                  OR
The PMS restricts the number of vouchers to a maximum of 80
    """
    print >>o, "4.7.6\n-----\n"



def test_4_7_7_prelim(o,d):
    """
Batch, authorise and transmit the 80-voucher claim.
Claim transmits successfully
    """
    print >>o, "4.7.7\n-----\n"



def test_4_7_11_prelim(o,d):
    """
Create and send a claim using a location certificate (HCL) from a provider who has Optional signing.
Claim transmits successfully.
    """
    print >>o, "4.7.11\n------\n"



def test_4_7_12_prelim(o,d):
    """
Create and send a claim from a provider that has not registered for online claiming. (Provider 2402601F)
The PMS displays error 9119 -The provider is identified as inactive for online claiming purposes. Contact the PKI Customer Service Centre for assistance.
    """
    print >>o, "4.7.12\n------\n"



def test_4_7_13_prelim(o,d):
    """
Create and send a claim using two different location certificates.
This only applies if you are supporting Multiple Location Certificates from a single site.
PMS must include functionality that allows swapping between location certificates. Transmissions must be successful. (Medicare Australia staff only, transmission should show different LocationIDs for each location certificate)
    """
    print >>o, "4.7.13\n------\n"



def test_4_8_1_prelim(o,d):
    """
Transmit a claim where a processing report is generated.
Eg. Incorrect Medicare first name.

The following day, request the processing report.
The processing report is displayed with the following details.
Claim processing summary
Claim ID
Charge Amount
Claim benefit paid
Servicing provider number
Voucher processing information
Medicare card number
Patient first name
Patient last name
Medicare card flag
IRN (Individual Reference Num)
Service processing information
Date of service
Item number
Service benefit amount
Explanation code
Service Id
    """
    print >>o, "4.8.1\n-----\n"



def test_4_8_2_prelim(o,d):
    """
Transmit a claim where a benefit is paid.
The following day, request the payment report.
The Payment report is displayed with the following payment details:
Payment summary (at the top)
Payment Run Date
Payment Run Number
Deposit Amount
Bank Account name
Bank Account number
BSB Code
Claim payment data (a row for each)
Claim ID
Claim date
Claim benefit paid
    """
    print >>o, "4.8.2\n-----\n"



def test_4_8_5_prelim(o,d):
    """
Request a processing report where a benefit has been Paid for a multiple attendance item. (Item 4 num of patients 1)
The processing report displays the number of patients seen.
    """
    print >>o, "4.8.5\n-----\n"



def test_4_8_7_prelim(o,d):
    """
Transmit a claim with multiple items where the Payee Provider is other than the Servicing Provider. Advise Product Intgeration when the claim has been submitted so we can reject one of the items ensuring both reports will contain data when returned.
The following day, request the processing and payment reports.
The processing and payment reports are returned correctly.
    """
    print >>o, "4.8.7\n-----\n"



def test_4_8_8_prelim(o,d):
    """
Request a payment report that has multiple payments in a payment run
The report is displayed showing all claims with the correct payments.
    """
    print >>o, "4.8.8\n-----\n"



def test_4_8_9_prelim(o,d):
    """
Request a processing report where the Patient Medicare Issue number has changed.

(Use Gregory Watts)
The processing report returns a Medicare Card Flag of 'I - Patient Medicare Issue number changed'.
The PMS automatically updates the Patient information
Or
The PMS displays a message to user to update their patient records with the provided information.
    """
    print >>o, "4.8.9\n-----\n"



def test_4_9_1_prelim(o,d):
    """
When Creating a Bulk Bill claim a DB4 from is created.
The DB4 is created and a copy is printed.
    """
    print >>o, "4.9.1\n-----\n"



def test_4_9_2_prelim(o,d):
    """
Claim Reference prints in the correct format.
Is made up of:
Location ID +Date of Lodgement (system default) + Time of Lodgement (system default)
eg, STS0000001012013095920
    """
    print >>o, "4.9.2\n-----\n"



def test_14_1_3_prelim(o,d):
    """
Create a claim for a standard consultation with a Date of Service MORE than 6 months PAST from today's date but LESS than 2 years PAST from TODAY'S DATE. (Item 23)
The claim is transmitted successfully and a statement is printed correctly.
    """
    print >>o, "14.1.3\n------\n"



def test_14_1_4_prelim(o,d):
    """
Create a claim for a standard consultation.
(Item 23)
A statement is printed with the item.
NOTE: The NoOfPatientsSeen must not be set.
    """
    print >>o, "14.1.4\n------\n"



def test_14_1_7_prelim(o,d):
    """
Create claim for a multiple attendance item (4) with the number of patients equal to 1.
A statement is printed with the number of patients printed on the statement.
NoOfPatientsSeen = 1
NOTE: Even though only one patient is attended, number of patients must be set.
    """
    print >>o, "14.1.7\n------\n"



def test_14_1_10_prelim(o,d):
    """
Create a claim with multiple operations (31200, 30186) where the multiple procedure override has been applied to the second item.
The user is requested by the system to enter a reason why the service has had the multiple procedure override rule applied.
A statement is printed with Multiple Procedure Override on the statement. MultipleProcedureOverrideInd =Y is set in the transmission.
The text explaining why the service has had the multiple procedure override rule applied, is printed on the statement and in the Service Text data element.
    """
    print >>o, "14.1.10\n-------\n"



def test_14_1_12_prelim(o,d):
    """
Create a claim where an in hospital item is transmitted in the same voucher as an out of hospital (Item 32177 in hospital)
(Item 37 home visit)
The claim is accepted.  A statement is printed with an * next to item 32177 only
Item = 32177
HospitalInd = Y
Item = 37
    """
    print >>o, "14.1.12\n-------\n"



def test_14_1_14_prelim(o,d):
    """
Create a claim for an Epidural Infusion lasting 1 hour and 30 minutes.
Base Item     18226
Derived Fee 18227 
Note: Each block of 15mins or less = 1 time unit (FieldQuantity)
A statement is printed with the number minutes against the item 18227.
ItemNum = 18226
ItemNum = 18227
FieldQuantity= 2
    """
    print >>o, "14.1.14\n-------\n"



def test_14_1_15_prelim(o,d):
    """
Create a claim for a hyperbaric therapy service (Item 13025) with the time in minute"s specified (270 mins).
A statement is printed with the number of minutes against the item 13025.
TimeDuration = 270
    """
    print >>o, "14.1.15\n-------\n"



def test_14_1_16_prelim(o,d):
    """
Create and send a claim with the Lodgement time after 1pm.
Lodgement time is printed on the statement and transmitted using a 24 hour clock (eg 131526)
    """
    print >>o, "14.1.16\n-------\n"



def test_14_1_17_prelim(o,d):
    """
Create a claim with a general consultation (item 23) and a non Requested Diagnostic service (item 57506) including LSPN
A statement is printed with all relevant details
Data Elements to be included in transmission:                                                                                                                                                                                                     ItemNum = 23
ItemNum = 57506
LSPNum =
    """
    print >>o, "14.1.17\n-------\n"



def test_14_1_18_prelim(o,d):
    """
Create a claim with a general consultation and a simple pathology service (item 73805)
Claim transmits successfully
    """
    print >>o, "14.1.18\n-------\n"



def test_14_2_1_prelim(o,d):
    """
Create a claim for an initial specialist consultation with a  Date of Service MORE than 6 months PAST from today's date but LESS than 2 years PAST from TODAY'S DATE (Item 104)
The claim is transmitted successfully and a statement is printed correctly.
    """
    print >>o, "14.2.1\n------\n"



def test_14_2_2_prelim(o,d):
    """
Create a claim for an initial specialist consultation with a standard general referral period
(12 months, item 104)
The claim will have referral details transmitted and printed on the statement. Period of Referral needs to populated as '12 months' on the statement.
Data Elements to be included in transmission:    
ReferralIssueDate
ReferringProviderNum
ReferralPeriodTypeCde = S
    """
    print >>o, "14.2.2\n------\n"



def test_14_2_5_prelim(o,d):
    """
Create a claim for an initial specialist consultation with an indefinite referral period
(Item 104)
The claim will have referral details (referring provider, referral date, and referral period stated as 'Indefinite Referral') included and printed on the statement.
Data Elements to be included in transmission:    
ReferralIssueDate
ReferringProviderNum
ReferralPeriodTypeCde = I
    """
    print >>o, "14.2.5\n------\n"



def test_14_6_2_prelim(o,d):
    """
The patient has fully paid the account and requests payment by cheque (or EFT if bank details already held by Medicare) to a specified address.
A Statement is printed displaying correct details.  The payment mode is cheque, if the patients bank details are not already stored with Medicare, and the destination is to the 'above address'.
    """
    print >>o, "14.6.2\n------\n"



def test_14_6_3_prelim(o,d):
    """
The patient has fully paid the account and requests payment by EFT (Bank details supplied in claim data) to the address held by Department of Human Services.
A Statement is printed displaying correct details including the patients bank details. The statement is to be sent to the address held by Department of Human Services.
    """
    print >>o, "14.6.3\n------\n"



def test_14_6_6_prelim(o,d):
    """
The account is fully paid by a person other than the patient and the claimant requests payment by cheque (or EFT if bank details already held by Medicare) to be sent to a specified address.
A Statement is printed with patient and claimant details. The payment mode indicated is cheque, if the patients bankdetails are not already stored with Medicare, and the destination is to the  'above address'.
    """
    print >>o, "14.6.6\n------\n"



def test_14_6_7_prelim(o,d):
    """
The account is fully paid by a person other than the patient and the claimant requires payment by EFT (Bank details supplied in claim data) to be sent to the address held by Department of Human Services.
A Statement is printed with patient and claimant details.  The claimants bank details have been supplied and the destination is to the 'address held by Department of Human Services'.
    """
    print >>o, "14.6.7\n------\n"



def test_14_6_12_prelim(o,d):
    """
The account is not paid; the claimant is other than the patient and directs a cheque to be sent to a specified address.
A Statement is printed with the patients and claimant's details, the claim is not paid, the payment mode is cheque, and the destination is the 'above address'.
    """
    print >>o, "14.6.12\n-------\n"



def test_14_6_15_prelim(o,d):
    """
Create a claim where the account is partially paid.
A Statement is printed indicating the claim is not paid and the Patient Contribution Amount.
AccountPaidInd = N
ChargeAmount = 2505
PatientContribAmt = 1500
    """
    print >>o, "14.6.15\n-------\n"



def test_14_6_17_prelim(o,d):
    """
Attempt to create a claim that has items that are fully paid, partially paid, and not paid.
The software will apportion the total patient contribution across all the services within the claim. The software will not transmit any of the services as being fully paid.

The corresponding amounts will be printed on the statement and transmitted correctly.
    """
    print >>o, "14.6.17\n-------\n"



def test_14_7_1_prelim(o,d):
    """
A patient has 3 services on separate days within a month, that the provider is submitting on the one invoice in a batch (Item 304)
The Statement will show all services with correct dates of service.
Log will show the 3 separate vouchers with different dates of service.
    """
    print >>o, "14.7.1\n------\n"



def test_14_7_2_prelim(o,d):
    """
A patient has 15 items performed in a single visit.
(Item 30195)
PMS should prompt at 14 services (maximum) and allow no more services to be added   OR
Have the option to manually or automatically split the invoice into two vouchers.
The printed statement indicates all services from the visit.
    """
    print >>o, "14.7.2\n------\n"



def test_14_7_3_prelim(o,d):
    """
Create a voucher where the benefit is paid to a payee provider (who is not the servicing provider)
A Statement is printed with the Service Provider & Payee Provider. The log will show both Service  & Payee Provider
    """
    print >>o, "14.7.3\n------\n"



def test_14_8_1_prelim(o,d):
    """
Create and send a claim.
Transmits successfully without asking the user to sign the claim with their HCI.
    """
    print >>o, "14.8.1\n------\n"



def test_14_9_1_prelim(o,d):
    """
Transmit a claim where the patient has transferred to a new card but the old card number and IRN are transmitted.

(Happy Jones)
An Assessment report returns with Error code
ClaimErrorCode = 9633 A new Medicare card has been issued. Please update your records and ask the patient to use the new card number for any future claims.
ClaimErrorLevel = U
CurrentPatientMedicareCardNum = Current
CurrentPatientReferenceNum = Current
The patient details are then updated and the user is directed to resubmit the claim with these updated details
Or
The patient details are displayed and the user is directed to use these details and resubmit the claim.
    """
    print >>o, "14.9.1\n------\n"



def test_14_9_3_prelim(o,d):
    """
Transmit a claim where the patient is other than the claimant and the claimant has transferred to a new card but the old card number and IRN are transmitted.

Patient - (Valid test data patient)
Claimant - Happy Jones
An Assessment report returns with Error code ClaimErrorCode = 9634 A new Medicare card has been issued. Please update your records and ask the claimant to use the new card number for any future claims.
ClaimErrorLevel = U
CurrentClaimantMedicareCardNum =
CurrentClaimantReferenceNum =
The claimant details are then updated and the user is directed to resubmit the claim with these updated details
Or
The claimant details are displayed and the user is directed to use these details and resubmit the claim.
    """
    print >>o, "14.9.3\n------\n"



def test_14_9_5_prelim(o,d):
    """
Transmit a claim with service text where there is an acceptable service level error.
An assessment report is returned indicating:
ClaimErrorLevel =
ClaimErrorCode =
ServiceErrorLevel = A
ServiceErrorCode = xxxx
The Medicare Reason Code and it"s description is displayed to the user.
The claim is able to be accepted.
    """
    print >>o, "14.9.5\n------\n"



def test_14_9_7_prelim(o,d):
    """
Transmit a claim where there is an acceptable service level error.
eg
item 23
item 23 with text
An assessment report is returned indicating:
ClaimErrorLevel = A
ClaimErrorCode =
ServiceErrorLevel = A
ServiceErrorCode = xxxx
The Medicare Reason Code and it"s description is displayed to the user.
The claim is able to be accepted.
A Lodgement Advice is printed.
    """
    print >>o, "14.9.7\n------\n"



def test_14_9_10_prelim(o,d):
    """
Transmit a Diagnostic Imaging MRI procedure with the following items on the one voucher.
Item 63361 (LSPN 14)
Item 63322 (LSPN 14)
Request details are required.
The Medicare reason codes of 566 for item 63361 and 567 for item 63322 and the descriptions are displayed to the user.
    """
    print >>o, "14.9.10\n-------\n"



def test_14_10_1_prelim(o,d):
    """
Print a Statement of Claim and Benefit Payment.
As per the CAAG
    """
    print >>o, "14.10.1\n-------\n"



def test_14_10_2_prelim(o,d):
    """
Print a Lodgement Advice.
As per the CAAG
    """
    print >>o, "14.10.2\n-------\n"



def test_14_10_3_prelim(o,d):
    """
Claim Reference prints in the correct format on the Lodgement Advice and Statement of Claim and Benefit
Claim Reference Is made up of:
Location ID
Date of Lodgement (system default) when claim prepared
Time of Lodgement (system default) when claim prepared
    """
    print >>o, "14.10.3\n-------\n"



def test_14_11_1_prelim(o,d):
    """
Send a request to delete the claim that was successfully paid Reason - 004: Incorrect Item Num
The claim will be deleted
    """
    print >>o, "14.11.1\n-------\n"



def test_14_11_3_prelim(o,d):
    """
Attempt to delete a PCI claim that has been sent to pend.
Error will return 9645 The claim identified for deletion has a status other than Paid Same Day
    """
    print >>o, "14.11.3\n-------\n"


