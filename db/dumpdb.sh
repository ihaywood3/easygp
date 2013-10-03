#!/bin/sh
# install SQL generated by:
pg_dump -s -T 'coding.icd10' -T 'coding.icd10_*' -T 'coding.icpc2_*' -T 'coding.vwicpc*' -U easygp easygp > easygp.schema.sql
pg_dump -t "*.lu_*" -t "drugs.*" -a -U easygp easygp > easygp.data.sql
