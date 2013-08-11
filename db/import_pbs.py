#!/usr/bin/python
# -*- coding: utf-8 -*-

import os, re, psycopg2, pdb, sys, glob, codecs, pdb, time, urllib2
from xml.etree.cElementTree import *

conn = psycopg2.connect(database='drugs',user='ian')


now_t = time.strftime("%Y-%m-%d %H:%M:%S",time.localtime(time.time()))

def query(q,params=()):
    cur = conn.cursor()
    cur.execute(q,params)
    r = [makedict(cur.description,j) for j in cur.fetchall()]
    cur.close()
    return r
    
def makedict(desc,row):
    d = {}
    for i in range(0,len(desc)):
        d[desc[i][0]] = row[i]
    return d

def cmd(q):
    cur = conn.cursor()
    cur.execute(q)
    cur.close()
    conn.commit()
    print q+";"
    

def comment(sql):
    print "--"+sql

def x(s):
    x = {"pbs":"http://schema.pbs.gov.au", "rwt":"http://schema.pbs.gov.au/RWT/","dbk":"http://docbook.org/ns/docbook","xlink":"http://www.w3.org/1999/xlink","xml":"http://www.w3.org/XML/1998/namespace","rdf":"http://www.w3.org/1999/02/22-rdf-syntax-ns#","skos":"http://www.w3.org/2004/02/skos/core#"}
    for i, j in x.items():
        s = s.replace(i+':',"{%s}" % j)
    return s

def import_atc(t):
    for atc in xml_atc(t):
        r = query("select 1 from drugs.atc where atccode='%s'" % atc["atccode"])
        if len(r) == 0:
            "insert into drugs.atc (atccode, atcname) values ($$%s$$, $$%s$$)" % (atc["atccode"],atc["atcname"])

def import_mnfr(t):
    for m in xml_manufacturers(t):
        r = query("select * from drugs.company where code='%s'" % m["code"])
        if len(r) == 1:
            if m["company"] != r[0]["company"] or m["address"] != r[0]["address"] or m['telephone'] != r[0]['telephone']:
                print """
update drugs.company set company=$$%(company)s$$,address=$$%(address)s$$,telephone='%(telephone)s'
where code='%(code)s'""" % m
        else:
            print """
insert into drugs.company (code,company,address,telephone) values
('%(code)s',$$%(company)s$$,$$%(address)s$$,'%(telephone)s')""" % m

def import_pbs(t):
    print "truncate drugs.pbs cascade;"
    generics = {}
    for g in xml_generics_brands(t):
        generics[g["xml:id"]] = g
    for item in xml_pbs_items(t):
        g = generics[item["mpp"]]
        item["mpp"] = g
        sct = g["sct"]
        manual_matches = {'27227011000036100':'9bb5d495-c26a-4a39-8b4f-bc2c0c84b026'} # advantan fatty ointment
        fk_product = None
        if sct in manual_matches:
            fk_product = manual_matches[sct]
        else:
            r = query("select pk from drugs.product where sct='%s'" % sct)
            if len(r) == 0:
                print >>sys.stderr, "WARNING: %r doesn't match on SCT" % item
            elif len(r) > 1:
                print >>sys.stderr, "WARNING: %r matches multiple products on SCT" % item
            else:
                fk_product = r[0]["pk"]
        if fk_product:
            if item["type"] == "streamlined" or item["type"] == "authority" or item["type"] == 'authority-required':
                flag = "A"
            elif item["type"] == "restricted":
                flag = "R"
            elif item["type"] == 'unrestricted':
                flag = "U"
            else:
                print >>sys.stderr,"I saw an unrecognised type %s on pbscode %s" % (item["type"], item['code'])
                flag = "u"
            print """
insert into drugs.pbs (fk_product,pbscode,quantity,max_rpt,chapter,restrictionflag)
values ('%s','%s',%s,%s,'%s','%s');
""" % (fk_product,item['code'],item['quantity'],item['max_rpt'],item['chapter'],flag)


