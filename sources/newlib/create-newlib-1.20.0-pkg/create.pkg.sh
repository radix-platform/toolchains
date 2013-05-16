#!/bin/sh

VERSION=1.20.0

tar --files-from=file.list -xzvf ../newlib-$VERSION.tar.gz
mv newlib-$VERSION newlib-$VERSION-orig

cp -rf ./newlib-$VERSION-new ./newlib-$VERSION

diff -b --unified -Nr  newlib-$VERSION-orig  newlib-$VERSION > newlib-$VERSION-arm-cross.patch

rm -rf ./newlib-$VERSION
rm -rf ./newlib-$VERSION-orig

# reconfigure:
tar -xzvf ../newlib-$VERSION.tar.gz
patch -p0 < newlib-$VERSION-arm-cross.patch
(cd newlib-$VERSION/newlib/libc/sys/arm && \
    aclocal -I ../../.. && \
    autoconf && \
    automake --cygnus --add-missing Makefile && \
    rm -rf autom4te.cache )
(cd newlib-$VERSION/newlib/doc && \
    aclocal -I .. && \
    autoconf && \
    automake --cygnus --add-missing Makefile && \
    rm -rf autom4te.cache )
tar -czvf ../newlib-$VERSION-arm-cross.tar.gz  newlib-$VERSION
rm -rf ./newlib-$VERSION
