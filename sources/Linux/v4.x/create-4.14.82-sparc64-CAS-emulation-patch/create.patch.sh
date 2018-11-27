#!/bin/bash

VERSION=4.14.82

tar --files-from=file.list -xJvf ../linux-$VERSION.tar.xz
mv linux-$VERSION linux-$VERSION-orig

cp -rf ./linux-$VERSION-new ./linux-$VERSION

diff -b --unified -Nr  linux-$VERSION-orig  linux-$VERSION > linux-$VERSION-sparc64-CAS-emulation.patch

mv linux-$VERSION-sparc64-CAS-emulation.patch ../patches

rm -rf ./linux-$VERSION
rm -rf ./linux-$VERSION-orig
