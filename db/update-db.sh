#!/bin/bash

MAJOR=`psql -tA -c "select lu_major from db.lu_version" easygp -U easygp`
MINOR=`psql -tA -c "select lu_minor from db.lu_version" easygp -U easygp`

cd updates
i=$MINOR
let i++

while [ -e $MAJOR.$i*.sql ] ; do
   echo Running update $MAJOR.$i
   psql -f $MAJOR.$i*.sql easygp -U easygp > /dev/null
   let i++
done
