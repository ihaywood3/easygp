#!/bin/bash
cd /tmp
for i in $(seq -w 1 $1) ; do
  scanimage --resolution 100 --mode Gray > page-$i.pgm
done
convert page-*.pgm /var/lib/easygp/incoming/scan-`date '+%Y%m%d%H%M%S'`.pdf
rm page-*.pgm
