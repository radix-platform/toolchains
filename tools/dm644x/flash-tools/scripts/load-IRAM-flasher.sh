#!/bin/sh

TOOLCHAIN_PATH=/opt/toolchains/arm-DM644X-eabi-newlib
entry=`cat $TOOLCHAIN_PATH/bin/boot-data/IRAM-flasher.entry`
TTY=/dev/ttyUSB0

$TOOLCHAIN_PATH/bin/IRAM-loader \
    --tty $TTY -e $entry \
          $TOOLCHAIN_PATH/bin/boot-data/IRAM-flasher.bin