def import_restricts(t):
    print "truncate drugs.restriction;"  
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
                print "insert into drugs.restriction (pbscode, code, streamlined, restriction) values ('%s','%s','%s',$$%s$$);" % (pbscode, r['code'], streamlined,r['restriction'])

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
            blocked_atc = False
            for i in ['V06DX','V07AY']: # amino acids, dressings
                if d["atc"].find(i) == 0:
                    blocked_atc = True
            if not blocked_atc:
                d["type"] = drug.get("type")
                d["restricts"] = [l.get(x("xlink:href"))[1:] for l in drug.iterfind(x(".//rwt:restriction-references-list/rwt:restriction-reference"))]
                d["mpps"] = [j.get(x("xlink:href"))[1:] for j in drug.iterfind(x(".//pbs:mpp-reference"))]
                if not (d['chapter'] == 'IN' or d['chapter'] == 'EP' or d['chapter'] == 'IP'):
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
        r = query("select fk_product from drugs.pbs where pbscode='%s' limit 1" % drug['code'])
        drug["sct"] = generics[drug["mpp"]]["sct"]
        drug["pack_size"] = generics[drug["mpp"]]["pack_size"]
        if len(r) == 0:
            r = query("select * from drugs.product where original_pbs_name=$$%s$$" % drug['title'])
            if len(r) == 0 and not drug['title'] in cantmatch:
                print """
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('','%(atc)s','%(sct)s','',,'','%(title)s',4,%(pack_size)s,null,null,1);""" % drug
                cantmatch.add(drug['title'])
        else:
            cmd("update drugs.product set original_pbs_name=$$%s$$,sct='%s',pack_size=%s where pk='%s'" % (drug['title'],drug["sct"],drug["pack_size"],r[0]["fk_product"]))

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
        r = query("select * from drugs.product where sct='%s'" % generics[drug["mpp"]]["sct"])
        if len(r) == 0:
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
def import_step2():
    drug = {}
    lineno = 1
    sct_done = set()
    for l in sys.stdin.readlines():
        if l.strip() == "":
            if "sct" in drug and not drug["sct"] in sct_done:
                sct_done.add(drug["sct"])
                r = query("select 1 from drugs.product where sct='%s'" % drug["sct"])
                if len(r) > 0:
                    print >>sys.stderr, "SCT %s already exists, skipping" % drug["sct"]
                else:
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
                    r = query("select pk from drugs.form where form='%s'" % drug["form"])
                    if len(r) != 1:
                        print >>sys.stderr,"can't recognise drug form %s at line %d" % (drug["form"],lineno)
                        sys.exit(1)
                    drug["fk_form"] = r[0]["pk"]
                    drug["uuid"] = query("select uuid_generate_v4() as uuid")[0]["uuid"]
                    cmd("""
insert into drugs.product (pk,generic,fk_form,free_comment,units_per_pack,pack_size,amount,amount_unit,original_pbs_name, sct, atccode, strength)
values
('%(uuid)s', $$%(generic)s$$, %(fk_form)d, %(free_comment)s, 
%(units_per_pack)s, %(pack_size)s, %(amount)s, %(amount_unit)s, $$%(original_pbs_name)s$$, '%(sct)s', '%(atc)s',$$%(strength)s$$)
""" % drug)
                    drug = {}
        else:
            s = l.split(":", 1)
            if len(s) != 2:
                print >>sys.stderr, "invalid line %r at line %d" % (l,lineno)
            else:
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
        r = query("select product.pk,pack_size,sct,generic,fk_form,strength,free_comment,amount,amount_unit,units_per_pack from drugs.pbs,drugs.product where pbscode='%s' and product.pk = fk_product limit 1" % drug["code"])
        if len(r) == 1:
            row = r[0]
            comment = row["free_comment"]
            amount = row["amount"]
            amount_unit = row["amount_unit"]
            units_per_pack = row["units_per_pack"]
            if comment is None:
                comment = 'NULL'
            else:
                comment = "$$%s$$" % comment
            if amount is None: amount = 'NULL'
            if amount_unit is None: amount_unit = 'NULL'
            if units_per_pack is None: units_per_pack = 'NULL'
            if sct == row["sct"] and str(pack_size) == str(row["pack_size"]):
                print "--for PBS code %s packsize and sct match" % drug['code']
            elif sct == row["sct"]:
                print "--for PBS code %s sct matches but packsize doesn't, correcting" % drug["code"]
                print "update drugs.product set pack_size=%s where pk='%s';" % (pack_size,row[0])
            elif str(pack_size) == str(row["pack_size"]):
                r = query("select 1 from drugs.product where sct='%s'" % sct)
                if len(r) == 1:
                    print "-- SCT found in different row"
                else:
                    if not sct in created:
                        print "--for PBS code %s pack_size matches but SCT doesn't" % drug["code"]
                        print "-- existing SCT is %r %r, new drug is %r %r" % (generics[by_sct[row[2]]["mpp"]],by_sct[row[2]],generics[drug["mpp"]],drug)
                        created.add(sct)
                        r = query("select uuid_generate_v4() as uuid")
                        pk = r[0]["uuid"]
                        print "insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values"
                        print "('%s','%s',%s,'%s','','%s',$$%s$$,%s,'%s',%s,%s,%s);" % (pk,row[3],row[4],row[5],sct,drug['title'],pack_size,drug['atc'],amount,amount_unit,units_per_pack)
            else:
                print "-- for PBS code %s neither sct nor pack-size matches" % drug["code"]
                r = query("select pk,sct,pack_size from drugs.product where (pack_size=%s or pack_size is null) and generic='%s' and fk_form=%s and strength='%s' and amount is not distinct from %s and amount_unit is not distinct from %s and units_per_pack is not distinct from %s" % (pack_size,row[3],row[4],row[5],amount,amount_unit,units_per_pack))
                if len(r) == 1:
                    row2 = r[0]
                    new_sct = row2["sct"]
                    if new_sct == sct and str(row2["pack_size"]) == pack_size:
                        print "-- but existing product with correct SCT and pack size"
                    else:
                        print "-- old SCT is %s, old pk %s, new drug %r %r" % (row[2],row2[0],generics[drug["mpp"]],drug)
                elif len(r) == 0:
                    if sct in created:
                        print "-- SCT already created this session"
                    else:
                        print "-- no existing product, creating a new one"
                        created.add(sct)
                        r = query("select uuid_generate_v4() as uuid")
                        pk = r[0]["uuid"]
                        print "insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values"
                        print "('%s','%s',%s,'%s',%s,'%s',$$%s$$,%s,'%s',%s,%s,%s);" % (pk,row[3],row[4],row[5],comment,sct,drug['title'],pack_size,drug['atc'],amount,amount_unit,units_per_pack)
                else:
                    print "-- multiple matches for %r %r" % (generics[drug["mpp"]],drug)

