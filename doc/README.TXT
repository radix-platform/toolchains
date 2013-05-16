
environment:
===========

Now souce archives is placed on private ftp.radix.pro server and we have to use username and password to download sources.
So before build toolchains we have to create private file, for example:

$ touch ~/.radix-wgetrc
$ chmod 600 ~/.radix-wgetrc
$ vim ~/.radix-wgetrc

user=your_login
password=your_password

:wq

And export variable (for example, by devenv.sh script file):

#!/bin/sh

export WGET_OPTIONS="--config=/home/kx/prog/kx/.radix-wgetrc"


NOTE that we have to put the full path to .radix-wgetrc file.


build:
=====

cd sources && make all
cd profucts && make all

make targets:
============

tree_clean      - clean whole tree including dist and sources(.makefile stamps) directories but
                  !!!NOT CLEAN downloaded sources!!!

downloads_clean - remove downloaded sources in sources directory


NOTE:
====
  Directory names in products folder shouldn't match with any toolchain name.
  For example, if we have toolchain name 'x86_64-eglibc' then directory name
  for this toolchain should be at least 'X86_64-eglibc'.

