#!/usr/bin/python
# -*- coding: utf-8 -*-

import os, re, pg, pdb, sys, glob, codecs, pdb, time
from xml.etree.cElementTree import *

c = pg.connect('easygp','localhost',-1,None,None,'ian','denethor')
updates = open("/home/ian/update.sql","a+")


now_t = time.strftime("%Y-%m-%d %H:%M:%S",time.localtime(time.time()))

def cmd(sql):
    r = c.query(sql)
    print >>updates, sql+";"
    return r

def x(s):
    x = {"p":"http://www.health.gov.au/Schema/PBS", "d":"http://docbook.org/ns/docbook"}
    for i, j in x.items():
        s = s.replace(i+':',"{%s}" % j)
    return s

def import_atc():
    for f in glob.iglob("atc*.txt"):
        with open(f,"r") as fd:
            for l in fd:
                l = l.strip()
                l = l.replace("\xb5","^")
                l = l.split("!")
                r = c.query("select 1 from drugs.atc where atccode='%s'" % l[0])
                if r.ntuples() == 0:
                    cmd("insert into drugs.atc (atccode, atcname) values ($$%s$$, $$%s$$)" % (l[0],l[1]))

def import_mnfr():
    for f in glob.iglob("mnfr*.txt"):
        with open(f,"r") as fd:
            for l in fd:
                l = l.strip()
                l = l.split("!")
                code = l[0]
                name = l[1]
                name = name.replace("'", "''")
                r = c.query("select 1 from drugs.company where code='%s'" % code)
                if r.ntuples() == 1:
                    cmd("""
        update drugs.company set company='%s',address='%s',telephone='%s',facsimile='%s'
        where code='%s'""" % (name, l[2], l[3], l[4], code))
                else:
                    cmd("""
    insert into drugs.company (code,company,address,telephone,facsimile) values
    ('%s','%s','%s','%s', '%s')""" % (code, name, l[2], l[3], l[4]))

def read_pbs():
    for f in glob.iglob("drug*.txt"):
        with open(f,"r") as fd:
            for l in fd:
                r = {}
                l = l.strip()
                l = l.split("!")
                r['fs'] = l[27]
                if "\xb5" in r['fs']:
                    r['fs'] = r['fs'].replace("\xb5","^")
                r['genericname'] = l[26].lower()
                r['original_genericname'] = r['genericname']
                r['brandname'] = l[25].upper()
                if r['genericname'] == 'glucose indicator-blood':   # brands of these things are considered separate products by the PBS
                    r['genericname'] = 'blood glucose indicator - ' + r['brandname']
                    r['genericname'] = r['genericname'].lower()
                r['chapter'] = l[0]
                r['atccode'] = l[1]
                if l[2] == 'S': continue # ignore these rows for now: "secondary" ATC code entries.
                r['pbscode'] = l[4]
                r['maxquantity'] = int(l[8])
                r['numrepeats'] = int(l[9]) 
                r['manufacturer'] = l[10]
                r['price'] = l[17]
                r['restriction'] = l[5].lower()
                yield r

def check_pbsconvert():
    for row in read_pbs():
        r = c.query("select * from drugs.pbsconvert where fs='%s'" % row['fs'])
        if r.ntuples() == 0:
            print "insert into drugs.pbsconvert(fs,done) values ('%s','t');" % row['fs']

