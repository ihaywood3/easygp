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

# This code does not refer to any restricted information, it communicates
# with a closed-source Java module using a JSON API spec developed
# by myself (Ian Haywood), prior to reading NDA-restricted Medicare
# documentation.

"""A class for making Medicare Online billing submissions
"""

import json, subprocess, os.join

class MedicareOnline:
    def __init__(self, java_path, passphrase, sender, location_id):
        self.passphrase = passphrase
        self.java_path = java_path
        self.sender = sender
        self.location_id = location_id
        
    def  run(self, inpu):
        inpu["passphrase"] = self.passphrase
        inpu["location_id"] = self.location_id
        inpu["sender"] = self.sender
        p = subprocess.Popen(["/usr/bin/java","-classpath","mo/*:mo","-Djava.library.path=mo","medicare.MedicareAPI"],cwd=self.java_path,stdin=subprocess.PIPE,stderr=subprocess.PIPE,stdout=subprocess.PIPE,close_fds=True)
        sout, serr = p.communicate(json.dumps(inpu))
        if not serr is None and len(serr) > 2:
            return {"status_code":9999,"status_text":serr}
        try:
            ret = json.loads(sout)
        except:
            return {"status_code":9999,"status_text":sout}
        if ret["status_code"] <> 0:
            codes = {r[0]:r[1] for r in csv.reader(open(os.path.join(self.java_path,'mo','codes.txt'), 'r'), delimiter='\t')}
            ret["status_text"] = codes.get(ret["status_code"],"Unknown code %d" % ret["status_code"])
        else:
            ret["status_text"] = "success"
        return ret
