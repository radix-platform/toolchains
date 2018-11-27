#!/bin/bash

. ./.config

export PATH=$TOOLCHAIN_PATH/bin:$PATH

ARCH_FLAGS="-mthumb -march=armv7-m"
FPU_FLAGS=" -mfloat-abi=softfp"
#NO_STD_FLAGS=" -nostdlib -nostartfiles"

$TARGET-gcc -g -fomit-frame-pointer $ARCH_FLAGS $FPU_FLAGS  -c -o main.o main.c

$TARGET-gcc ${NO_STD_FLAGS} $ARCH_FLAGS $FPU_FLAGS $LDFLAGS -o main main.o

$TARGET-objdump -x main.gdb > main.map

$TARGET-strip main.gdb -o main.elf

$TARGET-objcopy -O srec main.elf main.srec
$TARGET-objcopy -O ihex main.elf main.hex
$TARGET-objdump -S -d main.o > main.asm
$TARGET-objdump -S -d main.gdb > full.program.asm
