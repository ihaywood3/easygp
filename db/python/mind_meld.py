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
db = dbwrapper.DBWrapper({'database':'easygp','db_user':'easygp','host':'','port':None,'password':None},True)
others= {'fk_consult':'clin_consult.consult','fk_patient':'clerical.data_patients','fk_employee':'contacts.data_employees','fk_person':'contacts.data_persons','fk_staff':'admin.staff','fk_branch':'contacts.data_branches','fk_address':'contacts.data_addresses','fk_progressnote':'clin_consult.progressnotes','fk_pasthistory':'clin_history.past_history','fk_clinic':'admin.clinics','fk_occupation':'common.lu_occupations','fk_generic_product':'drugs.product','fk_document':'documents.documents','fk_coding_system':'coding.lu_systems'}

def convert_all_uuid():
    drop_all_views()
    for t in db.each_table(): convert_table_uuid(t)
    print "ALTER TABLE clin_consult.progressnotes ALTER COLUMN fk_row SET DATA TYPE uuid USING uuid_generate_v5(uuid_ns_url(),'http://easygp.net.au/uuid_conversion/' || linked_table || '/' || fk_row);"

def drop_all_views():
    for v in db.each_table('.*vw.*','v'):
        print "DROP VIEW %s CASCADE;" % v

def convert_table_uuid(tbl):
    constraints = db.each_foreign_constraint()
    pk_typ =  db.column_type(tbl,"pk")
    if pk_typ == "uuid": return  # no need to do it
    if pk_typ is None: return # can't do it.
    just_tbl = tbl.split(".")[1]   # drop schema
    if just_tbl=="shortcuts_user": return # don't do this table
    if just_tbl.startswith("lu_"): return # don't do lookup tables
    for table1,x in constraints.items():
        for col1,c in x.items():
            if c['table'] == tbl and table1 != 'clin_consult.shortcuts_user':
                print "ALTER TABLE %s DROP CONSTRAINT %s;" % (table1,c['constraint'])
                print "ALTER TABLE %s ALTER COLUMN %s SET DATA TYPE uuid USING uuid_generate_v5(uuid_ns_url(),'http://easygp.net.au/uuid_conversion/%s/' || %s);" % (table1,col1,tbl,col1)
    #print "ALTER TABLE %s DROP CONSTRAINT %s_pkey;" % (tbl,just_tbl)
    print "ALTER TABLE %s ALTER COLUMN pk DROP DEFAULT;" % tbl
    print "ALTER TABLE %s ALTER COLUMN pk SET DATA TYPE uuid USING uuid_generate_v5(uuid_ns_url(),'http://easygp.net.au/uuid_conversion/%s/' || pk);" % (tbl,tbl)
    print "ALTER TABLE %s ALTER COLUMN pk SET DEFAULT uuid_generate_v4();" % tbl
    #print "ALTER TABLE %s ADD PRIMARY KEY (pk);" % tbl
    for table1,x in constraints.items():
        for col1,c in x.items():
            if c['table'] == tbl and table1 != 'clin_consult.shortcuts_user':
                print "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s) REFERENCES %s (pk);" % (table1,c['constraint'],col1,tbl)


def add_constraints():
    constraints = {}
    constraints = db.each_foreign_constraint()
    for t in db.each_table():
        for c in db.each_table_cols(t):
            if c.startswith("fk_"):
                if not (t in constraints and c in constraints[t]):
                    t2 = t.split('.')
                    t2 = t2[1]
                    found = False
                    for c2 in others.keys():
                        if c.startswith(c2):
                            pk_name = 'pk'
                            if c2 == 'fk_code': pk_name = 'code'
                            print '--ALTER TABLE %s add constraint "%s_%s_fkey" foreign key (%s) references %s (%s);' % (t,t2,c,c,others[c2],pk_name)
                            found = True
                    if not found and c != 'fk_code':
                        print 'ALTER TABLE %s add constraint "%s_%s_fkey" foreign key (%s) references  (pk);' % (t,t2,c,c)



def find_notnulls():
    for t in db.each_table():
        for c in db.each_table_cols(t):
            if c.startswith('fk_') and not db.column_notnull(t,c):
                print "ALTER TABLE %s ALTER COLUMN %s SET NOT NULL;" % (t,c)

find_notnulls()
                
#add_constraints()
#convert_all_uuid()
#drop_all_views()
