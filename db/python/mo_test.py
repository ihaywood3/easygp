# a test system for Medicare Online
# this file can be run directly from the command-line to do Medicare Online testing.
import daemon,  mo, dbwrapper, datetime, pdb, sys, fnmatch, logging

def yester(n): # so many days in the past from today's date
    return datetime.date.fromordinal(datetime.date.today().toordinal()-n)

o = open("report.txt","w")

BULK_BILL_WAITING=4003
PRIVATE_WAITING=4005

if len(sys.argv) > 1:
    match = sys.argv[1]
else:
    match = "*"

match = match.replace('.','_')

d = daemon.Daemon()
d.setup_test()

d.db.wipe_invoices()
fmt = logging.Formatter(fmt='%(asctime)s\t%(levelname)s\t%(message)s')

#import tests

#for f in dir(tests):
#    if fnmatch.fnmatch(f,'test_'+match):
#        logn = f.replace('_','.')
#        hdr = logging.FileHandler(logn+'.log','w')
#        hdr.setFormatter(fmt)
#        logging.getLogger().addHandler(hdr)
#        getattr(tests,f)(o,d)
#        logging.getLogger().removeHandler(hdr)
#        hdr.close()

# basic exmaple bulk-billing
#d.db.insert_invoice(visit_date=yester(0),fk_staff=2,fk_branch=1,items=['23'],fk_patient=2,result_code=BULK_BILL_WAITING,fk_lu_bulk_billing_type=1)

#claims = d.mo.prepare_bb_reports()
#d.mo.transmit_claim(claims[0])
#print >>o, "1.1.2 Submit a 23 bulk-bill\nClaim ID: %s" % claims[0]['claim_id']


# basic example private billing

fk_invoice = d.db.insert_invoice(visit_date=yester(1),fk_staff=2,fk_branch=1,items=['36'],fk_patient=2,result_code=PRIVATE_WAITING)
error_code, claim_id = d.mo.upload_private_invoice(fk_invoice)
print >>o, "Private bill claim\nClaim ID: %s\nResult code: %s\n" % (claim_id,error_code)
o.close()
