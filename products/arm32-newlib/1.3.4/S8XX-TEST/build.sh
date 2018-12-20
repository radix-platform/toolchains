#!/bin/bash

. ./.config

export PATH=$TOOLCHAIN_PATH/bin:$PATH

ARCH_OPTIONS=" -march=armv7-a -mtune=cortex-a5 -mfpu=neon -mfloat-abi=hard"

$TARGET-gcc -g -gdwarf-2 -fomit-frame-pointer ${ARCH_OPTIONS} -mlittle-endian -I$TOOLCHAIN_PATH/$TARGET/include -c -o main.o main.c
$TARGET-gcc ${ARCH_OPTIONS} -mlittle-endian  -o main main.o

$TARGET-objdump -x main > main.map

$TARGET-strip main -o main.elf

$TARGET-objcopy -O srec main.elf main.srec
$TARGET-objcopy -O ihex main.elf main.hex
$TARGET-objdump -S -d main.o > main.asm
$TARGET-objdump -S -d main > full.program.asm
