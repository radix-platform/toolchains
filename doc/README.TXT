
build:
=====

cd profucts && make -j32 all

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
