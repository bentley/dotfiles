#!/bin/sh

cd $(mktemp -d || exit 1)
if [ -f /etc/installurl ]; then
	< /etc/installurl read mirror
else
	mirror=https://ftp3.usa.openbsd.org/pub/OpenBSD
fi
ftp "$mirror"/snapshots/$(uname -m)/{bsd.rd,SHA256.sig} || exit 1
V=$(grep man SHA256* | sed -e 's/SHA256//' -e 's/\.tgz.*//' -e 's/[^0-9]//g')
key=$(ls /etc/signify/openbsd-$V-base.pub || exit 1)
signify -C -p $key -x SHA256.sig bsd.rd || exit 1
mv bsd.rd /
