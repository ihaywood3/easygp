#!/usr/bin/python
# -*- coding: utf-8 -*-

import os, re, psycopg2, pdb, sys, glob, codecs, pdb, time, urllib2, sys, pudb
from xml.etree.cElementTree import *

conn = psycopg2.connect(database='rtdrugs',user=os.environ["USER"])
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

class Skip(Exception): pass

def safe_int_input(prompt, maxi=10000000, default=0):
    while True:
        try:
            answer = raw_input(prompt)
            if answer == 'skip':
                raise Skip()
            if answer == "":
                return default
            answer = int(answer)
            if answer > maxi:
                print("beyond maximum allowed of {}".format(maxi))
            else:
                return answer
        except ValueError: 
            print "not an integer"

def x(s):
    x = {"pbs":"http://schema.pbs.gov.au", "rwt":"http://schema.pbs.gov.au/RWT/","dbk":"http://docbook.org/ns/docbook","xlink":"http://www.w3.org/1999/xlink","xml":"http://www.w3.org/XML/1998/namespace","rdf":"http://www.w3.org/1999/02/22-rdf-syntax-ns#","skos":"http://www.w3.org/2004/02/skos/core#"}
    for i, j in x.items():
        s = s.replace(i+':',"{%s}" % j)
    return s

def import_atc(t,output):
    for atc in xml_atc(t):
        print >>output, "select drugs.assert_atc('%s',$atc$%s$atc$);" % (atc["atccode"], atc["atcname"])

def import_mnfr(t,output):
    for m in xml_manufacturers(t):
        q = "select drugs.assert_company('%(code)s',$$%(company)s$$,$$%(address)s$$,'%(telephone)s');" % m
        print >>output,q
        cmd(q)

def import_pbs(t,ofile):
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
            r = query("select fk_product from drugs.link_product_sct where sct='%s'" % sct)
            if len(r) == 0:
                print >>sys.stderr, "WARNING: %r doesn't match on SCT" % item
            elif len(r) > 1:
                print >>sys.stderr, "WARNING: %r matches multiple products on SCT" % item
            else:
                fk_product = r[0]["fk_product"]
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
            print >>ofile,"""
insert into drugs.pbs (fk_product,pbscode,quantity,max_rpt,chapter,restrictionflag)
values ('%s','%s',%s,%s,'%s','%s');
""" % (fk_product,item['code'],item['quantity'],item['max_rpt'],item['chapter'],flag)


def import_restricts(t,ofile):
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
                print >>ofile,"insert into drugs.restriction (pbscode, code, streamlined, restriction) values ('%s','%s','%s',$$%s$$);" % (pbscode, r['code'], streamlined,r['restriction'])

def last_file(g):
    t = sorted(glob.glob(g))
    if len(t) == 0: return None
    return t[-1]

def get_xml_etree(fname):
    global release_date
    f = fname
    if not os.path.exists(f):
        print >>sys.stderr, "can't find file"
        sys.exit(1)
    m = re.match('[a-z]+-([0-9]+-[0-9]+-[0-9]+).*\.xml',f)
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

def print_drug(drug,generics,output=sys.stdout):
    print >>output, "sct: %s\natc: %s\nchapter: %s\noriginal_pbs_name: %s" % (generics[drug["mpp"]]["sct"],drug["atc"],drug["chapter"],drug["title"])
    for b in generics[drug["mpp"]]["brands"]:
        print >>output, "brand: %s" % b["brand"]


