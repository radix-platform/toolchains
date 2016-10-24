#!/bin/sh

. ./.config

export PATH=$TOOLCHAIN_PATH/bin:$PATH

arm-at91sam7s-elf-gcc -g -gdwarf-2 -fomit-frame-pointer -mcpu=arm7tdmi -mbig-endian  -I$TOOLCHAIN_PATH/include -c -o main.o main.c
arm-at91sam7s-elf-gcc -mcpu=arm7tdmi -mbig-endian  -o main main.o

arm-at91sam7s-elf-strip main -o main.elf

arm-at91sam7s-elf-objcopy -O srec main.elf main.srec
arm-at91sam7s-elf-objcopy -O ihex main.elf main.hex
arm-at91sam7s-elf-objdump -S -d main.o > main.asm
arm-at91sam7s-elf-objdump -S -d main > full.program.asm
