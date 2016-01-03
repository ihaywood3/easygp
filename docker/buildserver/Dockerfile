FROM ubuntu:wily
MAINTAINER Ian Haywood <ian@haywood.id.au>
RUN apt-get -yq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq software-properties-common python-software-properties
RUN apt-add-repository -y ppa:gambas-team/gambas3 && apt-get -yq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq --no-install-recommends install supervisor apache2 openssl subversion debhelper gambas3-dev gambas3-gb-db-postgresql gambas3-gb-qt4 gambas3-gb-qt4-ext gambas3-gb-qt4-webkit gambas3-gb-pcre gambas3-gb-pdf gambas3-gb-desktop gambas3-gb-image gambas3-gb-form gambas3-gb-form-stock gambas3-gb-form-dialog gambas3-gb-settings gambas3-gb-form-mdi gambas3-gb-crypt gambas3-gb-net gambas3-gb-net-curl gambas3-gb-net-smtp po-debconf ruby gnuplot pdfjam pdftk aspell libsasl2-modules texlive-pstricks wkhtmltopdf texlive-latex-extra mutt postgresql postgresql-contrib postgresql-plpython-9.4 python-psycopg2 pure-ftpd reprepro gnupg devscripts fakeroot build-essential
RUN cd /root/ && svn co svn://svn.ozdocit.org/easygp/
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq --no-install-recommends install gambas3-gb-util-web gambas3-gb-web
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq --no-install-recommends install gambas3-gb-v4l
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq --no-install-recommends install imagemagick
# install package building helpers
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install dpkg-dev
# install dependancies
RUN DEBIAN_FRONTEND=noninteractive apt-get -y build-dep pure-ftpd
# build from source
RUN mkdir /tmp/pure-ftpd/ && \
	cd /tmp/pure-ftpd/ && \
	apt-get source pure-ftpd && \
	cd pure-ftpd-* && \
	sed -i '/^optflags=/ s/$/ --without-capabilities/g' ./debian/rules && \
	dpkg-buildpackage -b -uc
# install the new deb files
RUN dpkg -i /tmp/pure-ftpd/pure-ftpd-common*.deb
RUN apt-get -y install openbsd-inetd
RUN dpkg -i /tmp/pure-ftpd/pure-ftpd_*.deb
# Prevent pure-ftpd upgrading
RUN apt-mark hold pure-ftpd pure-ftpd-common
RUN groupadd ftpgroup
RUN useradd -g ftpgroup -d /home/ftp -s /dev/null ftp
COPY startup.sh /root
RUN mkdir -p /home/ftp/pub/conf
COPY pubkey /root
COPY seckey /root
RUN gpg --allow-secret-key-import --import /root/seckey
RUN gpg --import /root/pubkey
COPY distributions /home/ftp/pub/conf
CMD /root/startup.sh