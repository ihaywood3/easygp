#!/usr/bin/python
# -*- coding: latin-1 -*-

# Copyright (C) 2008-2012 Dr. Richard Terry, Dr. Ian Haywood

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This code is not Medicare specific and does not refer to restricted information, therefore
# it can be released open-source. However it is not very useful without the Medicare specific drivers.

"""This code contains general support routines for the Python daemon"""

import sys, os, getpass, pwd, glob, imp, os.path, traceback, shlex, time, logging, logging.handlers, re, socket
import pdb
import psycopg2
import soap
import events
from dbwrapper import DBWrapper

class Daemon:

    def read_config(self):
        """Find and read configuration file"""
        self.config = {}
        self.config['logfile'] = '/var/log/easygp.log'
        self.config['pidfile'] = '/var/run/easygp-python.pid'
        self.config['host'] = 'localhost'
        self.config['port'] = '5432'
        self.config['database'] = 'easygp'
        self.config['drivers'] = '/usr/lib/easygp/drivers'
        self.config['medisecure'] = '127.0.0.1'
        self.config['syslog'] = 'false'
        self.config['tasks_user'] = 'nobody'
        self.config['keydir'] = '/usr/lib/easygp/keys'
        configfiles = ['/etc/easygp.conf','/usr/local/etc/easygp.conf',os.path.expanduser('~/easygp.conf')]
        if self.cmd_config: configfiles.append(self.cmd_config)
        for fn in configfiles:
            if os.path.isfile(fn):
                with open(fn,'r') as f:
                    lexer = shlex.shlex(f)
                    lexer.whitespace_split = True
                    tok = lexer.get_token()
                    while tok != lexer.eof:
                        config_name = tok
                        tok = lexer.get_token()
                        if tok == ':' or tok == '=':
                            tok = lexer.get_token()
                        if tok != lexer.eof:
                            self.config[config_name] = tok
                            tok = lexer.get_token()
      

    def read_cmd(self):
        i = 1
        self.cmd_config = None
        self.debug_mode = False
        self.test_mode = False
        self.overnight_mode = False
        while i < len(sys.argv):
            s = sys.argv[i]
            if s == '--config' or s == '-c':
                i += 1
                if i < len(sys.argv): self.cmd_config = sys.argv[i]
            if s == '--help':
                print """EasyGP daemon for communication with external providers
Options
   -c, --config  [file]:  specify non-standard location for config file. Standard is /etc/easygp.conf and $HOME/easygp.conf
   -h,, --help:  this help
   -o,--overnight: instead of becoming a deamon run overnight tasks such as rechecking status
                   on old IHIs in the database. Intended to be run from cron
   -d,--debug:  run in debug mode: no daemon, log to stdout.
   -t,--test: run unit tests. only if you know what you are doing
"""
                sys.exit(0)
            if s == '-d' or s =='--debug':
                self.debug_mode = True
            if s == '-o' or s == '--overnight':
                self.overnight_mode = True
            if s == '-t' or s == '--test':
                self.test_mode = True
                self.debug_mode = True
            i += 1

     
    def setup_log(self):
        if True:  # FIXME: if self.debug_mode:
            logging.basicConfig(stream=sys.stderr,level=logging.DEBUG)
        else:
            if self.config['syslog'] != 'false':
                m = re.match('/.*',self.config['syslog'])
                if m:
                    hldr = self.config['syslog']
                else:
                    m = re.match('(.*):([0-9]+)',self.config['syslog'])
                    if m:
                        hldr = (m.group(1),m.group(2))
                    else:
                        hldr = (self.config['syslog'],514)
                hdlr = logging.handlers.SysLogHandler(hldr)
                logging.getLogger().addHandler(hdlr)
                logging.basicConfig(level=logging.WARNING)
            else:    
                logging.basicConfig(filename=self.config['logfile'],level=logging.WARNING)

    def setup(self):
        with open(self.config["pidfile"],'w') as f:
            f.write(str(os.getpid()))
        if os.getuid() == 0:
            p = pwd.getpwname(self.config["user"])
            self.euid = p.pw_pid
            os.seteuid(self.euid)
            if not self.config.has_key("db_user"): self.config["db_user"] = "easygp"
        else:
            self.euid = None
            if not self.config.has_key("db_user"):
                if not self.config.has_key("user"): 
                    self.config["db_user"] = getpass.getuser()
                else:
                    self.config["db_user"] = self.config["user"]


    def shutdown(self):
        if self.euid is not None:
            os.seteuid(0)  # go back to root to delete PID file.
        os.unlink(self.config["pidfile"])

    def setup_drivers(self):
        """import modules and set up functions to respond to database events"""
        self.evts = events.Event(self.db,self)
        # HI Service
        sys.path.append(self.config["drivers"])
        try:
            import hi_service
            hi_soap = soap.SOAPCrypto()
            hi_soap.set_configs(os.path.join(self.config["keydir"],"hi_service.key"),os.path.join(self.config["keydir"],"hi_service.pem"),self.euid,soap_host=hi_service.TEST_SOAP_HOST,soap_path=hi_service.SOAP_PATH) # FIXME: use real server instead of test server
            hi = hi_service.HIService(hi_soap)
            self.evts.hi_service = hi
            self.db.listen("newihi",self.evts.new_ihi)
            self.db.listen("death",self.evts.patient_death)            
        except ImportError:
            logging.warn("hi service driver not found")
        # Medicare Online
        self.mo = None
        if os.path.exists(os.path.join(self.config["drivers"],'lib','au.gov.hic.psi.crypto.jar')):
            import mo # python component is FOSS so this will always work
            if not self.config.has_key("mo_passphrase"):
                logging.error("mo_passphrase must be set in config file")
            elif not self.config.has_key("mo_sender"):
                logging.error("mo_sender must be set in config file")
            elif not self.config.has_key("mo_location_id"):
                logging.error("mo_location_id must be set in config file")       
            else:
                mox = mo.MedicareOnline(self.config["drivers"],self.config["mo_passphrase"],self.config["mo_sender"],self.config["mo_location_id"])
                self.mo = mox
                self.mo.db = self.db
                # self.db.listen("invoice",self.evts.invoice)
        else:
            logging.warn('Medicare Online JAR not found in %s so MO module not loaded' % self.config['drivers'])
        # Personally Controlled Electronic Record
        # pcehr.py will always be available as FOSS code, look for NASH keys instead
        pcehr_key = os.path.join(self.config["keydir"],'pcehr.key')
        if os.path.exists(pcehr_key):
            import pcehr
            pcehr_soap = pcehr.PCEHR_SOAP()    
            pcehr_soap.set_configs(os.path.join(self.config["keydir"],"pcehr.key"),os.path.join(self.config["keydir"],"pcehr.pem"),self.euid)
            self.evts.pcehr_soap = pcehr_soap
            # NOTE: not decided how this will work yet
            # self.db.listen("pcehr_download",self.evts.pcehr_download)
            # self.db.listen("pcehr_upload",self.evts.pcehr_upload)
        else:
            logging.warn("PCEHR module not loaded as no key installed at %s" % pcehr_key)
        # MediSecure e-scripts
        try:
            import medisecure
            server_ip = self.config["medisecure"]
            server_ip = server_ip.split(':')
            if len(server_ip) == 2:
                server_ip = (server_ip[0],server_ip[1])
            else:
                server_ip = (server_ip[0],5678)
            if "medisecure_location_id" in self.config:
                ms = medisecure.Medisecure(server_ip,self.config["medisecure_location_id"])
                self.evts.medisecure = ms
                self.db.listen("script",self.evts.script_printed)
            else:
                logging.error("MediSecure not loaded as no config value \"medisecure_location_id\"")
        except ImportError:
            logging.warn("MediSecure module not available in %s" % self.config["drivers"])    
        

    def daemonise(self):

        if os.fork () != 0: sys.exit(0)  # parent dies
        os.close(0)  # close standard file descriptors
        os.close(1)
        os.close(2)
        os.setsid() # become our own session and lose the tty
        os.chdir("/")
        os.umask(0)

    def main(self):
        self.read_cmd()
        self.read_config()
        self.setup_log()
        try:
            if not self.overnight_mode and not self.debug_mode: self.daemonise()
            try:
                self.setup()
                self.db = DBWrapper(self.config)
                self.setup_drivers()
                if self.overnight_mode: 
                    self.evts.overnight()
                    pdb.set_trace()
                    if not self.mo is None: 
                        self.mo.prepare_bb_reports()
                        for i in self.db.get_claims_awaiting_transmission(): self.transmit_claim(i)
                        for i in self.db.get_claims_awaiting_processing_report(): self.mo.get_bb_processing_report(i)
                        for i in self.db.get_claims_awaiting_payment_report(): self.mo.get_bb_payment_report(i)
                else:
                    if self.test_mode:
                        #self.db.synth_event("script",12)
                        #self.mo.send_bb_report(fk_staff_only=4)
                        #self.mo.prepare_bb_reports(fk_staff_only=4)
                        #self.mo.transmit_claims()
                        #self.mo.get_bb_processing_report(self.db.get_claim('B0006@'))
                        self.mo.upload_private_invoice(1460) # Diana Kahn's 306
                    else:
                        self.db.wait_events()
            except: logging.exception("exception in child")
            finally: self.shutdown()
        except SystemExit: pass # parent dying
        except: logging.exception("top-level exception")

if __name__=='__main__':
    d = Daemon()
    d.main()
