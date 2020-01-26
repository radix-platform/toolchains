#!/bin/bash

VERSION=2.30

tar --files-from=file.list -xJvf ../glibc-$VERSION.tar.xz
mv glibc-$VERSION glibc-$VERSION-orig

cp -rf ./glibc-$VERSION-new ./glibc-$VERSION

diff -b --unified -Nr  glibc-$VERSION-orig  glibc-$VERSION > glibc-$VERSION-posix-tempname.patch

mv glibc-$VERSION-posix-tempname.patch ../patches

rm -rf ./glibc-$VERSION
rm -rf ./glibc-$VERSION-orig
