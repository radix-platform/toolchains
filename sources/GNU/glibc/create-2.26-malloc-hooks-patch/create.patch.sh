#!/bin/sh

VERSION=2.26

tar --files-from=file.list -xJvf ../glibc-$VERSION.tar.xz
mv glibc-$VERSION glibc-$VERSION-orig

cp -rf ./glibc-$VERSION-new ./glibc-$VERSION

diff -b --unified -Nr  glibc-$VERSION-orig  glibc-$VERSION > glibc-$VERSION-malloc-hooks.patch

mv glibc-$VERSION-malloc-hooks.patch ../patches

rm -rf ./glibc-$VERSION
rm -rf ./glibc-$VERSION-orig
