#!/bin/bash

VERSION=0.9.33.2
LC_VERSION=030818

tar --files-from=file.list -xjvf ../uClibc-$VERSION.tar.bz2
tar --files-from=lc-file.list -xzvf ../uClibc-locale-$LC_VERSION.tgz
mv ./locale_mmap.h ./uClibc-$VERSION/extra/locale
mv uClibc-$VERSION uClibc-$VERSION-orig

cp -rf ./uClibc-$VERSION-new ./uClibc-$VERSION

diff -b --unified -Nr  uClibc-$VERSION-orig  uClibc-$VERSION > uClibc-$VERSION-locale.patch

mv uClibc-$VERSION-locale.patch ../patches

rm -rf ./uClibc-$VERSION
rm -rf ./uClibc-$VERSION-orig
