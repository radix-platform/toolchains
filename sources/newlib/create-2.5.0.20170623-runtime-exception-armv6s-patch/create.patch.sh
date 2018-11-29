#!/bin/bash

VERSION=2.5.0.20170623

tar --files-from=file.list -xzvf ../newlib-$VERSION.tar.gz
mv newlib-$VERSION newlib-$VERSION-orig

cp -rf ./newlib-$VERSION-new ./newlib-$VERSION

diff -b --unified -Nr  newlib-$VERSION-orig  newlib-$VERSION > newlib-$VERSION-runtime-exception-armv6s.patch

mv newlib-$VERSION-runtime-exception-armv6s.patch ../patches

rm -rf ./newlib-$VERSION
rm -rf ./newlib-$VERSION-orig