def attempt_parse(title,pack_size):
    m = re.match("([a-z]+) ([0-9\.]+) (microgram|mg) ([a-z]+), %d" % pack_size, title)
    if m:
        generic = m.group(1)
        sunit = m.group(3)
        if sunit == 'microgram': sunit = 'mcg'
        strength = m.group(2)+sunit
        form = m.group(4)
        if form == "modified-release tablet":
            form = "slow-release tablet"
        if form == "modified-release capsule":
            form = "slow-release capsule"
        r = query("select pk from drugs.form where form='%s'" % form)
        if len(r) > 0:
            fk_form = r[0]['pk']
            return (generic,strength,form,fk_form,"NULL","NULL")
    #pdb.set_trace()
    m = re.match("([a-z]+) ([0-9]+) microgram/([0-9\.]+) mL injection, ([0-9\.]+) mL vial",title)
    if m:
        generic = m.group(1)
        strength = m.group(2)+"mcg"
        if m.group(3) == m.group(4):
            amount = float(m.group(4))
            return (generic,strength,'injection',22,amount,26)
    m = re.match("([a-z]+) ([0-9\.]+) mg/([0-9\.]+) mL injection, ([0-9\.]+) mL syringe",title)
    if m:
        generic = m.group(1)
        strength = m.group(2)+"mg"
        if m.group(3) == m.group(4):
            amount = float(m.group(4))
            return (generic,strength,'injection',22,amount,26)
    m = re.match("([a-z]+) ([0-9\.]+) mg/([0-9\.]+) mL injection, %d x ([0-9\.]+) mL syringes" % pack_size,title)
    if m:
        generic = m.group(1)
        strength = m.group(2)+"mg"
        if m.group(3) == m.group(4):
            amount = float(m.group(4))
            return (generic,strength,'injection',22,amount,26)
    m = re.match("([a-z]+) ([0-9\.]+) mg/mL injection, 1 mL injection device",title)
    if m:
        generic = m.group(1)
        strength = m.group(2)+"mg"
        return (generic,strength,'injection',22,1.0,22)
    return None

def drug_name(fk_product):
    r = query("select p.pk, p.generic,f.form,p.strength,p.amount,p.amount_unit,p.pack_size,p.units_per_pack,p.free_comment from drugs.product p, drugs.form f where p.fk_form = f.pk and p.pk = %s",(fk_product,))
    nam = r[0]['generic']+' '+r[0]['form']+' '+r[0]['strength']
    if not r[0]['amount_unit'] is None:
        nam += ' %.2f ' % r[0]['amount']
        if r[0]['amount_unit'] == 26:
            nam+='ml'
        else:
            nam+='g'
    if r[0]['pack_size'] != 1:
        nam+=' pack size: %d' % r[0]['pack_size']
    if r[0]['units_per_pack'] != 1:
        nam+=' units per pack: %d' % r[0]['units_per_pack']
    if not r[0]['free_comment'] is None:
        nam+=' ('+r[0]['free_comment']+')'
    nam+=' product.pk=%s' % r[0]['pk']
    return nam

