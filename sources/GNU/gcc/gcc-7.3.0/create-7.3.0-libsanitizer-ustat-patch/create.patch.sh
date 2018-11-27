#!/bin/bash

VERSION=7.3.0

tar --files-from=file.list -xJvf ../gcc-$VERSION.tar.xz
mv gcc-$VERSION gcc-$VERSION-orig

cp -rf ./gcc-$VERSION-new ./gcc-$VERSION

diff -b --unified -Nr  gcc-$VERSION-orig  gcc-$VERSION > gcc-$VERSION-libsanitizer-ustat.patch

mv gcc-$VERSION-libsanitizer-ustat.patch ../../patches

rm -rf ./gcc-$VERSION
rm -rf ./gcc-$VERSION-orig
