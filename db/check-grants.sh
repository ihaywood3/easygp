#!/bin/sh

psql -t -c "select table_schema || '.' || table_name from information_schema.tables  
  where table_schema <> 'pg_catalog' and table_schema <> 'information_schema';" \
  easygp | grep -o "[a-z_]*\.[a-z_0-9]*" | sort -u > /tmp/tables_in_db.txt

grep -o "[a-z_]*\.[a-z_0-9]*" easygp.grants.sql | grep -v _seq | sort -u > /tmp/tables_in_grants.txt

gawk 'FILENAME=="/tmp/tables_in_db.txt" {
                 tables[$0] = 1;
         }
       FILENAME=="/tmp/tables_in_grants.txt" {
                 delete tables[$0];
        }
       END {
           for (i in tables)
               print i;
           }' /tmp/tables_in_db.txt /tmp/tables_in_grants.txt | sort -u | (
                  while read line ; do
                      echo GRANT USAGE ON SEQUENCE $(line)_pk_seq TO staff\;
                  done 
              )