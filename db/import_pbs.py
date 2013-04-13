#!/usr/bin/python
# -*- coding: utf-8 -*-

import os, re, pg, pdb, sys, glob, codecs, pdb, time
from xml.etree.cElementTree import *

c = pg.connect('easygp','',-1,None,None,'easygp','')
updates = open("/home/ian/product-update.sql","a+")
updates_pbs = open("/home/ian/pbs-update.sql","w")
updates_restrict = open("/home/ian/restrict-update.sql","w")


now_t = time.strftime("%Y-%m-%d %H:%M:%S",time.localtime(time.time()))

def cmd(sql):
    r = c.query(sql)
    print >>updates, sql+";"
    return r

def comment(sql):
    print >>updates, "--"+sql

def x(s):
    x = {"pbs":"http://schema.pbs.gov.au", "rwt":"http://schema.pbs.gov.au/RWT/","dbk":"http://docbook.org/ns/docbook","xlink":"http://www.w3.org/1999/xlink","xml":"http://www.w3.org/XML/1998/namespace","rdf":"http://www.w3.org/1999/02/22-rdf-syntax-ns#","skos":"http://www.w3.org/2004/02/skos/core#"}
    for i, j in x.items():
        s = s.replace(i+':',"{%s}" % j)
    return s

def import_atc(t):
    for atc in xml_atc(t):
        r = c.query("select 1 from drugs.atc where atccode='%s'" % atc["atccode"])
        if r.ntuples() == 0:
            cmd("insert into drugs.atc (atccode, atcname) values ($$%s$$, $$%s$$)" % (atc["atccode"],atc["atcname"]))

def import_mnfr(t):
    for m in xml_manufacturers(t):
        r = c.query("select 1 from drugs.company where code='%s'" % m["code"])
        if r.ntuples() == 1:
            cmd("""
        update drugs.company set company=$$%(company)s$$,address=$$%(address)s$$,telephone='%(telephone)s'
        where code='%(code)s'""" % m)
        else:
            cmd("""
    insert into drugs.company (code,company,address,telephone) values
    ('%(code)s',$$%(company)s$$,$$%(address)s$$,'%(telephone)s')""" % m)

def import_pbs(t):
    updates_pbs.write("truncate drugs.pbs;\n")
    generics = {}
    for g in xml_generics_brands(t):
        generics[g["xml:id"]] = g
    for item in xml_pbs_items(t):
        g = generics[item["mpp"]]
        item["mpp"] = g
        sct = g["sct"]
        r = c.query("select pk from drugs.product where sct='%s'" % sct)
        if r.ntuples() == 0:
            print >>sys.stderr, "WARNING: %r doesn't match on SCT" % item
        elif r.ntuples () > 1:
            print >>sys.stderr, "WARNING: %r matches multiple products on SCT" % item
        else:
            fk_product = r.getresult()[0][0]
            if item["type"] == "streamlined" or item["type"] == "authority":
                flag = "A"
            elif item["type"] == "restricted":
                flag = "R"
            else:
                flag = "U"
            updates_pbs.write("""
insert into drugs.pbs (fk_product,pbscode,quantity,max_rpt,chapter,restrictionflag)
values ('%s','%s',%s,%s,'%s','%s');\n
""" % (fk_product,item['code'],item['quantity'],item['max_rpt'],item['chapter'],flag))


def import_restricts(t):
    updates_restrict.write("truncate drugs.restriction;\n")
    
    restricts = {}
    for i in xml_restricts(t):
        restricts[i["xml:id"]] = i
    for drug in xml_pbs_items(t):
        pbscode = drug['code']
        for xmlid in drug['restricts']:
            if restricts.has_key(xmlid):
                r = restricts[xmlid]
                streamlined = 'f'
                if drug['type'] == 'streamlined': streamlined = 't'
                updates_restrict.write("insert into drugs.restriction (pbscode, code, streamlined, restriction) values ('%s','%s','%s',$$%s$$);\n" % (pbscode, r['code'], streamlined,r['restriction']))

