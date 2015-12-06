#!/usr/bin/python
# -*- coding: utf-8 -*-

import os, re, psycopg2, pdb, sys, glob, codecs, pdb, time, urllib2
from xml.etree.cElementTree import *

def print_help():
    print """MBS import tool
Imports the full Medicare Benefits Schedule from an XML file into an existing EasyGP database.

-U: user: database user (default UNIX current user)
-d: database name (default "easygp")
-h: host to connect to (default same machine)
-f: MBS XML file to read. (optional)
    This can be downloaded from the links on 
    http://www.mbsonline.gov.au/internet/mbsonline/publishing.nsf/Content/downloads
    If not provided, the program will try to download it directly.
-p: password to database (optional)
"""

def grab_mbs_xml():
    """
    Tries to download the MBS XML directly. Returns as a file-like object
    """
    print "Scanning Medicare webpage"
    response = urllib2.urlopen('http://www.mbsonline.gov.au/internet/mbsonline/publishing.nsf/Content/downloads')
    html = response.read()
    m = re.search(r'href="([0-9A-F]+/\$File/[0-9]+-XML\.xml)"', html)
    if m:
        print "found XML link: %s" % m.group(1)
        print "Downloading XML (could be slow)"
        return urllib2.urlopen('http://www.mbsonline.gov.au/internet/mbsonline/publishing.nsf/Content/'+m.group(1))
    else:
        print >>sys.stderr, "Could not find link to XML"
        sys.exit(1)
        
def process_args():
    """
    Go through the UNIX command line arguments and provide a Python dictionary of the values
    """
    args = {"-d":"easygp","-U":os.getenv("USER")}
    arg = None
    for a in sys.argv[1:]:
        if a == "--help":
            print_help()
            sys.exit(0)
        if a.startswith("-"):
            arg = a
        elif not arg is None:
            args[arg] = a
    return args

def get_xml_etree(args):
    """
    Load the Medicare-provided XML from the file provided, or download
    """
    if '-f' in args:
        if not os.access(args['-f'],os.R_OK):
            print "cannot open %s" % args['-f']
            sys.exit(1)
        return parse(args['-f'])
    else:
        return parse(grab_mbs_xml())

def connect_db(args):
    """
    Connect to the postgres DB. Provide a Python global called 'conn' holding the connection object
    """
    global conn
    kwargs = {'database':args['-d'],'user':args['-U']}
    if '-p' in args: kwargs['password'] = args['-p']
    if '-h' in args: kwargs['host'] = args['-h']
    conn = psycopg2.connect(**kwargs)

def xml_mbs_items(etree):
    """
    Go through the XML and yiled a dictionary for each MBS item
    """
    for i in etree.getroot().iter("Data"):
        item = {'number_of_patients':0}
        for xml_name,our_name in [('Description','descriptor'),('ItemNum','item'),('ScheduleFee','schedule_fee'),("DerivedFee",'derived_fee'),('FeeType','fee_type'),('BenefitType','benefit_type'),('Benefit75','benefit75'),('Benefit85','benefit85'),('Benefit100','benefit100'),('Group','group')]:
            j = i.find(xml_name)
            if not j is None:
                item[our_name] = j.text
        yield item

0161d83e.6.43.1.2
'0161d83e.6.40.1.0'
def to_money(m):
    """Accepts an integer as integer cents
    Rounds to the nearest $0.05, and then to 
    a nice string the postgres money type will understand
    """
    cents = m*100
    cents_int = int(cents)
    cents_int = (cents_int / 5) * 5 # round down to five cents
    if cents - cents_int > 2.5: cents_int += 5  # add five cents, i.e. rounding up if required
    cents_int = str(cents_int)
    return cents_int[:-2] + '.' + cents_int[-2:]
    
def unroll_derived_fee(item,all_items):
    """
    For a derived fee involving multiple patients, create and item for each number of patients from 1 to 7
    """
    starting_amount = None
    m = re.match(r"The fee for item ([0-9]+), plus \$([0-9\.]+) divided by the number of patients seen, up to a maximum of six patients. +For seven or more patients - the fee for item [0-9]+ plus \$([0-9\.]+) per patient",item['derived_fee'])
    if m:
        referred_item = m.group(1)
        starting_amount = float(all_items[referred_item]['schedule_fee'])
    else:
        m = re.match(r"An amount equal to \$([0-9\.]+), plus \$([0-9\.]+) divided by the number of patients seen, up to a maximum of six patients. +For seven or more patients - an amount equal to \$[0-9\.]+ plus \$([0-9\.]+) per patient",item['derived_fee'])
        if m:
            starting_amount = float(m.group(1))
    if not starting_amount is None:
        to_divide = float(m.group(2))
        residual = float("0"+m.group(3))
        for j in range(1,7):
            item['number_of_patients'] = j
            s = starting_amount+(to_divide/j)
            item['schedule_fee'] = to_money(s)
            yield item
        item['number_of_patients'] = 7
        item['schedule_fee'] = to_money(starting_amount+residual)
        yield item
    else:
        item['schedule_fee'] = None
        yield item

def load_item(item):
    """
    Given an item, load it into the DB
    create new values in billing.fee_schedule and billing.prices as required
    update them if they exist
    """
    cur = conn.cursor()
    cur.execute("select pk from billing.fee_schedule where mbs_item=%s and number_of_patients=%s", (item['item'],item['number_of_patients']))
    if cur.rowcount == 0:
        cur.execute("insert into billing.fee_schedule (mbs_item, descriptor, \"group\", number_of_patients, derived_fee) values (%s, %s, %s, %s, %s) returning (pk)", (item['item'], item['descriptor'], item['group'], item['number_of_patients'],item.get('derived_fee',None)))
        pk_schedule = cur.fetchone()[0]
    else:
        pk_schedule = cur.fetchone()[0]
        cur.execute("update billing.fee_schedule set descriptor=%s, derived_fee=%s where mbs_item=%s and number_of_patients=%s", (item['descriptor'],item.get('derived_fee',None),item['item'],item['number_of_patients']))
    if not item['schedule_fee'] is None:
        cur.execute("select 1 from billing.prices where fk_fee_schedule=%s and fk_lu_billing_type=8",(pk_schedule,))
        if cur.rowcount == 0:
            cur.execute("insert into billing.prices (fk_fee_schedule,price,fk_lu_billing_type) values (%s,%s,8)",(pk_schedule,item['schedule_fee']))
        else:
            cur.execute("update billing.prices set price=%s where fk_lu_billing_type=8 and fk_fee_schedule=%s",(item['schedule_fee'],pk_schedule))
    cur.close()


args= process_args()
etree = get_xml_etree(args)
connect_db(args)
all_items = {}
# create a dictionary of all items
for i in xml_mbs_items(etree):
    all_items[i['item']] = i

# go through all items
for i in all_items.values():
    if i['fee_type'] == 'D':
        # it's a derived fee so we need to unpack
        for j in unroll_derived_fee(i,all_items):
            load_item(j)
    else:
        load_item(i)

conn.commit()
conn.close()
