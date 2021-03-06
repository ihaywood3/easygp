#!/bin/sh
DBNAME=${1:-easygp}
# install SQL generated by:
pg_dump -s -T 'coding.icd10' -T 'coding.icd10_*' -T 'coding.icpc2_*' -T 'coding.vwicpc*' -U easygp $DBNAME > easygp.schema.sql
pg_dump -t "*.lu_*" -t "drugs.*" -a -U easygp $DBNAME > easygp.data.sql
