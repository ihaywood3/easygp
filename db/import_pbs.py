#!/usr/bin/python
# -*- coding: utf-8 -*-

import os, re, psycopg2, pdb, sys, glob, codecs, pdb, time, urllib2
from xml.etree.cElementTree import *

conn = psycopg2.connect(database='easygp',user='ian')
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

def x(s):
    x = {"pbs":"http://schema.pbs.gov.au", "rwt":"http://schema.pbs.gov.au/RWT/","dbk":"http://docbook.org/ns/docbook","xlink":"http://www.w3.org/1999/xlink","xml":"http://www.w3.org/XML/1998/namespace","rdf":"http://www.w3.org/1999/02/22-rdf-syntax-ns#","skos":"http://www.w3.org/2004/02/skos/core#"}
    for i, j in x.items():
        s = s.replace(i+':',"{%s}" % j)
    return s

def import_atc(t):
    for atc in xml_atc(t):
        print "select drugs.assert_atc('%s',$atc$%s$atc$);" % (atc["atccode"], atc["atcname"])

def import_mnfr(t):
    for m in xml_manufacturers(t):
        print "select drugs.assert_company('%(code)s',$$%(company)s$$,$$%(address)s$$,'%(telephone)s');" % m

def import_pbs(t):
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

def last_file(g):
    t = sorted(glob.glob(g))
    if len(t) == 0: return None
    return t[-1]

def get_xml_etree():
    global release_date
    f = last_file("pbs*.xml")
    if not f:
        f = last_file("pbs*.zip")
        if f:
            os.system("unzip -Laq '%s'" % f)
            f = last_file("pbs*.xml")
    if f is None:
        print >>sys.stderr, "can't find pbs-DATE.xml"
        sys.exit(1)
    m = re.match('pbs-([0-9\-]+).*\.xml',f)
    release_date = m.group(1)
    return parse(f)

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
    already_done = set()
    for drug in xml_pbs_items(t):
        sct =  generics[drug["mpp"]]["sct"]
        r = query("select * from drugs.product where sct='%s'" % sct)
        if len(r) == 0:
            if not sct in already_done:
                already_done.add(sct)
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
                

# STEP THREE: update/create new brands where required        
def verify_brands(t):
    ms = {}
    cmd("update drugs.brand set current=false where from_pbs")
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
                        print "WARNING: drug has existing brands from this manufacturer, we are adding more"
                        for i in r:
                            print "existing brand %s %s %s %s" % (i['brand'],i["pk"], i["sct"],i["price"]) 
                            print "update drugs.brand set brand=$$%s$$, price='%s'::money,sct='%s',current=true where pk='%s';" % (brand["brand"],brand["price"],brand["sct"],i["pk"]) 
                    else:
                        r = query("select uuid_generate_v4() as uuid")
                        pk = r[0]['uuid']
                        cmd("""insert into drugs.brand (pk, fk_product, sct, brand, fk_company, from_pbs, price)
                values ('%s', '%s', '%s', '%s', '%s', true, '%s'::money);""" % (pk, fk_product, brand['sct'], brand['brand'], code, brand['price']))
                else:
                    r = r[0]
                    price = r["price"]
                    price = price.replace(',','')
                    pk = r["pk"]
                    if price <> "$"+brand["price"]:
                        cmd("update drugs.brand set price='%s'::money, fk_company='%s',brand=$$%s$$,current=true where pk='%s';" % (brand["price"],code,brand['brand'],pk))


def print_brands():
    """
    Run through all brands and print assert_brand commands"""
    r = query("select * from drugs.brand")
    for i in r:
        if i['sct'] is None:
            i['sct'] = 'NULL'
        else:
            i['sct'] = "'%s'" % i['sct']
        if i['price'] is None:
            i['price'] = 'NULL'
        else:
            i['price'] = "'%s'::money" % i['price']
        if i['product_information_filename'] is None:
            i['product_information_filename'] = 'NULL'
        else:
            i['product_information_filename'] = "'%s'" % i['product_information_filename']
        if i["from_pbs"]:
            i["from_pbs"] = "true"
        else:
            i["from_pbs"] = "false"
        print "select drugs.assert_brand('%(pk)s', '%(fk_product)s', '%(fk_company)s', $$%(brand)s$$, %(sct)s, %(price)s, %(from_pbs)s, %(product_information_filename)s);" % i

def print_products():
    """Run through all products and print assert_product commands"""
    r = query("select * from drugs.product")
    for i in r:
        if i["free_comment"] is None or i["free_comment"] == '':
            i["free_comment"] = "NULL"
        else:
            i["free_comment"] = "$$%s$$" % i["free_comment"]
        if i["salt"] is None:
            i["salt"] = "NULL"
        else:
            i["salt"] = "$$%s$$" % i["salt"]
        if i["salt_strength"] is None:
            i["salt_strength"] = "NULL"
        else:
            i["salt_strength"] = "$$%s$$" % i["salt_strength"]
        if i["sct"] is None:
            i["sct"] = "NULL"
        else:
            i["sct"] = "'%s'" % i["sct"]
        if i["original_pbs_name"] is None:
            i["original_pbs_name"] = "NULL"
        else:
            i["original_pbs_name"] = "$$%s$$" % i["original_pbs_name"]
        if i["amount"] is None: i["amount"] = "NULL"
        if i["amount_unit"] is None: i["amount_unit"] = "NULL"
        if i["fk_schedule"] is None: i["fk_schedule"] = "NULL"
        if i["pack_size"] is None: i["pack_size"] = "NULL"
        print """select drugs.assert_product('%(pk)s'::uuid,'%(atccode)s',$$%(generic)s$$,%(fk_form)s,$$%(strength)s$$,%(original_pbs_name)s,
                 %(free_comment)s,%(fk_schedule)s,%(pack_size)s,%(amount)s,
                 %(amount_unit)s,%(units_per_pack)s,%(sct)s,%(salt)s,%(salt_strength)s,'%(updated_at)s'::timestamp);""" % i

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
  - products: scan PBS xml and produce a text report on stdout of new drugs for hand-editing
  - import: accepts on stdin list from above after editing and imports into DB, no output
  - brands: imports all new brands, may report errors
  - print: complete sql update on stdout
  """


if len(sys.argv) > 1:
    cd = sys.argv[1]
else:
    cd = "--help"

if cd == '1' or cd == 'products':
    import_step1(get_xml_etree()) # produce list of new products for editing
elif cd == '2' or cd == 'import':
    import_step2() # read back in the edited list of products, execute on DB, no SQL produced
elif cd == '3' or cd == 'brands':
    verify_brands(get_xml_etree()) # brands, may spit out errors
elif cd == '4' or cd == 'print':
    t = get_xml_etree()
    print """\\set ON_ERROR_STOP 1
\\o /dev/null
\\set QUIET 1
DO language plpgsql $$
DECLARE
   vers db.lu_version%ROWTYPE;
BEGIN
   select * into vers from db.lu_version;
   if vers.lu_minor < 317 then 
      raise exception 'database version must be 317 or higher';
   end if;
END$$;
"""
    import_mnfr(t) # company information
    import_atc(t)
    print_products() # idempotent sql commands for full dump of products
    print_brands() # and brands
    print "truncate drugs.pbs, drugs.restriction;"
    import_pbs(t) # pbs and restrictions, produce dump-and-reload SQL 
    import_restricts(t)
    print "update drugs.version set release_date='%s';" % release_date
elif cd == 'scts':
    scan_all_scts()
elif cd == "--help":
    print_help()
else:
    print >>sys.stderr,"unknown command: %s" % cd
    print_help()
