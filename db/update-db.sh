#!/bin/bash

MAJOR=`psql -tA -c "select lu_major from db.lu_version" easygp2 -U easygp`
MINOR=`psql -tA -c "select lu_minor from db.lu_version" easygp2 -U easygp`

cd updates
i=$MINOR
let i++

while [ -e $MAJOR.$i*.sql ] ; do
   psql -f $MAJOR.$i*.sql easygp2 -U easygp
   let i++
done
