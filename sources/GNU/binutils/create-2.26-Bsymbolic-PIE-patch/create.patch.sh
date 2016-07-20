#!/bin/sh

VERSION=2.26

tar --files-from=file.list -xjvf ../binutils-$VERSION.tar.bz2
mv binutils-$VERSION binutils-$VERSION-orig

cp -rf ./binutils-$VERSION-new ./binutils-$VERSION

diff -b --unified -Nr  binutils-$VERSION-orig  binutils-$VERSION > binutils-$VERSION-Bsymbolic-PIE.patch

mv binutils-$VERSION-Bsymbolic-PIE.patch ../patches

rm -rf ./binutils-$VERSION
rm -rf ./binutils-$VERSION-orig
