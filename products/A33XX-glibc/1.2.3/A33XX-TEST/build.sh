#!/bin/bash

. ./.config

export PATH=$TOOLCHAIN_PATH/bin:$PATH

ARCH_FLAGS=" -march=armv8-a"

FPU_FLAGS=" -mfloat-abi=hard -mfpu=neon-fp-armv8 -ftree-vectorize -fomit-frame-pointer -ffast-math"

$TARGET-gcc -g -O3 -gdwarf-2 -fomit-frame-pointer $ARCH_FLAGS $FPU_FLAGS -I$TOOLCHAIN_PATH/$TARGET/include -c -o main.o main.c
$TARGET-gcc $ARCH_FLAGS $FPU_FLAGS -o main main.o

$TARGET-objdump -x main > main.map

$TARGET-strip main -o main.elf

$TARGET-objcopy -O srec main.elf main.srec
$TARGET-objcopy -O ihex main.elf main.hex
$TARGET-objdump -S -d main.o > main.asm
$TARGET-objdump -S -d main > full.program.asm