def get_xml_etree():
    t = None
    for f in glob.iglob("pbs*.xml"):
        t = parse(f)
    if t is None:
        print >>sys.stderr, "can't find pbs-DATE.xml"
        sys.exit(1)
    #pdb.set_trace()
    return t

def xml_pbs_items(t):
    for chapter in t.iterfind(x("pbs:schedule/pbs:listings-list")):
        chapter_code = chapter.find(x("pbs:info/pbs:code")).text
        for drug in chapter.iterfind(x("pbs:prescribing-rule")):
            d = {}
            no_qty = True
            d['chapter'] = chapter_code
            for k in drug.iterfind(x(".//pbs:maximum-quantity")):
                if k.get("reference")=="unit-of-use":
                    d["quantity"] = k.text
                    no_qty = False
            if no_qty:
                for k in drug.iterfind(x(".//pbs:maximum-quantity")):
                    if k.get("reference")=="pack":
                        d["quantity"] = k.text
                        no_qty = False
            if no_qty:
                d["quantity"] = "1"
            a = drug.find(x(".//pbs:number-repeats"))
            if not a is None:
                d['max_rpt'] = a.text
            else:
                d["max_rpt"] = '0'
            d['code'] = drug.find(x("pbs:code")).text
            a = drug.find(x(".//dbk:title"))
            if not a is None:
                d["title"] = a.text
            else:
                #print >>sys.stderr, "WARNING, no title on %r" % d
                continue
            a = drug.find(x(".//pbs:classification/pbs:ATC"))
            if not a is None:
                d["atc"] = a.text[4:]
            else:
                #print >>sys.stderr, "WARNING: NO ATC on %r" % d
                continue
            d["type"] = drug.get("type")
            d["restricts"] = [l.get(x("xlink:href"))[1:] for l in drug.iterfind(x(".//rwt:restriction-references-list/rwt:restriction-reference"))]
            d["mpps"] = [j.get(x("xlink:href"))[1:] for j in drug.iterfind(x(".//pbs:mpp-reference"))]
            if d['chapter'] == 'IN' or d['chapter'] == 'EP' or d['chapter'] == 'IP': continue
            if len(d["mpps"]) == 1: # for now ignore EP and IN chapters which both violate this rule: EP has zero, IN has multiple
                d["mpp"] = d["mpps"][0]
                yield d

def xml_restricts(t):
    external_indications = {}
    for r in t.iterfind(x("rwt:restrictions-list/rwt:indication")):
        xml_id = r.get(x("xml:id"))
        txt = " ".join(j.encode('ascii','xmlcharrefreplace') for j in r.itertext())
        txt = txt.replace("\n","").strip()
        txt = re.sub(r' +',' ',txt)
        external_indications[xml_id] = txt
    for r in t.iterfind(x("rwt:restrictions-list/rwt:restriction")):
        d = {}
        c = r.find(x("pbs:code"))
        if not c.get("scheme")=="http://scheme.pbs.gov.au/RWT/Restriction/Unrestricted":
            d["code"] = c.text
            d["xml:id"] = r.get(x("xml:id"))
            d["restriction"] = "\n".join(('<p>'+i.text.encode('ascii','xmlcharrefreplace')+'</p>' for i in r.iterfind(x("rwt:indication/dbk:note/dbk:para"))))
            if len(d["restriction"]) < 5:
                a = r.find(x("rwt:indication-reference"))
                if not a is None:
                    d["restriction"] = external_indications[a.get(x("xlink:href"))[1:]]
            yield d


def xml_atc(t):
    for a in t.iterfind(x("rdf:RDF/skos:Concept")):
        if a.get(x("rdf:about"))[0:4] == "atc:":
            atc = {}
            atc["atcname"] = a.find(x("skos:definition")).text
            atc["atccode"] = a.get(x("rdf:about"))[4:]
            yield atc