# STEP ONE: go through all drugs by SCT and chat to the user about the ones we can't find
def import_products(t):
    global release_date
    generics = {}
    for g in xml_generics_brands(t):
        generics[g["xml:id"]] = g
    already_done = set()
    skipped = False
    for drug in xml_pbs_items(t):
        try:
            #if drug["title"] == 'choriogonadotropin alfa 250 microgram/0.5 mL injection, 1 dose': pdb.set_trace()
            sct =  generics[drug["mpp"]]["sct"]
            r = query("select * from drugs.link_product_sct where sct='%s'" % sct)
            if len(r) == 0:
                # there's no SCT match, look on the PBS product name
                r = query("select * from drugs.link_product_sct where original_pbs_name=%s",(drug["title"],))
                if len(r) > 0:
                    print "SCT seems to have changed on %s " % r[0]["original_pbs_name"]
                    cmd("insert into drugs.link_product_sct (fk_product,sct,original_pbs_name) values ('%s', '%s', $$%s$$)" %
                        (r[0]["fk_product"],generics[drug["mpp"]]["sct"],drug["title"]))
                else:
                    if not sct in already_done:
                        already_done.add(sct)
                        res = set()
                        # no product match, could be new product
                        # first look for match on PBS item codes
                        print
                        print "New drug product found: %s" % drug["title"]
                        for drug2 in xml_pbs_items(t):
                            if drug2["title"] == drug["title"]: # all items of the same drug
                                for r in query("select pro.pk, pbs.pbscode from drugs.pbs pbs, drugs.product pro where pbs.pbscode=%s and pro.pk = pbs.fk_product", (drug2["code"],)):
                                    print "found match using PBS item code %s" % r['pbscode']
                                    res.add(r['pk'])
                        if len(res) == 0: 
                            # OK, no matches on PBS item, let's check by brand name (exact match only)
                            for b in generics[drug["mpp"]]["brands"]:
                                r = query("select p.pk as pk from drugs.brand b, drugs.product p where b.fk_product = p.pk and b.brand = %s", (b["brand"],))
                                if len(r) > 0:
                                    print "found match using brandname %s" % b["brand"]
                                    for i in r:
                                        res.add(i['pk'])
                        flag = True
                        if len(res) > 0:
                            print "Some possible existing DB entries that may match this drug. If completely equivalent generic product exists (form, quantity, AND pack size) select the number and RETURN"
                            print "if no match, just RETURN"
                            print
                            print "List of existing"
                            print "----------------"
                            res = list(res)
                            for i in range(0,len(res)):
                                print "%d) %s" % (i+1, drug_name(res[i]))
                            answer = safe_int_input('No:', len(res))
                            if answer > 0:
                                chosen = res[answer-1]
                                cmd("insert into drugs.link_product_sct (fk_product,sct,original_pbs_name) values ('%s','%s','%s')" % (chosen,sct,drug['title']))
                                flag = False
                            else:
                                print "you chose no match: likely proceeding to manual entry"
                        if flag:
                            pack_size = int(generics[drug["mpp"]]["pack_size"])
                            r = attempt_parse(drug["title"], pack_size)
                            if r:
                                generic, strength, form, fk_form, amount, amount_unit = r
                                print "I can autoparse!\ngeneric: %s\nform: %s\nstrength: %s\namount: %s\n" % (generic,form,strength,amount)
                                units_per_pack = 1
                                free_comment = "NULL"
                            else:
                                print
                                print "Manual entry required"
                                print_drug(drug,generics,sys.stdout)
                                print
                                generic = raw_input("Enter the generic product name:")
                                if generic == 'skip':
                                    raise Skip()
                                while True:
                                    form = raw_input("Enter the form from standard list (see docs):")
                                    if form == 'skip':
                                        raise Skip()
                                    r = query("select pk from drugs.form where form='%s'" % form)
                                    if len(r) != 1:
                                        print "that's not a valid form"
                                    else:
                                        fk_form = r[0]["pk"]
                                        break
                                while True:
                                    raw = raw_input("Enter the total amount of %s (NOT active ingredient) (can leave blank if N/A): " % form)
                                    try:
                                        if raw == "":
                                            amount="NULL"
                                            amount_unit="NULL"
                                            break
                                        elif raw == 'skip':
                                            raise Skip()
                                        elif raw.endswith('g'):
                                            amount = float(raw[:-1])
                                            amount_unit = 35
                                            break
                                        elif raw.endswith('ml'):
                                            amount = float(raw[:-2])
                                            amount_unit = 26
                                            break
                                        else:
                                            print "units must be g (grams) or ml (millilitres)"
                                    except ValueError:
                                        print "not a valid number"
                                strength_invalid = True
                                while strength_invalid:
                                    strength = raw_input("input strength (see docs):")
                                    if strength == 'skip': raise Skip()
                                    if len(strength.split('-')) == len(generic.split(';')):
                                        strength_invalid = False
                                    else:
                                        print "number of components must match generic"
                                units_per_pack = safe_int_input("units per pack (default 1, PBS pack size is %d): " % pack_size, default=1)
                                free_comment = raw_input('free comment (optional):')
                                if free_comment == "":
                                    free_comment = "NULL"
                                elif free_comment == 'skip':
                                    raise Skip()
                                else:
                                    free_comment = "$$%s$$" % free_comment
                            # now save to DB
                            q = "select * from drugs.product where generic=%s and fk_form=%s and strength=%s and pack_size=%s"
                            params = [generic,fk_form,strength,pack_size]
                            if amount_unit== "NULL":
                                q += " and amount is NULL"
                            else:
                                q += " and amount = %s"
                                params.append(amount)
                            if free_comment == "NULL":
                                q += " and free_comment is null"
                            else:
                                q += " and free_comment = %s"
                                params.append(free_comment)
                            params = tuple(params)
                            r = query(q,params)
                            if len(r) > 0:
                                r = r[0]
                                print >>sys.stderr, "WARNING: %s %s %s looks pretty similar to existing drug PK %s " % (generic,form,strength,r["pk"])
                                answer = raw_input("Truly ifferent drug(y/N)?")
                                if answer == "y":
                                    do_it = True
                                elif answer == 'skip':
                                    raise Skip()
                                else:
                                    do_it = False
                            else:
                                do_it = True
                            if do_it:
                                uuid = query("select uuid_generate_v4() as uuid")[0]["uuid"]
                                cmd("""
                            insert into drugs.product (pk,generic,fk_form,free_comment,units_per_pack,pack_size,amount,amount_unit,atccode, strength)
                            values
                            ('%s', $$%s$$, %d, %s, %s, %s, %s, %s, '%s',$$%s$$)
                            """ % (uuid,generic,fk_form,free_comment,units_per_pack,pack_size,amount,amount_unit,drug["atc"],strength))
                                cmd("insert into drugs.link_product_sct (fk_product, sct, original_pbs_name) values ('%s', '%s', $$%s$$)" %
                                    (uuid, sct, drug['title']))
                            else:
                                cmd("insert into drugs.link_product_sct (fk_product, sct, original_pbs_name) values ('%s', '%s', $$%s$$)" %
                                    (r["pk"], sct, drug['title']))
        except Skip:
            print "drug skipped, but you need to come back to it later"
            skipped = True
    if skipped:
        print "drugs skipped, you need to re-run before you can generate SQL"
        sys.exit(1)
                            
