"""
This script imports data from the XML data dump that can be downloaded from 
http://www.drugbank.ca/system/downloads/current/drugbank.xml.zip
Please note that this is only permissible for non-commercial use. For commercial use
you must get the explicit permission of the owners.

At present it is still a quick hack with hardcoded database login details and hard-
coded XML file location (presumes this file is in the directory this script is run from)

UNTESTED: if the drugbank XML file does not exist, the script will attempt to download 
and unzip it for you in your current directory 

This script is provided under the terms of the GPL license version 3.0 by Dr H. Herb
"""
import xml.etree.ElementTree as ET
import psycopg2 as DBAPI
import urllib
import zipfile
import os.path

DOWNLOAD_URL= "http://www.drugbank.ca/system/downloads/current/drugbank.xml.zip"
DOWNLOAD_ZIPFILE = "drugbank.xml.zip"
DRUGBANK_FILENAME = "drugbank.xml"

NS = "{http://drugbank.ca}"	 #the namespace of XML elements in the import file


def download_progress(blocks_downloaded, blocksize, filesize):
	"""
	callback function showing download progress
	"""
	print blocks_downloaded * blocksize / 1024, "Kb downloaded of", filesize/1024



def getfile(url=DOWNLOAD_URL, fname=DOWNLOAD_ZIPFILE, download_progress_reporter=download_progress):
	"""
	attempts to download the drugbank data file and unzip it i your
	current directory
	"""
	urllib.urlretrieve(DOWNLOAD_URL, DOWNLOAD_ZIPFILE, download_progress_reporter)
	zf = zipfile.ZipFile(DOWNLOAD_ZIPFILE)
	files = zf.namelist()
	if DRUGBANK_FILENAME not in files:
		print "Sorry, the downloaded file does not seem to contain", DRUGBANK_FILENAME
		print "It only contains", files
		print "You need to manually give me", DRUGBANK_FILENAME
		return None
	else:
		zf.extractall()
		return DRUGBANK_FILENAME

	
def pgconnection(host='127.0.0.1', dbname='drugbank', user='easygp', password='easygp.'):
	""" 
	Establishes a connection with the database our data will be imported into.
	quick hack with hardcoded access credentials in order to test the import.
	Needs sophistication and command line argument parsing in the future
	"""
	con = DBAPI.connect(host=host, dbname=dbname, user=user, password=password)
	return con	
	
	
class drugbankentry:
	"""
	quick hack dummy for import 
	""" 
	pass
		

def get_drugbank_pk(con, drugbank_id, drugname):
	"""
	find the internal primary key for a given drugbank id string and return it.
	Return None if none was found 
	"""
	pk = None
	cur = con.cursor()
	cur.execute("select pk from drugbank.drug where drugbank_id like %s", (drugbank_id,))
	res = cur.fetchone()
	if res is not None:
		pk = res[0]
	else:
		try:
			cur.execute("""INSERT INTO drugbank.drug(drugbank_id, name) values (%s, %s)""", (drugbank_id, drugname))
			#con.commit()
		except: 
			print "THIS SHOULD NEVER HAPPEN - MISING DRUG", drugbank_id, name
		cur.execute("select pk from drugbank.drug where drugbank_id ilike %s", (drugbank_id,))
		res = cur.fetchone()
		if res:
			pk = res[0]
	cur.close()
	return pk
	


