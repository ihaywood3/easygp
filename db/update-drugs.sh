#!/bin/bash
cd /var/lib/easygp/drug_pis

rsync -tqz haywood.id.au::drugs/* .
if [ \( \! -f drugs-stamp \) -o drugs.sql -nt drugs-stamp ] ; then
    # don't sweat the DB unless the drugs has actually changed
    touch drugs-stamp
    psql -f drugs.sql -U easygp easygp
fi
