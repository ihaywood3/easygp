"""
This script imports data from the TGA drug pregnancy category database
Please note that this is only permissible for non-commercial use. For commercial use
you must get the explicit permission of the owners.

At present it is still a quick hack with hardcoded database login details and hard-
coded data file location (presumes this file is in the directory this script is run from)

However, if the data file does not exist, the script will attempt to download 
and it for you into your current directory. It makes hard coded assumptions about 
download URL and file names. 

There is still basically no error handling at all - use at your own peril
If this breaks your databases, you get to keep the pieces.

This script is provided under the terms of the GPL license version 3.0 by Dr H. Herb
"""

import sys, getopt
import pg8000 as DBAPI
import urllib
import os.path
import json

# DOWNLOAD_URL= """http://www.tga.gov.au/webfiles/medicinesInPregnancyData.js"""
DOWNLOAD_URL= """http://www.tga.gov.au/sites/all/libraries/tga_resources/medicines_database/medicinesInPregnancyData.js"""
PREGDATA_FILENAME = """medicinesInPregnancyData.js"""


def download_progress(blocks_downloaded, blocksize, filesize):
	"""
	callback function showing download progress
	"""
	print blocks_downloaded * blocksize / 1024, "Kb downloaded of", filesize/1024


def getfile(url=DOWNLOAD_URL, fname=PREGDATA_FILENAME, download_progress_reporter=download_progress):
	"""
	attempts to download the pregnancy data from the TGA web site and save it to your
	current directory
	"""
	urllib.urlretrieve(url, fname, download_progress_reporter)
	
	return fname

	
def pgconnection(password, host='127.0.0.1', dbname='easygp', user='easygp'):
	""" 
	Establishes a connection with the database our data will be imported into.
	quick hack with hardcoded access credentials in order to test the import.
	Needs sophistication and command line argument parsing in the future
	"""
	con = DBAPI.connect(host=host, dbname=dbname, user=user, password=password)
	return con	

def find_drug(con, drugname):
	SQL = """select fk_drug from drugbank.synonyms where name ilike %s"""
	pk = None
	cur = con.cursor()
	cur.execute(SQL, (drugname,))
	res=cur.fetchone()
	if res is not None:  #still needs handling of multiple return values and substrings
		pk = res[0]
	return pk

def updateOrInsertDrugPregnancyData(con, fk_drug, code, safety):
	cur = con.cursor()
	cur.execute("""select * from drugbank.pregnancy_code where fk_drug=%s""", (fk_drug,))
	res=cur.fetchone()
	if res is None:  #no pregnancy data for that drug yet in database
		print ">>> inserting data for", fk_drug
		SQL = """insert into drugbank.pregnancy_code(code, safety, fk_drug) values(%s, %s, %s)"""
	else:	#data already exists, update to newest
		print ">>> UPDATE data for", fk_drug
		SQL = """UPDATE drugbank.pregnancy_code SET code = %s, safety = %s WHERE fk_drug= %s"""
	cur.execute(SQL, (code, safety, fk_drug,))
	cur.close()
	

def parsedata(con, filename=PREGDATA_FILENAME):
	"""con is an already opened postgresql connection"""
	counter = 0
	try:
		f = open(filename)
	except:
		print "Sorry, can't open file %s, aborting program" % filename
		sys.exit(1)
	l = f.readline()  #discard the "function loadSearchData() { return {" part
	l = f.readline()
	while l:
		drug, rest = l.split(':',1)
		rest, crap = rest.split(']', -1)
		rest = rest.decode('utf8', errors='ignore')
		js = json.loads(rest+']')[0]
		dr = drug[1:-1].capitalize()
		code = js['Category']
		safety = js['Safety']
		drugname = dr.encode('utf8')
		fk_drug = find_drug(con, drugname.strip())
		if fk_drug is not None:
			updateOrInsertDrugPregnancyData(con, fk_drug, code, safety)
			counter += 1
		else:
			sys.stderr.write("%s" % drugname)
		l = f.readline().strip()
		#skip last line
		if l.endswith("};}"):
			print "finished, pregnancy categories allocated for %d drugs" % counter
			l = '' 
	f.close()

	

def help(progname):
		print
		print "this script imports pregnancy drug codes/data into easygp's drug reference database"
		print "USAGE: %s -p,--password=<password>" % progname
		print "Optional parameters:"
		print "-s, --server=<postgres ip/url, eg 'localhost', '192.168.0.1'>. Default is 'localhost'"
		print "-d, --database=<name of postgres database>. Default is 'easygp'"
		print "-u, --user=<postgres user>. Default is 'easygp'"
		print
		print "Example: %s -p mypassword" % progname
		print "or       %s -s 192.168.0.1 -d drugref -u admin -p mypassword" % progname
		

if __name__ == "__main__":
	
	host='127.0.0.1'
	db='easygp'
	user='easygp'
	password=None
	
	try:
			params = sys.argv[1:]
	except:
		help(sys.argv[0])
		sys.exit(1)

	
	options, reminder = getopt.getopt(params, 'h:s:d:u:p:', ['help', 'server=', 'database=', 'user=', 'password='])

	for opt,arg in options:
		if opt in ('-h', '--help'):
			help(sys.argv[0])
			sys.exit(1)
		elif opt in ('-s', '--server'):
			host=arg
		elif opt in ('-d', '--database'):
			db=arg
		elif opt in ('-u', '--user'):
			user=arg
		elif opt in ('-p', '--password'):
			password=arg
			
	if password is None:
		print "YOU HAVE TO SPECIFY THE POSTGRES DATABASE USER PASSWORD"
		help(sys.argv[0])
		sys.exit(1)
			
	filename=PREGDATA_FILENAME
	if not os.path.exists(filename):
		filename = getfile()
	if filename is None:
		print "File %s not found, aborting program" % PREGDATA_FILENAME
		sys.exit(1)

	print """Trying to connect to database %s on server %s, for user %s with password %s""" % (db, host, user, password)
	con= pgconnection(host=host, dbname=db, user=user, password=password)
	parsedata(con, filename)
	con.commit()
	con.close()