def add_drug(con, drug, drugname):
	""" 
	adds only basic drug data along with the name from the drugbank data.
		The name is not necessarily the INN, can be the genetic name that is usually used
		in Canada. We will fix that to INN later
	"""
	global NS
	d = drugbankentry()
	d.drugbank_id = drug.find(NS+'drugbank-id').text
	d.name = drug.find(NS+'name').text
	d.description = drug.find(NS+'description').text
	d.indication = drug.find(NS+'indication').text
	d.pharmacology = drug.find(NS+'pharmacology').text
	d.mechanism_of_action = drug.find(NS+'mechanism-of-action').text
	d.toxicity = drug.find(NS+'toxicity').text
	d.biotransformation = drug.find(NS+'biotransformation').text
	d.absorption = drug.find(NS+'absorption').text
	d.half_life = drug.find(NS+'half-life').text
	d.route_of_elimination = drug.find(NS+'route-of-elimination').text
	d.volume_of_distribution = drug.find(NS+'volume-of-distribution').text
	d.clearance = drug.find(NS+'clearance').text
	# d. = drug.find(NS+'').text
	sqlstr = """INSERT INTO drugbank.drug(drugbank_id, name, description, pharmacology, mechanism_of_action, toxicity,
				biotransformation, absorption, half_life, route_of_elimination, volume_of_distribution,
				clearance) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
	cur = con.cursor()
	cur.execute(sqlstr, (d.drugbank_id, 
		d.name, 
		d.description, 
		d.pharmacology, 
		d.mechanism_of_action, 
		d.toxicity,
		d.biotransformation, 
		d.absorption, 
		d.half_life, 
		d.route_of_elimination,
		d.volume_of_distribution, 
		d.clearance) )
	con.commit()
	cur.close()
	
def add_synonyms(con, drug, drugname):
	"""
	adds synonyms for a given drug name, including the name from the 'drug' table too.
	It is recommended to always search via synonyms for the drug primary key
	"""
	global NS
	drugbank_id = drug.find(NS+'drugbank-id').text
	pk = get_drugbank_pk(con, drugbank_id, drugname)
	synonyms_root = drug.find(NS+'synonyms')
	synonyms = synonyms_root.findall(NS+'synonym')
	cur=con.cursor()
	#add the primary name in the database to the list of it's synonyms for more effective searching
	cur.execute("insert into drugbank.synonyms(fk_drug, name) values(%s, %s)", (pk, drugname))
	for synonym in synonyms:
		cur.execute("insert into drugbank.synonyms(fk_drug, name) values(%s, %s)", (pk, synonym.text))
		#print synonym.text
	con.commit()
	cur.close()
	
def add_interactions(con,drug, drugname):
	"""
	adds interactions. The table structure and how we handle this is currently still primitive
	and will change, but it works for now
	"""
	global NS
	drugbank_id = drug.find(NS+'drugbank-id').text
	fk_drug = get_drugbank_pk(con, drugbank_id, drugname)
	interactions_root = drug.find(NS+'drug-interactions')
	if interactions_root is None:
			return	
	interactions = interactions_root.findall(NS+'drug-interaction')
	cur=con.cursor()
	for interaction in interactions:
		interacted_name = interaction.find(NS+'name').text
		interacted_drugbank_id = interaction.find(NS+'drug').text
		fk_interacts_with = get_drugbank_pk(con, interacted_drugbank_id, interacted_name)
		description = interaction.find(NS+'description').text
		#print "interacts with", interaction.find(NS+'name').text
		#print "interaction : [%s]" % description
		cur.execute("""insert into drugbank.drug_interactions(fk_drug, fk_interacts_with, description) values (%s, %s, %s);""",
			(fk_drug, fk_interacts_with, description))
	con.commit()	
	cur.close()
		
def add_brands(con, drug, drugname):
	global NS
	drugbank_id = drug.find(NS+'drugbank-id').text
	pk = get_drugbank_pk(con, drugbank_id, drugname)
	brands_root = drug.find(NS+'brands')
	brands = brands_root.findall(NS+'brand')
	cur=con.cursor()
	for brand in brands:
		cur.execute("insert into drugbank.brands(fk_drug, name) values(%s, %s)", (pk, brand.text))
	con.commit()
	cur.close()
	
	
def add_food_interactions(con, drug, drugname):
	global NS
	drugbank_id = drug.find(NS+'drugbank-id').text
	pk = get_drugbank_pk(con, drugbank_id, drugname)
	food_interactions_root = drug.find(NS+'food-interactions')
	food_interactions = food_interactions_root.findall(NS+'food-interaction')
	cur=con.cursor()
	for food_interaction in food_interactions:
		cur.execute("insert into drugbank.food_interactions(fk_drug, food_interaction) values(%s, %s)", (pk, food_interaction.text))
	con.commit()
	cur.close()
	
def add_atc_codes(con, drug, drugname):
	pass
	
def add_categories(con, drug, drugname):
	pass
	
def add_dosage(con, drug, drugname):
	pass
	
def add_external_links(con, drug, drugname):
	pass
	
def add_general_references(con, drug, drugname):
	pass
	
def add_patents(con, drug, drugname):
	pass
	
def add_salts(con, drug, drugname):
	pass
	
def for_all_drugs(con, drugs, myfunc, message='', progressfeedback=True):
	"""
	Process the specified callback functions for all drug data entries found
	in the drugbank XML data dump
	"""
	counter = 0
	if message:
		print message
	for drug in drugs:
		drugname = drug.find(NS+'name').text
		if progressfeedback:
			print message, "processing drug", drugname 
		myfunc(con, drug, drugname)
		counter += 1
		print counter
	
	
if __name__ == "__main__":
	counter = 0
	#read xml file
	filename=DRUGBANK_FILENAME
	if not os.path.exists(DRUGBANK_FILENAME):
		filename = getfile('DRUGBANK_FILENAME')
	tree = ET.parse(filename)
	root = tree.getroot()
	drugs = root.findall(NS+'drug')
	con = pgconnection()
	
	for_all_drugs(con, drugs, add_drug, "Adding basic drug data")
	for_all_drugs(con, drugs, add_synonyms, "Adding drug name synonyms")
	for_all_drugs(con, drugs, add_interactions, "Adding interaction data")
	for_all_drugs(con, drugs, add_brands, "Adding brand names")
	for_all_drugs(con, drugs, add_food_interactions, "Adding food interactions")
		
	con.close()