#!/bin/sh

TOOLCHAIN_PATH=/opt/toolchains/arm-DM644X-elf-newlib
TTY=/dev/ttyUSB0

$TOOLCHAIN_PATH/bin/NOR-flasher --tty $TTY -a 02000000 u-boot-1.1.4.bin
