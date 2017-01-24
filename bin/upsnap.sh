#!/bin/sh

cd `mktemp -d`
ftp https://ftp3.usa.openbsd.org/pub/OpenBSD/snapshots/`uname -m`/{bsd.rd,SHA256{.sig,}}
key1=`ls /etc/signify/openbsd-??-base.pub | tail -2 | head -1`
key2=`ls /etc/signify/openbsd-??-base.pub | tail -2 | tail -1`
(signify -C -p $key1 -x SHA256.sig bsd.rd || signify -C -p $key2 -x SHA256.sig bsd.rd) || exit 1
mv bsd.rd /
