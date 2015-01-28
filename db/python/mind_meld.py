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
# it can be released open-source. 

"""A proof-of-concept synchroniser between EasyGP databases"""

import dbwrapper
import pdb
db = dbwrapper.DBWrapper(None,True)
others= {'fk_consult':'clin_consult.consult','fk_patient':'clerical.data_patients','fk_employee':'contacts.data_employees','fk_person':'contacts.data_persons','fk_staff':'admin.staff','fk_branch':'contacts.data_branches','fk_address':'contacts.data_addresses','fk_progressnote':'clin_consult.progressnotes','fk_pasthistory':'clin_history.past_history','fk_clinic':'admin.clinics','fk_occupation':'common.lu_occupations','fk_generic_product':'drugs.product'}

def convert_table_uuid(tbl):
    constraints = db.each_foreign_constraint()
    if db.column_type(tbl,"pk") == "uuid": return  # no need to do it
    just_tbl = tbl.split(".")[1]   # drop schema
    for c in constraints:
        if c["table2"] == tbl and c['col2'] == 'pk':
            print "ALTER TABLE %s DROP CONSTRAINT %s;" % (c["table1"],c['name'])
            print "ALTER TABLE %(table1)s ALTER COLUMN %(col1)s SET DATA TYPE uuid USING uuid_generate_v5(uuid_ns_url(),'http://easygp.net.au/uuid_conversion/%(table2)s/' || %(col1)s);" % c
    print "ALTER TABLE %s DROP CONSTRAINT %s_pkey;" % (tbl,just_tbl)
    print "ALTER TABLE %s ALTER COLUMN pk SET DATA TYPE uuid USING uuid_generate_v5(uuid_ns_url(),'http://easygp.net.au/uuid_conversion/%s/' || pk);" % (tbl,tbl)
    print "ALTER TABLE %s ADD PRIMARY KEY (pk);" % tbl
    for c in constraints:
        if c["table2"] == tbl and c['col2'] == 'pk':
            print "ALTER TABLE %(table1)s ADD FOREIGN KEY (%(col1)s) REFERENCES %(table2)s (pk);" % c


def add_constraints():
    constraints = {}
    for c in db.each_foreign_constraint():
        if not c["table1"] in constraints: constraints[c["table1"]] = set()
        constraints[c["table1"]].add(c["col1"])
    for t in db.each_table():
        for c in db.each_table_cols(t):
            if c.startswith("fk_"):
                if not (t in constraints and c in constraints[t]):
                    t2 = t.split('.')
                    t2 = t2[1]
                    if c in others:
                        print 'ALTER TABLE %s add constraint "%s_%s_fkey" foreign key (%s) references %s (pk);' % (t,t2,c,c,others[c])
                    else:
                        print '--alter table %s add constraint "%s_%s_fkey" foreign key (%s) references ?? (pk);' % (t,t2,c,c)

#add_constraints()
convert_table_uuid("clerical.data_patients")
