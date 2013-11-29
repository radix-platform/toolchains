#!/bin/sh

VERSION=0.9.33.2

tar --files-from=file.list -xjvf ../uClibc-$VERSION.tar.bz2
mv uClibc-$VERSION uClibc-$VERSION-orig

cp -rf ./uClibc-$VERSION-new ./uClibc-$VERSION

diff -b --unified -Nr  uClibc-$VERSION-orig  uClibc-$VERSION > uClibc-$VERSION-out-of-tree.patch

mv uClibc-$VERSION-out-of-tree.patch ../patches

rm -rf ./uClibc-$VERSION
rm -rf ./uClibc-$VERSION-orig