# STEP TWO: update/create new brands where required
def verify_brands(t):
    ms = {}
    print 
    print "BRAND PROCESSING SECTION"
    print "-----------------------"
    print
    cmd("update drugs.brand set current=false where from_pbs")
    for m in xml_manufacturers(t): ms[m["xml:id"]] = m
    for drug in xml_generics_brands(t):
        r = query("select fk_product from drugs.link_product_sct where sct='%s' limit 1" % drug["sct"])
        if len(r) == 1:
            fk_product = r[0]['fk_product']
            for brand in drug["brands"]:
                code = ms[brand["manufacturer"]]["code"]
                q = "select pk,price from drugs.brand where sct=%s or (brand ilike %s and fk_product=%s)" 
                r = query(q,(brand["sct"],brand["brand"],fk_product))
                if len(r) == 0:
                    r = query("select uuid_generate_v4() as uuid")
                    pk = r[0]['uuid']
                    cmd("""insert into drugs.brand (pk, fk_product, sct, brand, fk_company, from_pbs, price)
                values ('%s', '%s', '%s', $$%s$$, '%s', true, '%s'::money);""" % (pk, fk_product, brand['sct'], brand['brand'], code, brand['price']))
                else:
                    r = r[0]
                    price = r["price"]
                    if price is not None:
                        price = price.replace(',','')
                        pk = r["pk"]
                        if price <> "$"+brand["price"]:
                            cmd("update drugs.brand set price='%s'::money, fk_company='%s',brand=$$%s$$,sct='%s',current=true where pk='%s';" % (brand["price"],code,brand['brand'],brand['sct'],pk))
    q = "select b.fk_product, b.brand, b.fk_company, b.fk_product, b.price, b.pk from drugs.brand b, drugs.product p where b.fk_product = p.pk and from_pbs and not current"
    r = query(q)
    for i in r:
        r2 = query("select b.brand, b.price, b.pk from drugs.brand b where fk_product='%s' and fk_company='%s' and current" % (i['fk_product'],i['fk_company']))
        if len(r2) == 1:
            print "%r (%s) price %s isn't in the PBS anymore" % (i['brand'],drug_name(i['fk_product']),i['price'])
            print "But wait, the same company now makes %r price %s" % (r2[0]['brand'],r2[0]['price'])
            while True:
                decision = raw_input("are they the same drug? (y/n):")
                if decision == 'y':
                    print "updating %r to %r" % (i['brand'],r2[0]['brand'])
                    cmd("delete from drugs.brand where pk='%s'" % r2[0]['pk'])
                    cmd("update drugs.brand set brand=$$%s$$,price='%s' where pk='%s'" % (r2[0]['brand'],r2[0]['price'],i['pk']))
                    break
                elif decision == 'n':
                    print "ok, leaving it in as a new brand"
                    break
                else:
                    print "sorry you must choose 'y' or 'n'"
            print
        


def print_brands(ofile):
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
        print >>ofile,"select drugs.assert_brand('%(pk)s', '%(fk_product)s', '%(fk_company)s', $$%(brand)s$$, %(sct)s, %(price)s, %(from_pbs)s, %(product_information_filename)s);" % i