def xml_generics_brands(t):
    for drug in t.iterfind(x("pbs:drugs-list/pbs:mp/pbs:mpp")):
        d = {}
        d["xml:id"] = drug.get(x("xml:id"))
        for i in drug.iterfind(x("pbs:code")):
            if i.get("scheme")=="urn:snomed-org/sct":
                d["sct"] = i.text
        j = drug.find(x("pbs:pack-size"))
        if not j is None:
            d["pack_size"] = j.text
        d["brands"] = []
        for brand in drug.iterfind(x("pbs:tpp")):
            b = {}
            for j in brand.iterfind(x("pbs:code")):
                if j.get("scheme")=="urn:snomed-org/sct":
                    b["sct"] = j.text
            k = brand.find(x("dbk:subtitle"))
            if not k is None:
                b["brand"] = k.text
                if type(b["brand"]) is unicode:
                    b["brand"] = b["brand"].encode('ascii','xmlcharrefreplace')
            k = brand.find(x("pbs:organisation-reference"))
            b["manufacturer"] = k.get(x("xlink:href"))[1:]
            b["price"] = brand.find(x("pbs:ex-manufacturer")).text
            d["brands"].append(b)
        yield d

def xml_manufacturers(t):
    for m in t.iterfind(x("pbs:organisations-list/pbs:organisation")):
        d = {}
        d["xml:id"] = m.get(x("xml:id"))
        d["code"] = m.find(x("pbs:code")).text
        d["company"] = m.find(x("dbk:title")).text
        d["address"] = " ".join([i.text for i in m.findall(x("pbs:address/dbk:street"))])
        d["address"] = "%s %s %s %s" % (d["address"],m.find(x("pbs:address/dbk:city")).text,m.find(x("pbs:address/dbk:state")).text,m.find(x("pbs:address/dbk:postcode")).text)
        d["telephone"] = m.find(x("dbk:phone")).text
        yield d
        


def backload_pbs_names():
    cantmatch = set()
    t = get_xml_etree()
    generics = {}
    for g in xml_generics_brands(t):
        generics[g["xml:id"]] = g
    for drug in xml_pbs_items(t):
        r = c.query("select fk_product from drugs.pbs where pbscode='%s' limit 1" % drug['code'])
        drug["sct"] = generics[drug["mpp"]]["sct"]
        drug["pack_size"] = generics[drug["mpp"]]["pack_size"]
        if r.ntuples() == 0:
            r = c.query("select * from drugs.product where original_pbs_name=$$%s$$" % drug['title'])
            if r.ntuples() == 0 and not drug['title'] in cantmatch:
                print """
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('','%(atc)s','%(sct)s','',,'','%(title)s',4,%(pack_size)s,null,null,1);""" % drug
                cantmatch.add(drug['title'])
        else:
            cmd("update drugs.product set original_pbs_name=$$%s$$,sct='%s',pack_size=%s where pk='%s'" % (drug['title'],drug["sct"],drug["pack_size"],r.getresult()[0][0]))

def print_all_drugs(t):
    generics = {}
    for g in xml_generics_brands(t):
        generics[g["xml:id"]] = g
    for drug in xml_pbs_items(t):
        print_drug(drug,generics)
        print 

def print_drug(drug,generics):
    print "sct: %s\natc: %s\nchapter: %s\noriginal_pbs_name: %s" % (generics[drug["mpp"]]["sct"],drug["atc"],drug["chapter"],drug["title"])
    for b in generics[drug["mpp"]]["brands"]:
        print "brand: %s" % b["brand"]


# STEP ONE: go through all drugs by SCT and complain on stdout about the ones we can't find
def import_step1(t):
    generics = {}
    for g in xml_generics_brands(t):
        generics[g["xml:id"]] = g
    for drug in xml_pbs_items(t):
        r = c.query("select * from drugs.product where sct='%s'" % generics[drug["mpp"]]["sct"])
        if r.ntuples () == 0:
            print_drug(drug,generics)
            print "generic: "
            print "form: "
            print "strength: "
            print "free_comment: "
            print "units_per_pack: 1"
            print "pack_size: %s" % generics[drug["mpp"]]["pack_size"]
            print "amount: "
            print "amount_unit: "
            print

