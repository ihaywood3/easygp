#!/bin/bash

if [ -n $1 ] ; then CONN=$1 ; else CONN=easygp ; fi

MAJOR=`psql -tA -c "select lu_major from db.lu_version" $CONN`
MINOR=`psql -tA -c "select lu_minor from db.lu_version" $CONN`

cd updates
i=$MINOR
let i++

while [ -e $MAJOR.$i*.sql ] ; do
   psql -f $MAJOR.$i*.sql $CONN
   let i++
done
