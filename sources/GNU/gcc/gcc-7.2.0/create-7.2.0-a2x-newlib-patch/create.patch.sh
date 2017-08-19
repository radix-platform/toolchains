#!/bin/sh

VERSION=7.2.0

tar --files-from=file.list -xJvf ../gcc-$VERSION.tar.xz
mv gcc-$VERSION gcc-$VERSION-orig

cp -rf ./gcc-$VERSION-new ./gcc-$VERSION

diff -b --unified -Nr  gcc-$VERSION-orig  gcc-$VERSION > gcc-$VERSION-a2x-newlib.patch

mv gcc-$VERSION-a2x-newlib.patch ../../patches

rm -rf ./gcc-$VERSION
rm -rf ./gcc-$VERSION-orig