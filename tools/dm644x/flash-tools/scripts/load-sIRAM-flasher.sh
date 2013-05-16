#!/bin/sh

TOOLCHAIN_PATH=/opt/toolchains/arm-DM644X-elf-newlib
entry=`cat $TOOLCHAIN_PATH/bin/boot-data/sIRAM-flasher.entry`
TTY=/dev/ttyUSB0

$TOOLCHAIN_PATH/bin/sIRAM-loader \
    --tty $TTY -e $entry \
       -p $TOOLCHAIN_PATH/bin/boot-data/sIRAM-flasher.uart-pkh \
          $TOOLCHAIN_PATH/bin/boot-data/sIRAM-flasher.module

