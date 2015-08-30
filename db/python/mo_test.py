# a test system for Medicare Online

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

import tests

for f in dir(tests):
    if fnmatch.fnmatch(f,'test_'+match):
        logn = f.replace('_','.')
        hdr = logging.FileHandler(logn+'.log','w')
        hdr.setFormatter(fmt)
        logging.getLogger().addHandler(hdr)
        getattr(tests,f)(o,d)
        logging.getLogger().removeHandler(hdr)
        hdr.close()

#d.db.insert_invoice(visit_date=yester(0),fk_staff=2,fk_branch=1,items=['23'],fk_patient=2,online=True,result_code=BULK_BILL_WAITING,fk_lu_bulk_billing_type=1)

#claims = d.mo.prepare_bb_reports()
#d.mo.transmit_claim(claims[0])
#print >>o, "1.1.2 Submit a 23 bulk-bill\nClaim ID: %s" % claims[0]['claim_id']

o.close()
