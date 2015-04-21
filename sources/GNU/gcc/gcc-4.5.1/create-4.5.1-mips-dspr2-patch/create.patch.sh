#!/bin/sh

VERSION=4.5.1

tar --files-from=file.list -xjvf ../gcc-$VERSION.tar.bz2
mv gcc-$VERSION gcc-$VERSION-orig

cp -rf ./gcc-$VERSION-new ./gcc-$VERSION

diff -b --unified -Nr  gcc-$VERSION-orig  gcc-$VERSION > gcc-$VERSION-mips-dspr2.patch

mv gcc-$VERSION-mips-dspr2.patch ../../patches

rm -rf ./gcc-$VERSION
rm -rf ./gcc-$VERSION-orig
