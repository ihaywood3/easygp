#!/bin/bash

/usr/sbin/pure-ftpd -B -c 50 -C 10 -e -i -H -p 30000:30009


while true ; do
    cd /root/easygp
    rm -f *.deb *.tar.gz *.changes *.dsc
    cd trunk
    svn update
    sed --in-place -e 's:Library.*:Library=/root/easygp/trunk/easygp-base.gambas:' client/.project
    debuild -k72D8815C -I
    svn revert client/.project
    cd ~ftp/pub
    reprepro --ignore=wrongdistribution include easygp /root/easygp/*.changes
    sleep 24h
done
