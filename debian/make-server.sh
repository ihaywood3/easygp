#!/bin/sh

# quick script to actually make the server files for debian

mkdir -p `pwd`/tmp/usr/share/dbconfig-common/data/easygp-server/install
mkdir -p `pwd`/tmp/usr/share/dbconfig-common/data/easygp-server/install-dbadmin

(
   echo ALTER ROLE easygp WITH CREATEROLE\;
   echo ALTER DATABASE easygp OWNER TO easygp\;
) > `pwd`/usr/share/dbconfig-common/data/easygp-server/install-dbadmin/pgsql