# STEP THREE: update/create new brands where required        
def verify_brands(t):
    ms = {}
    for m in xml_manufacturers(t): ms[m["xml:id"]] = m
    for drug in xml_generics_brands(t):
        r = query("select pk from drugs.product where sct='%s' limit 1" % drug["sct"])
        if len(r) == 1:
            fk_product = r[0]['pk']
            for brand in drug["brands"]:
                code = ms[brand["manufacturer"]]["code"]
                q = "select pk,price from drugs.brand where sct='%s'" % brand["sct"]
                r = query(q)
                if len(r) == 0:
                    r = query("select pk,brand,sct,price from drugs.brand where fk_product='%s' and fk_company='%s'" % (fk_product,code))
                    if len(r) > 0:
                        print "--WARNING: drug has existing brands from this manufacturer, we are adding more"
                        for i in r:
                            print "--existing brand %s %s %s %s" % (i['brand'],i["pk"], i["sct"],i["price"]) 
                            print "--update drugs.brand set brand=$$%s$$, price='%s'::money,sct='%s' where pk='%s';" % (brand["brand"],brand["price"],brand["sct"],i["pk"]) 
                    r = query("select uuid_generate_v4() as uuid")
                    pk = r[0]['uuid']
                    print """insert into drugs.brand (pk, fk_product, sct, brand, fk_company, from_pbs, price)
                values ('%s', '%s', '%s', '%s', '%s', true, '%s'::money);""" % (pk, fk_product, brand['sct'], brand['brand'], code, brand['price'])
                else:
                    r = r[0]
                    price = r["price"]
                    price = price.replace(',','')
                    pk = r["pk"]
                    if price <> "$"+brand["price"]:
                        print "update drugs.brand set price='%s'::money where pk='%s';" % (brand["price"],pk)

def scan_scts_in_file(f):
    rex = re.compile("<a href=\".*/browser/concept/([0-9]+)\">([^<]+)</a>")
    for l in f.readlines():
        m = rex.search(l)
        if m:
            sct = m.group(1)
            desc = m.group(2)
            #r = query("select * from drugs.product where sct='%s'" % sct)
            #if len(r) == 0:
            yield (sct,desc)
            
def scan_all_scts():
    with open("/home/ian/all-scts.html") as f:
        for drug_sct,drug_desc in scan_scts_in_file(f):
            in_db = False
            u = urllib2.urlopen("http://au.federationhealth.com/browser/concept/%s" % drug_sct)
            for mpp_sct,mpp_desc in scan_scts_in_file(u):
                if not in_db:
                    if "product pack" in mpp_desc:
                        r = query("select 1 from drugs.product where sct='%s'" % mpp_sct)
                        if len(r) > 0: in_db = True
            u.close()
            if not in_db:
                print "%s\t%s" % (drug_sct,drug_desc)
            time.sleep(60)


def print_help():
    print """Import PBS data
import_pbs.py cmd
cmd is:
  - products: scan PBS xml and produce a text report on stdin of new drugs for hand-editing
  - import: takes list from above after editing on stdiamprenavirn and imports into DB, produces SQL on stdout
  - brands: imports all new brands, SQL on stdout (not executed)
  - pbs: imports all PBS data, SQL on stdout
  - atc: imports new ATC and manufacturer data, SQL on stdout
  """


if len(sys.argv) > 1:
    cd = sys.argv[1]
else:
    cd = "--help"

if cd == '1' or cd == 'products':
    import_step1(get_xml_etree()) # produce list of new products for editing
elif cd == '2' or cd == 'import':
    import_step2() # read back in the edited list of products, execute and spit out SQL 
elif cd == '3' or cd == 'brands':
    verify_brands(get_xml_etree()) # brands, just produce SQL (no execute)
elif cd == '4' or cd == 'pbs':
    t = get_xml_etree()
    import_pbs(t) # pbs and restrictions, produce SQL 
    import_restricts(t)
elif cd == '5' or cd == 'atc':
    t = get_xml_etree()
    import_mnfr(t) # produce ATCs and company information
    import_atc(t)
elif cd == 'scts':
    scan_all_scts()
elif cd == "--help":
    print_help()
else:
    print >>sys.stderr,"unknown command: %s" % cd
    print_help()
