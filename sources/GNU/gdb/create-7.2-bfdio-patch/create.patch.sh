#!/bin/sh

VERSION=7.2

tar --files-from=file.list -xzvf ../gdb-${VERSION}a.tar.gz
mv gdb-$VERSION gdb-$VERSION-orig

cp -rf ./gdb-$VERSION-new ./gdb-$VERSION

diff -b --unified -Nr  gdb-$VERSION-orig  gdb-$VERSION > gdb-$VERSION-bfdio.patch

mv gdb-$VERSION-bfdio.patch ../patches

rm -rf ./gdb-$VERSION
rm -rf ./gdb-$VERSION-orig
