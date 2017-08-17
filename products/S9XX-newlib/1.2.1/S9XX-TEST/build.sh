#!/bin/sh

. ./.config

export PATH=$TOOLCHAIN_PATH/bin:$PATH

DEBUG_FLAGS="-gdwarf-2"
ARCH_FLAGS="-march=armv8-a -mcpu=cortex-a53 -mlittle-endian"

$TARGET-gcc -g $DEBUG_FLAGS -fomit-frame-pointer  -I$TOOLCHAIN_PATH/$TARGET/include -c -o main.o main.c
$TARGET-gcc $ARCH_FLAGS  -o main main.o -lc -lm -lnosys -lrdimon

$TARGET-strip main -o main.elf

$TARGET-objcopy -O srec main.elf main.srec
$TARGET-objcopy -O ihex main.elf main.hex
$TARGET-objdump -S -d main.o > main.asm
$TARGET-objdump -S -d main > full.program.asm