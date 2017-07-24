#!/bin/sh

. ./.config

export PATH=$TOOLCHAIN_PATH/bin:$PATH

DEBUG_FLAGS="-gdwarf-2"
ARCH_FLAGS="-march=armv7-a -mcpu=cortex-a5"
#NO_STD_FLAGS=" -nostdlib -nostartfiles"

$TARGET-gcc -g $DEBUG_FLAGS $ARCH_FLAGS $FPU_FLAGS -I$TOOLCHAIN_PATH/$TARGET/include -c -o main.o main.c

$TARGET-gcc ${NO_STD_FLAGS} $ARCH_FLAGS $FPU_FLAGS $LDFLAGS -o main main.o

$TARGET-strip main -o main.elf

$TARGET-objcopy -O srec main.elf main.srec
$TARGET-objcopy -O ihex main.elf main.hex
$TARGET-objdump -S -d main.o > main.asm
$TARGET-objdump -S -d main > full.program.asm