# STEP TWO: import the human-modified new entities from stdin .
def import_step2(t):
    drug = {}
    lineno = 1
    f = open("new_scts.txt","r")
    sct_done = set()
    for l in f.readlines():
        if l == "\n":
            if drug["sct"] in sct_done:
                continue
            sct_done.add(drug["sct"])
            r = c.query("select 1 from drugs.product where sct='%s'" % drug["sct"])
            if r.ntuples () > 0:
                print >>sys.stderr, "SCT %s already exists, skipping" % drug["sct"]
                continue
            if drug["free_comment"] == "":
                drug["free_comment"] = "NULL"
            else:
                drug["free_comment"] = "$$%s$$" % drug["free_comment"]
            au = drug["amount_unit"]
            au = au.lower()
            if au == 'g' or au == "gm": 
                drug["amount_unit"] = 35
            elif au == 'ml': 
                drug["amount_unit"] = 26
            elif au == "":
                drug["amount_unit"] = "NULL"
            else:
                print >> sys.stderr, "amount %s not recognised at line %d" % (au, lineno)
                sys.exit(1)
            if drug["amount"] == "": 
                drug["amount"] = "NULL"
            r = c.query("select pk from drugs.form where form='%s'" % drug["form"])
            if r.ntuples() != 1:
                print >>sys.stderr,"can't recognise drug form %s at line %d" % (drug["form"],lineno)
                sys.exit(1)
            drug["fk_form"] = r.getresult()[0][0]
            c.query("""
insert into drugs.product (pk,generic,fk_form,free_comment,units_per_pack,pack_size,amount,amount_unit,original_pbs_name, sct, atccode)
values
(uuid_generate_v4(), $$%(generic)s$$, %(fk_form)d, %(free_comment)s, 
%(units_per_pack)s, %(pack_size)s, %(amount)s, %(amount_unit)s, $$%(original_pbs_name)s$$, '%(sct)s', '%(atc)s')
""" % drug)
            drug = {}
        else:
            s = l.split(":", 1)
            s[0] = s[0].lower().strip()
            s[1] = s[1].strip()
            drug[s[0]] = s[1]
        lineno += 1
                
