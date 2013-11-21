#!/bin/sh

VERSION=1.6

tar --files-from=file.list -xjvf ../elf2flt-$VERSION.tar.bz2
mv elf2flt-$VERSION elf2flt-$VERSION-orig

cp -rf ./elf2flt-$VERSION-new ./elf2flt-$VERSION

diff -b --unified -Nr  elf2flt-$VERSION-orig  elf2flt-$VERSION > elf2flt-$VERSION-verbose.patch

mv elf2flt-$VERSION-verbose.patch ../patches

rm -rf ./elf2flt-$VERSION
rm -rf ./elf2flt-$VERSION-orig