def import_pbs():
    splitamount = re.compile("([0-9.]+)(.+)")
    for row in read_pbs():
        r = c.query("select * from drugs.pbsconvert where fs = '%s'" % row['fs'])
        if r.ntuples() == 0:
            print >> sys.stderr, "can't find %s in drug %s" % (row['fs'],row['genericname'])
            return
        n = r.dictresult()[0]
        if n['done'] == 'f':
            print >>sys.stderr, "%s isn't done yet" % n['fs']
            return
        if n['dose'] is None or n['dose'] == '':
            dose = 'NULL'
            d1 = " is null"
        else:
            dose = "'%s'" % n['dose']
            d1 = " = %s" % dose
        if n['comment'] is None or n['comment'] == '':
            comment = 'NULL'
        else:
            comment = "'%s'" % n['comment']
        form = n['form']
        r = c.query("select pk from drugs.form where form = '%s'" % form)
        if r.ntuples() == 0:
            print >> sys.stderr, "can't find form '%s' in fs %s" % (form,fs)
            return
        form = r.dictresult()[0]['pk']
        amount = n['amount']
        if amount:
            m = splitamount.match(amount)
            if not m:
                print >> sys.stderr, "re failed on %r" % amount
            amount = float(m.group(1))
            amount_unit =  m.group(2)
        else:
            amount = 'NULL'
            amount_unit = 'NULL'
        if n['packsize'] is None:
            print >>sys.stderr, "can't find packsize in fs %r" % fs
            return
        convert_packsize = int(n['packsize'])
        if convert_packsize == 1:
            convert_packsize = maxquantity
        genericname = row['genericname']
        if genericname == 'sodium acid phosphate':
            genericname = 'phosphorus;sodium;potassium'
        if genericname == 'insulin lispro-insulin lispro protamine suspension':
            genericname = 'insulin lispro;insulin lispro protamine suspension'
        if len(dose.split('-')) > 1:
            genericname = genericname.replace(' and ',';')
            if len(dose.split('-')) != len(genericname.split(';')):
                genericname = genericname.replace(' with ',';')
                if len(dose.split('-')) != len(genericname.split(';')):
                    genericname = genericname.replace(', ',';')
                    genericname = genericname.replace('arachis oil extract','arachis oil;extract')
                    if len(dose.split('-')) != len(genericname.split(';')):
                        print >> sys.stderr, """
can't match
fs: %s
genericname: %s
brandname: %s
chapter: %s
pbscode: %s
maxquantity: %s
numrepeats: %s
manufacturercode: %s
dose: %s
fk_form: %s """ % (row['fs'], row['genericname'], row['brandname'], row['chapter'], row['pbscode'], row['maxquantity'], row['numrepeats'], row['manufacturer'], dose, form)
        # sort out amount_unit
        if amount == 'NULL':
            a1 = "is NULL"
            a2 = "is NULL"
        else:
            amount_unit = amount_unit.lower()
            if amount_unit == 'g':
                amount_unit = 35
            if amount_unit == 'ml':
                amount_unit = 26
            if amount_unit == 'dose' or amount_unit == 'unit':
                amount_unit = 56
            if amount_unit == 'day':
                amount_unit = 6
            if amount_unit == 'cm':
                amount_unit = 13
            a1 = "= %f" % amount
            a2 = "= %d" % amount_unit
        # find product and add if doesn't exist
        r = c.query("""
                select pk from drugs.product where 
                atccode='%s' and
                generic='%s' and
                fk_form = %d and 
                pack_size = %d and
                amount %s and
                amount_unit %s and 
                strength %s""" % (row['atccode'],genericname,form, convert_packsize, a1, a2, d1))
        if r.ntuples() == 0:
            r = cmd("""
              insert into drugs.product(atccode,generic,fk_form,strength,free_comment,
              original_pbs_name,original_pbs_fs,pack_size,amount,amount_unit) 
              values ('%s', '%s',%d,%s,%s,$$%s$$,$$%s$$,%d,%s,%s) returning (pk)
              """ % (row['atccode'],genericname,form, dose, comment,row['original_genericname'],row['fs'],convert_packsize,amount,amount_unit))
            pk_product = r.getresult()[0][0]
        else:
            pk_product = r.getresult()[0][0]
            cmd("update drugs.product set updated_at='%s'::timestamp where pk = '%s'" % (now_t,pk_product))
        # insert or update PBS data
        r = c.query("select * from drugs.pbs where pbscode='%s'" % pbscode)
        if r.ntuples() > 0:
            r = cmd("""
update drugs.pbs set
   quantity=%d,
   max_rpt=%d,
   chapter='%s',
   restrictionflag='%s'
where pbscode='%s'""" % (maxquantity,numrepeats,chapter,restriction.upper(),pbscode))
        else:
            r = cmd("""
insert into drugs.pbs (fk_product,pbscode,quantity,max_rpt,chapter,restrictionflag)
values ('%s','%s',%d,%d,'%s','%s')
""" % (pk_product,pbscode,maxquantity,numrepeats,chapter,restriction.upper()))
        # insert brand names if new
            r = c.query("""
select * from drugs.brand where fk_product='%s' and brand='%s'
""" % (pk_product, brandname))
        if r.ntuples () == 0:
            cmd("""
                insert into drugs.brand (fk_product, brand, fk_company, from_pbs, price)
                values ('%s', '%s', '%s', true, %s::text::money)
                """ % (pk_product, brandname, manufacturer, price))
#            else:
#                #print "updating: %s %s" % (genericname, fs)

def import_pbs_indic():
    # inserting PBS indications

    cmd("truncate drugs.restriction")

    t = None
    for f in glob.iglob("G2B*.xml"):
        t = parse(f)

    for lbl in [".//p:authority-required",".//p:restricted"]:
        for drug in t.findall(x(lbl)):
            pbscode = drug.find(x("p:code")).text
            for indic in drug.findall(x("p:indications-list/p:indication")):
                code = indic.find(x("p:code")).text
                txt = ""
                for para in indic.findall(x("d:para")):
                    if para.get("role") != "legal": 
                        txt = txt+"<p>"+para.text+"</p>"
                method = indic.find(x(".//p:authority-method"))
                streamlined = "false"
                if method is None: 
                    method = "phone"
                else:
                    method = method.text.split("#")[1]
                if method == "no-contact":
                    streamlined = "true"
	        #txt = txt.replace(u'\xa0',u' ')
                txt = txt.encode('ascii','xmlcharrefreplace')
                txt = txt.replace("\n","<br/>")
                cmd("insert into drugs.restriction (pbscode, code, streamlined, restriction) values ('%s','%s',%s,$$%s$$)" % (pbscode, code, streamlined,txt))
