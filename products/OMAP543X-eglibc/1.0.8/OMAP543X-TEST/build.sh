#!/bin/sh

. ./.config

export PATH=$TOOLCHAIN_PATH/bin:$PATH

ARCH_FLAGS=" -march=armv7-a -mtune=cortex-a15"
#FPU_FLAGS=" "
# NEON:
#FPU_FLAGS=" -mfloat-abi=hard -mfpu=neon -ffast-math"
# vfpv3-d16:
#FPU_FLAGS=" -mfloat-abi=hard -mfpu=vfpv3-d16 -ffast-math"
# vfpv4-d16:
#FPU_FLAGS=" -mfloat-abi=hard -mfpu=vfpv4-d16 -ffast-math"
# NEON + VFPv4:
#FPU_FLAGS=" -mfloat-abi=hard -mfpu=neon-vfpv4  -ffast-math"

$TARGET-gcc -g -O3 -fomit-frame-pointer $ARCH_FLAGS $FPU_FLAGS -I$TOOLCHAIN_PATH/$TARGET/include -c -o main.o main.c
$TARGET-gcc $ARCH_FLAGS $FPU_FLAGS -o main main.o

$TARGET-objdump -x main > main.map

$TARGET-strip main -o main.elf

$TARGET-objcopy -O srec main.elf main.srec
$TARGET-objcopy -O ihex main.elf main.hex
$TARGET-objdump -S -d main.o > main.asm
$TARGET-objdump -S -d main > full.program.asm
