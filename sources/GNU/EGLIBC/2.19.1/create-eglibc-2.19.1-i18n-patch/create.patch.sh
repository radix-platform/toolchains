#!/bin/sh

VERSION=2.19.1

tar --files-from=file.list -xjvf ../eglibc-$VERSION.tar.bz2
mv eglibc-$VERSION eglibc-$VERSION-orig

cp -rf ./eglibc-$VERSION-new ./eglibc-$VERSION

diff -b --unified -Nr  eglibc-$VERSION-orig  eglibc-$VERSION > eglibc-$VERSION-i18n.patch

mv eglibc-$VERSION-i18n.patch ../patches

rm -rf ./eglibc-$VERSION
rm -rf ./eglibc-$VERSION-orig
