#!/bin/sh

. ./.config

export PATH=$TOOLCHAIN_PATH/bin:$PATH

ARCH_FLAGS=" -g -O3 -m32 -mcpu=power9 -mlong-double-128"


$TARGET-gcc -m32 -g -gdwarf-2 -fomit-frame-pointer $ARCH_FLAGS $FPU_FLAGS -I$TOOLCHAIN_PATH/$TARGET/include -c -o main.o main.c
$TARGET-gcc -m32 $ARCH_FLAGS $FPU_FLAGS -o main main.o

$TARGET-objdump -x main > main.map

$TARGET-strip main -o main.elf

$TARGET-objcopy -O srec main.elf main.srec
$TARGET-objcopy -O ihex main.elf main.hex
$TARGET-objdump -S -d main.o > main.asm
$TARGET-objdump -S -d main > full.program.asm
