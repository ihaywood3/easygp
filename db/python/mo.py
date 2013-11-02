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

import soap
import xml.etree.ElementTree

class MedicareOnline:
    def __init__(self, mo_path, mo_passphrase):
        self.java_path = mo_path
        self.mo_passphrase
