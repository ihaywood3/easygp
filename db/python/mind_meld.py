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

"""A proof-of-concept synchroniser between easyGP databases"""

import dbwrapper
import pdb
db = dbwrapper.DBWrapper(None,True)
others= {'fk_consult':'clin_consult.consult','fk_patient':'clerical.data_patients','fk_employee':'contacts.data_employees','fk_person':'contacts.data_persons','fk_staff':'admin.staff','fk_branch':'contacts.data_branches','fk_address':'contacts.data_addresses','fk_progressnote':'clin_consult.progressnotes','fk_pasthistory':'clin_history.past_history','fk_clinic':'admin.clinics','fk_occupation':'common.lu_occupations'}

#pdb.set_trace()
constraints = db.each_foreign_constraint()
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



