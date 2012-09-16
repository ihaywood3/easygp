#!/bin/bash

MAJOR=`psql -tA -c "select lu_major from db.lu_version" -U easygp easygp`
MINOR=`psql -tA -c "select lu_minor from db.lu_version" -U easygp easygp`

cd updates
i=$MINOR
let i++

while [ -e $MAJOR.$i*.sql ] ; do
   psql -f $MAJOR.$i*.sql -U easygp easygp
   let i++
done
