# a test system for Medicare Online
# this file can be run directly from the command-line to do Medicare Online testing.
# if you change this file make sure it is indented properly a python hates bad indentations
import daemon,  mo, dbwrapper, datetime, pdb, sys, fnmatch, logging, datetime

def create_date_x_days_in_past(n): # so many days in the past from today's date
    return datetime.date.fromordinal(datetime.date.today().toordinal()-n)

o = open("report.txt","w") # open the file to write

BULK_BILL_WAITING=4003 #magic code belonging to Ian which he made up means invoices waiting to be uploaded for bulk billing
PRIVATE_WAITING=4005   #magic code belonging to Ian which he made up means a private invoice waiting to upload

if len(sys.argv) > 1:
    match = sys.argv[1]
else:
    match = "*"

match = match.replace('.','_')
d = daemon.Daemon()
d.setup_test()

d.db.wipe_invoices()
fmt = logging.Formatter(fmt='%(asctime)s\t%(levelname)s\t%(message)s')

# import all the tests
import tests
# run the tests as specified on the command line
for function_name in dir(tests):                                         
    if fnmatch.fnmatch(function_name,'test_'+match):
        # pdb.set_trace()
	log_file_name = function_name.replace('_','.')
	hdr = logging.FileHandler(log_file_name+'.log','w')
	hdr.setFormatter(fmt)
	logging.getLogger().addHandler(hdr)
	getattr(tests,function_name)(o,d)
	logging.getLogger().removeHandler(hdr)
	hdr.close()

# basic exmaple bulk-billing
#d.db.insert_invoice(visit_date=create_date_x_days_in_past(0),fk_staff=2,fk_branch=1,items=['23'],fk_patient=2,result_code=BULK_BILL_WAITING,fk_lu_bulk_billing_type=1)

#claims = d.mo.prepare_bb_reports()
#d.mo.transmit_claim(claims[0])
#print >>o, "1.1.2 Submit a 23 bulk-bill\nClaim ID: %s" % claims[0]['claim_id']


# basic example private billing 
# fk_staff points to our test staff doctor
# fk_branch points to our test fk_branch
# result_code is only for our use.
# python code uses invoices.result_code to pick out which ones to send
# error_code is what we get back from medicare see list in billing.lu_codes
# claim_id:
#          bulk billing is the claim_id that we create for that claim
#          private billing the claim_id is created by medicare and is a reference to the record on their server
#          in clinical use not useful, but when we test we have to quote the ID back to medicare to prove we did the test
# this code does a private billing
# to do all the tests we have to do dozens and dozens of these changing the parameters every time

#fk_invoice = d.db.insert_invoice(visit_date=create_date_x_days_in_past(1),fk_staff=2,fk_branch=1,items=['36'],fk_patient=2,result_code=PRIVATE_WAITING)
#error_code, claim_id = d.mo.upload_private_invoice(fk_invoice)
# generating the report... o= open the file to write > put in thes stuff, close the file
#print >>o, "Private bill claim\nClaim ID: %s\nResult code: %s\n" % (claim_id,error_code)
o.close()
