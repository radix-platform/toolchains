#!/bin/sh

VERSION=2.20.1

tar --files-from=file.list -xjvf ../binutils-${VERSION}a.tar.bz2
mv binutils-$VERSION binutils-$VERSION-orig

cp -rf ./binutils-$VERSION-new ./binutils-$VERSION

diff -b --unified -Nr  binutils-$VERSION-orig  binutils-$VERSION > binutils-$VERSION-mips-opcodes.patch

mv binutils-$VERSION-mips-opcodes.patch ../patches

rm -rf ./binutils-$VERSION
rm -rf ./binutils-$VERSION-orig
