#!/bin/sh

. ./.config

export PATH=$TOOLCHAIN_PATH/bin:$PATH

$TARGET-gcc -g -gdwarf-2 -fomit-frame-pointer -mcpu=arm926ej-s -mlittle-endian -I$TOOLCHAIN_PATH/$TARGET/include -c -o main.o main.c
$TARGET-gcc -mcpu=arm926ej-s -mlittle-endian  -o main main.o

$TARGET-objdump -x main > main.map

$TARGET-strip main -o main.elf

$TARGET-objcopy -O srec main.elf main.srec
$TARGET-objcopy -O ihex main.elf main.hex
$TARGET-objdump -S -d main.o > main.asm
$TARGET-objdump -S -d main > full.program.asm
