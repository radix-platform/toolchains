#!/bin/bash

VERSION=2.31.1

tar --files-from=file.list -xJvf ../binutils-$VERSION.tar.xz
mv binutils-$VERSION binutils-$VERSION-orig

cp -rf ./binutils-$VERSION-new ./binutils-$VERSION

diff -b --unified -Nr  binutils-$VERSION-orig  binutils-$VERSION > binutils-$VERSION-sec-merge-omit.patch

mv binutils-$VERSION-sec-merge-omit.patch ../patches

rm -rf ./binutils-$VERSION
rm -rf ./binutils-$VERSION-orig