def print_products(ofile):
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
        if i["amount"] is None: i["amount"] = "NULL"
        if i["amount_unit"] is None: i["amount_unit"] = "NULL"
        if i["fk_schedule"] is None: i["fk_schedule"] = "NULL"
        if i["pack_size"] is None: i["pack_size"] = "NULL"
        print >>ofile,"""select drugs.assert_product('%(pk)s'::uuid,'%(atccode)s',$$%(generic)s$$,%(fk_form)s,$$%(strength)s$$,null,
                 %(free_comment)s,%(fk_schedule)s,%(pack_size)s,%(amount)s,
                 %(amount_unit)s,%(units_per_pack)s,null,%(salt)s,%(salt_strength)s,'%(updated_at)s'::timestamp);""" % i

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
import_pbs.py file
cmd is PBS XML file (version 2)
  """

def write_key(d,key,s):
    if key in d:
        d[key] = d[key]+s+'\n'
    else:
        d[key] = s+'\n'

def find_lost_pdfs():
    with open('/var/lib/easygp/drug_pis/pi_complete.txt') as f:
        drugs= sorted(((l[:12], l[13:].strip()) for l in f), key=lambda x: len(x[1]), reverse=True)
        d = {}
        matched = set()
        for pdf, brand in drugs:
            if len(brand) < 2: continue
            r = query("select brand from drugs.brand where product_information_filename ilike %s",(pdf,))
            if len(r) == 0:
                r = query("select * from drugs.brand where product_information_filename_user ilike %s",(pdf,))
                if len(r) > 0:
                    write_key(d,brand,"-- %s %s found in user filename, setting standard also" % (pdf,brand))
                    for i in r:
                        cmd("update drugs.brand set product_information_filename=$$%s$$ where pk=%s",(pdf,i['pk']))
                else:
                    r = query("select distinct brand from drugs.brand where brand ilike %s",(brand+'%',))
                    if len(r) == 0:
                        #r = query("select * from drugs.brand where $$%s$$ ilike replace(brand,'%'
                        write_key(d,brand,"-- %s %s no match found" % (pdf,brand))
                    else:
                        write_key(d,brand,"-- possible match on %s %s" % (pdf,brand))
                        for i in r:
                            if i['brand'] in matched:
                                write_key(d,brand,"-- %s matched this session" % i['brand'])
                            else:
                                matched.add(i['brand'])
                                write_key(d,brand,"update drugs.brand set product_information_filename=$$%s$$ where brand = $$%s$$;" % (pdf,i['brand']))
            #else:
            #    write_key(d,brand,"-- %s %s already matched to %s" % (pdf,brand,r[0]['brand']))
        for k in sorted(d.keys()):
            print d[k]

def main():
    if len(sys.argv) > 1:
        if sys.argv[1] == 'scts':
            scan_all_scts()
            return
        elif sys.argv[1] == "--help":
            print_help()
            return
        elif sys.argv[1] == 'set_orig_names':
            set_original_pbs_names(get_xml_etree(sys.argv[2]))
            return
        elif sys.argv[1] == 'lost_pdfs':
            find_lost_pdfs()
            return
        else:
            f = sys.argv[1]
    else:
        print_help()
        return
    t = get_xml_etree(f)
    print "using ", os.path.abspath(f)
    print "derived release date ",release_date
    fname = 'drugs-'+release_date+'.sql'
    with open(fname,'w') as ofile:
        import_products(t) # produce list of new products and talk to user about them
        print >>ofile,"""-- EasyGP drugs update %s
    \\set ON_ERROR_STOP 1
    \\o /dev/null
    \\set QUIET 1
    """ % release_date
        import_mnfr(t,ofile) # company information need to do before brands to prevent missing links
        verify_brands(t) # brands, may spit out errors
        import_atc(t,ofile)
        print_products(ofile) # idempotent sql commands for full dump of products
        print_brands(ofile) # and brands
        print >>ofile, "truncate drugs.pbs, drugs.restriction;"
        import_pbs(t,ofile) # pbs and restrictions, produce dump-and-reload SQL 
        import_restricts(t,ofile)
        new_date = "update drugs.version set release_date='%s'" % release_date
        print >>ofile,new_date+';'
        cmd(new_date)
    os.system("lzma -f %s" % fname)

if __name__ == '__main__':
    main()
