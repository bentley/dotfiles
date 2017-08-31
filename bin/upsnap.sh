#!/bin/sh

cd $(mktemp -d)
if [ -f /etc/installurl ]; then
	< /etc/installurl read mirror
else
	mirror=https://ftp3.usa.openbsd.org/pub/OpenBSD
fi
ftp "$mirror"/snapshots/$(uname -m)/{bsd.rd,SHA256{.sig,}} || exit 1
key1=$(ls /etc/signify/openbsd-??-base.pub | tail -2 | head -1)
key2=$(ls /etc/signify/openbsd-??-base.pub | tail -2 | tail -1)
(signify -C -p $key1 -x SHA256.sig bsd.rd  ||
 signify -C -p $key2 -x SHA256.sig bsd.rd) || exit 1
mv bsd.rd /
