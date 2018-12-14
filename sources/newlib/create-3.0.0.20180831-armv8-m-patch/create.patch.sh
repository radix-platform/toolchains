#!/bin/bash

VERSION=3.0.0.20180831

tar --files-from=file.list -xzvf ../newlib-$VERSION.tar.gz
mv newlib-$VERSION newlib-$VERSION-orig

cp -rf ./newlib-$VERSION-new ./newlib-$VERSION

diff -b --unified -Nr  newlib-$VERSION-orig  newlib-$VERSION > newlib-$VERSION-armv8-m.patch

mv newlib-$VERSION-armv8-m.patch ../patches

rm -rf ./newlib-$VERSION
rm -rf ./newlib-$VERSION-orig