def fix_packsize(t):
    cantmatch = set()
    created = set()
    t = get_xml_etree()
    generics = {}
    by_sct = {}
    for g in xml_generics_brands(t):
        generics[g["xml:id"]] = g
    for drug in xml_pbs_items(t):
        sct = generics[drug["mpp"]]["sct"]
        by_sct[sct] = drug
    for drug in xml_pbs_items(t):
        sct = generics[drug["mpp"]]["sct"]
        pack_size = generics[drug["mpp"]]["pack_size"]
        #if drug["code"] == "1003T": pdb.set_trace()
        r = c.query("select product.pk,pack_size,sct,generic,fk_form,strength,free_comment,amount,amount_unit,units_per_pack from drugs.pbs,drugs.product where pbscode='%s' and product.pk = fk_product limit 1" % drug["code"])
        if r.ntuples() == 1:
            row = r.getresult()[0]
            comment = row[6]
            amount = row[7]
            amount_unit = row[8]
            units_per_pack = row[9]
            if comment is None:
                comment = 'NULL'
            else:
                comment = "$$%s$$" % comment
            if amount is None: amount = 'NULL'
            if amount_unit is None: amount_unit = 'NULL'
            if units_per_pack is None: units_per_pack = 'NULL'
            if sct == row[2] and str(pack_size) == str(row[1]):
                print "--for PBS code %s packsize and sct match" % drug['code']
            elif sct == row[2]:
                print "--for PBS code %s sct matches but packsize doesn't, correcting" % drug["code"]
                print "update drugs.product set pack_size=%s where pk='%s';" % (pack_size,row[0])
            elif str(pack_size) == str(row[1]):
                r = c.query("select 1 from drugs.product where sct='%s'" % sct)
                if r.ntuples() == 1:
                    print "-- SCT found in different row"
                else:
                    if not sct in created:
                        print "--for PBS code %s pack_size matches but SCT doesn't" % drug["code"]
                        print "-- existing SCT is %r %r, new drug is %r %r" % (generics[by_sct[row[2]]["mpp"]],by_sct[row[2]],generics[drug["mpp"]],drug)
                        created.add(sct)
                        r = c.query("select uuid_generate_v4()")
                        pk = r.getresult()[0][0]
                        print "insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values"
                        print "('%s','%s',%s,'%s','','%s',$$%s$$,%s,'%s',%s,%s,%s);" % (pk,row[3],row[4],row[5],sct,drug['title'],pack_size,drug['atc'],amount,amount_unit,units_per_pack)
            else:
                print "-- for PBS code %s neither sct nor pack-size matches" % drug["code"]
                r = c.query("select pk,sct,pack_size from drugs.product where (pack_size=%s or pack_size is null) and generic='%s' and fk_form=%s and strength='%s' and amount is not distinct from %s and amount_unit is not distinct from %s and units_per_pack is not distinct from %s" % (pack_size,row[3],row[4],row[5],amount,amount_unit,units_per_pack))
                if r.ntuples () == 1:
                    row2 = r.getresult()[0]
                    new_sct = row2[1]
                    if new_sct == sct and str(row2[2]) == pack_size:
                        print "-- but existing product with correct SCT and pack size"
                    else:
                        print "-- old SCT is %s, old pk %s, new drug %r %r" % (row[2],row2[0],generics[drug["mpp"]],drug)
                elif r.ntuples() == 0:
                    if sct in created:
                        print "-- SCT already created this session"
                    else:
                        print "-- no existing product, creating a new one"
                        created.add(sct)
                        r = c.query("select uuid_generate_v4()")
                        pk = r.getresult()[0][0]
                        print "insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values"
                        print "('%s','%s',%s,'%s',%s,'%s',$$%s$$,%s,'%s',%s,%s,%s);" % (pk,row[3],row[4],row[5],comment,sct,drug['title'],pack_size,drug['atc'],amount,amount_unit,units_per_pack)
                else:
                    print "-- multiple matches for %r %r" % (generics[drug["mpp"]],drug)
                
def verify_brands(t):
    ms = {}
    for m in xml_manufacturers(t): ms[m["xml:id"]] = m
    for drug in xml_generics_brands(t):
        r = c.query("select pk from drugs.product where sct='%s' limit 1" % drug["sct"])
        if r.ntuples() == 1:
            fk_product = r.getresult()[0][0]
            for brand in drug["brands"]:
                code = ms[brand["manufacturer"]]["code"]
                q = "select pk,price from drugs.brand where fk_product='%s' and brand ilike $$%s$$" % (str(fk_product),brand["brand"].upper())
                r = c.query(q)
                if r.ntuples() == 0:
                    r = c.query("select pk,brand from drugs.brand where fk_product='%s' and fk_company='%s'" % (fk_product,code))
                    if r.ntuples() > 0:
                        print "--WARNING: drug has existing brands from this manufacturer, we are adding more"
                        for i in r.getresult():
                            print "--existing brand %s %s" % (i[1],i[0]) 
                            print "--update drugs.brand set brand=$$%s$$, price='%s'::money where pk='%s';" % (brand["brand"],brand["price"],i[0]) 
                    r = c.query("select uuid_generate_v4()")
                    pk = r.getresult()[0][0]
                    print """insert into drugs.brand (pk, fk_product, brand, fk_company, from_pbs, price)
                values ('%s', '%s', '%s', '%s', true, '%s'::money);""" % (pk, fk_product, brand['brand'], code, brand['price'])
                else:
                    r = r.getresult()[0]
                    price = r[1]
                    pk = r[0]
                    if price <> "$"+brand["price"]:
                        print "update drugs.brand set price='%s'::money where pk='%s';" % (brand["price"],pk)

t = get_xml_etree()
if sys.argv[1] == '1':
    import_step1(t)
elif sys.argv[1] == '2':
    import_step2(t)

