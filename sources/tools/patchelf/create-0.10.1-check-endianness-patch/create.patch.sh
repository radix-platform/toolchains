#!/bin/sh

VERSION=0.10.1

tar --files-from=file.list -xJvf ../patchelf-$VERSION.tar.xz
mv patchelf-$VERSION patchelf-$VERSION-orig

cp -rf ./patchelf-$VERSION-new ./patchelf-$VERSION

diff -b --unified -Nr  patchelf-$VERSION-orig  patchelf-$VERSION > patchelf-$VERSION-check-endianness.patch

mv patchelf-$VERSION-check-endianness.patch ../patches

rm -rf ./patchelf-$VERSION
rm -rf ./patchelf-$VERSION-orig
