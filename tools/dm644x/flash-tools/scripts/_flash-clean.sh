#!/bin/sh

TOOLCHAIN_PATH=/opt/toolchains/arm-DM644X-eabi-newlib
TTY=/dev/ttyUSB0

$TOOLCHAIN_PATH/bin/NOR-flasher --tty $TTY --erase

