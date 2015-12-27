#!/bin/bash
DBNAME=${1:-easygp}

MAJOR=`psql -tA -c "select lu_major from db.lu_version" $DBNAME -U easygp`
MINOR=`psql -tA -c "select lu_minor from db.lu_version" $DNAME -U easygp`

cd updates
i=$MINOR
let i++

while [ -e $MAJOR.$i*.sql ] ; do
   echo Running update $MAJOR.$i
   PGOPTIONS='--client-min-messages=warning' psql -f $MAJOR.$i*.sql $DBNAME -U easygp > /dev/null
   let i++
done
