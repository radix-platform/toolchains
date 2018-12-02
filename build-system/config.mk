# include once
ifndef CONFIG_MK

#######
####### Constants:
#######


DOWNLOAD_SERVER      = ftp://ftp.radix.pro

WGET_OPTIONS         = -q -N

CACHED_CC_OUTPUT     = /opt/extra/ccache

TOOLCHAINS_BASE_PATH = /opt/toolchains

TOOLCHAINS_VERSION   = 1.0.0


# Build machine architrcture:

BUILD_ARCH = x86_64-pc-linux-gnu
#
# HOST and BUILD variables should be set up for each makefile.
# NOTE: the HOST is equal to BUILD because our toolchains work on BUILD machine.
#
 HOST = $(BUILD_ARCH)
BUILD = $(BUILD_ARCH)


#######
####### Standard Available Toolchains:
#######

#
# NOTE:
# ====
#   Toolchain names defined by 'TOOLCHAIN_...' variables.
#   Configuration variable names such as HOST_ARCH, HOST_DIR, HOST_PATH should have prefix
#   which is equal to $(TOOLCHAIN_...) in upper case letters and symbol '-' should be replaced with '_'.
#   In other words the PREFIX is equal to PREFIX = $(shell echo $(TOOLCHAIN_...) | tr '[a-z-]' '[A-Z_]').
#

# NOARCH
TOOLCHAIN_NOARCH = noarch

NOARCH_ARCH = noarch
NOARCH_DIR  = noarch
NOARCH_PATH = $(TOOLCHAINS_BASE_PATH)/noarch


# HOST
TOOLCHAIN_HOST = host

HOST_ARCH = $(BUILD_ARCH)
HOST_DIR  = $(word 1, $(subst -, ,$(BUILD_ARCH)))
HOST_PATH = $(TOOLCHAINS_BASE_PATH)/$(HOST_DIR)


#######
####### Additional Available Toolchains:
#######

# AT91SAM7S
TOOLCHAIN_AT91SAM7S_NEWLIB = at91sam7s-newlib

AT91SAM7S_NEWLIB_ARCH = arm-at91sam7s-eabi
AT91SAM7S_NEWLIB_DIR  = arm-AT91SAM7S-eabi-newlib
AT91SAM7S_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(AT91SAM7S_NEWLIB_DIR)
###                    |---Toolchain-spec-handy-ruler----------------|
AT91SAM7S_NEWLIB_SPEC = Atmel AT91SAM7S newlib toolchain


# LPC17XX-UCLIBC
TOOLCHAIN_LPC17XX_UCLIBC = lpc17xx-uclibc

LPC17XX_UCLIBC_ARCH = arm-lpc17xx-uclinuxeabi
LPC17XX_UCLIBC_DIR  = arm-LPC17XX-uclinuxeabi
LPC17XX_UCLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(LPC17XX_UCLIBC_DIR)
###                  |---Toolchain-spec-handy-ruler----------------|
LPC17XX_UCLIBC_SPEC = NXP LPC17xx uclibc toolchain


# IMX6-GLIBC
TOOLCHAIN_IMX6_GLIBC = imx6-glibc

IMX6_GLIBC_ARCH = arm-imx6-linux-gnueabihf
IMX6_GLIBC_DIR  = arm-IMX6-linux-glibc
IMX6_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(IMX6_GLIBC_DIR)
###              |---Toolchain-spec-handy-ruler----------------|
IMX6_GLIBC_SPEC = Freescale i.MX6 GNU Libc toolchain


# OMAP543X-GLIBC
TOOLCHAIN_OMAP543X_GLIBC = omap543x-glibc

OMAP543X_GLIBC_ARCH = arm-omap543x-linux-gnueabihf
OMAP543X_GLIBC_DIR  = arm-OMAP543X-linux-glibc
OMAP543X_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(OMAP543X_GLIBC_DIR)
###                  |---Toolchain-spec-handy-ruler----------------|
OMAP543X_GLIBC_SPEC = Texas OMAP543x GNU Libc toolchain


# AllWinner A10
TOOLCHAIN_A1X_NEWLIB = a1x-newlib

A1X_NEWLIB_ARCH = arm-a1x-eabi
A1X_NEWLIB_DIR  = arm-A1X-eabi-newlib
A1X_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(A1X_NEWLIB_DIR)
###              |---Toolchain-spec-handy-ruler----------------|
A1X_NEWLIB_SPEC = Allwinner A1x newlib toolchain

# AllWinner A20
TOOLCHAIN_A2X_NEWLIB = a2x-newlib

A2X_NEWLIB_ARCH = arm-a2x-eabi
A2X_NEWLIB_DIR  = arm-A2X-eabi-newlib
A2X_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(A2X_NEWLIB_DIR)
###              |---Toolchain-spec-handy-ruler----------------|
A2X_NEWLIB_SPEC = Allwinner A2x newlib toolchain

# AllWinner A10-GLIBC
TOOLCHAIN_A1X_GLIBC = a1x-glibc

A1X_GLIBC_ARCH = arm-a1x-linux-gnueabihf
A1X_GLIBC_DIR  = arm-A1X-linux-glibc
A1X_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(A1X_GLIBC_DIR)
###             |---Toolchain-spec-handy-ruler----------------|
A1X_GLIBC_SPEC = Allwinner A1x GNU Libc toolchain


# AllWinner A20-GLIBC
TOOLCHAIN_A2X_GLIBC = a2x-glibc

A2X_GLIBC_ARCH = arm-a2x-linux-gnueabihf
A2X_GLIBC_DIR  = arm-A2X-linux-glibc
A2X_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(A2X_GLIBC_DIR)
###             |---Toolchain-spec-handy-ruler----------------|
A2X_GLIBC_SPEC = Allwinner A2x GNU Libc toolchain


# AllWinner H3-NEWLIB
TOOLCHAIN_H3_NEWLIB = h3-newlib

H3_NEWLIB_ARCH = arm-h3-eabi
H3_NEWLIB_DIR  = arm-H3-eabi-newlib
H3_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(H3_NEWLIB_DIR)
###             |---Toolchain-spec-handy-ruler----------------|
H3_NEWLIB_SPEC = Allwinner H3 newlib toolchain

# AllWinner H3-GLIBC
TOOLCHAIN_H3_GLIBC = h3-glibc

H3_GLIBC_ARCH = arm-h3-linux-gnueabihf
H3_GLIBC_DIR  = arm-H3-linux-glibc
H3_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(H3_GLIBC_DIR)
###            |---Toolchain-spec-handy-ruler----------------|
H3_GLIBC_SPEC = Allwinner H3 GNU Libc toolchain


# AllWinner H5-NEWLIB
TOOLCHAIN_H5_NEWLIB = h5-newlib

H5_NEWLIB_ARCH = aarch64-h5-elf
H5_NEWLIB_DIR  = aarch64-H5-elf-newlib
H5_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(H5_NEWLIB_DIR)
###             |---Toolchain-spec-handy-ruler----------------|
H5_NEWLIB_SPEC = Allwinner H5 newlib toolchain

# AllWinner H5-GLIBC
TOOLCHAIN_H5_GLIBC = h5-glibc

H5_GLIBC_ARCH = aarch64-h5-linux-gnu
H5_GLIBC_DIR  = aarch64-H5-linux-glibc
H5_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(H5_GLIBC_DIR)
###            |---Toolchain-spec-handy-ruler----------------|
H5_GLIBC_SPEC = Allwinner H5 GNU Libc toolchain


# Amlogic S8XX
TOOLCHAIN_S8XX_NEWLIB = s8xx-newlib

S8XX_NEWLIB_ARCH = arm-s8xx-eabi
S8XX_NEWLIB_DIR  = arm-S8XX-eabi-newlib
S8XX_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(S8XX_NEWLIB_DIR)
###               |---Toolchain-spec-handy-ruler----------------|
S8XX_NEWLIB_SPEC = Amlogic S8xx newlib toolchain

# Amlogic S8XX-GLIBC
TOOLCHAIN_S8XX_GLIBC = s8xx-glibc

S8XX_GLIBC_ARCH = arm-s8xx-linux-gnueabihf
S8XX_GLIBC_DIR  = arm-S8XX-linux-glibc
S8XX_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(S8XX_GLIBC_DIR)
###              |---Toolchain-spec-handy-ruler----------------|
S8XX_GLIBC_SPEC = Amlogic S8xx GNU Libc toolchain


# Amlogic S9XX (especially for u-boot firmware)
TOOLCHAIN_A9XX_NEWLIB = a9xx-newlib

A9XX_NEWLIB_ARCH = arm-a9xx-eabi
A9XX_NEWLIB_DIR  = arm-A9XX-eabi-newlib
A9XX_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(A9XX_NEWLIB_DIR)
###               |---Toolchain-spec-handy-ruler----------------|
A9XX_NEWLIB_SPEC = Amlogic S9xx Cortex-m3 newlib toolchain

# Amlogic S9XX
TOOLCHAIN_S9XX_NEWLIB = s9xx-newlib

S9XX_NEWLIB_ARCH = aarch64-s9xx-elf
S9XX_NEWLIB_DIR  = aarch64-S9XX-elf-newlib
S9XX_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(S9XX_NEWLIB_DIR)
###               |---Toolchain-spec-handy-ruler----------------|
S9XX_NEWLIB_SPEC = Amlogic S9xx newlib toolchain

# Amlogic S9XX-GLIBC
TOOLCHAIN_S9XX_GLIBC = s9xx-glibc

S9XX_GLIBC_ARCH = aarch64-s9xx-linux-gnu
S9XX_GLIBC_DIR  = aarch64-S9XX-linux-glibc
S9XX_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(S9XX_GLIBC_DIR)
###              |---Toolchain-spec-handy-ruler----------------|
S9XX_GLIBC_SPEC = Amlogic S9xx GNU Libc toolchain

# Amlogic A9XX-GLIBC
TOOLCHAIN_A9XX_GLIBC = a9xx-glibc

A9XX_GLIBC_ARCH = armv8l-a9xx-linux-gnueabihf
A9XX_GLIBC_DIR  = armv8l-A9XX-linux-glibc
A9XX_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(A9XX_GLIBC_DIR)
###              |---Toolchain-spec-handy-ruler----------------|
A9XX_GLIBC_SPEC = Amlogic S9xx armv8l GNU Libc toolchain


# Rockchip A33XX-NEWLIB (ARMv6-M Cortex-m0)
TOOLCHAIN_A33XX_NEWLIB = a33xx-newlib

A33XX_NEWLIB_ARCH = arm-a33xx-eabi
A33XX_NEWLIB_DIR  = arm-A33XX-eabi-newlib
A33XX_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(A33XX_NEWLIB_DIR)
###                |---Toolchain-spec-handy-ruler----------------|
A33XX_NEWLIB_SPEC = Rockchip RK33xx Cortex-m0 newlib toolchain

# Rockchip RK33XX-NEWLIB
TOOLCHAIN_RK33XX_NEWLIB = rk33xx-newlib

RK33XX_NEWLIB_ARCH = aarch64-rk33xx-elf
RK33XX_NEWLIB_DIR  = aarch64-RK33XX-elf-newlib
RK33XX_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(RK33XX_NEWLIB_DIR)
###                 |---Toolchain-spec-handy-ruler----------------|
RK33XX_NEWLIB_SPEC = Rockchip RK33xx newlib toolchain

# Rockchip RK33XX-GLIBC
TOOLCHAIN_RK33XX_GLIBC = rk33xx-glibc

RK33XX_GLIBC_ARCH = aarch64-rk33xx-linux-gnu
RK33XX_GLIBC_DIR  = aarch64-RK33XX-linux-glibc
RK33XX_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(RK33XX_GLIBC_DIR)
###                |---Toolchain-spec-handy-ruler----------------|
RK33XX_GLIBC_SPEC = Rockchip RK33xx GNU Libc toolchain

# Rockchip A33XX-GLIBC
TOOLCHAIN_A33XX_GLIBC = a33xx-glibc

A33XX_GLIBC_ARCH = armv8l-a33xx-linux-gnueabihf
A33XX_GLIBC_DIR  = armv8l-A33XX-linux-glibc
A33XX_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(A33XX_GLIBC_DIR)
###               |---Toolchain-spec-handy-ruler----------------|
A33XX_GLIBC_SPEC = Rockchip RK33xx armv8l GNU Libc toolchain


# Rockchip RK328X-GLIBC
TOOLCHAIN_RK328X_GLIBC = rk328x-glibc

RK328X_GLIBC_ARCH = arm-rk328x-linux-gnueabihf
RK328X_GLIBC_DIR  = arm-RK328X-linux-glibc
RK328X_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(RK328X_GLIBC_DIR)
###                |---Toolchain-spec-handy-ruler----------------|
RK328X_GLIBC_SPEC = Rockchip RK328x GNU Libc toolchain


# JZ47XX-GLIBC
TOOLCHAIN_JZ47XX_GLIBC = jz47xx-glibc

JZ47XX_GLIBC_ARCH = mipsel-jz47xx-linux-gnu
JZ47XX_GLIBC_DIR  = mipsel-JZ47XX-linux-glibc
JZ47XX_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(JZ47XX_GLIBC_DIR)
###                |---Toolchain-spec-handy-ruler----------------|
JZ47XX_GLIBC_SPEC = Ingenic MIPS jz47xx GNU Libc toolchain


# P5600-GLIBC
TOOLCHAIN_P5600_GLIBC = p5600-glibc

P5600_GLIBC_ARCH = mipsel-p5600-linux-gnu
P5600_GLIBC_DIR  = mipsel-P5600-linux-glibc
P5600_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(P5600_GLIBC_DIR)
###               |---Toolchain-spec-handy-ruler----------------|
P5600_GLIBC_SPEC = Baikal MIPS p5600 core GNU Libc toolchain


# POWER8-GLIBC
TOOLCHAIN_POWER8_GLIBC = power8-glibc

POWER8_GLIBC_ARCH = ppc64-power8-linux-gnu
POWER8_GLIBC_DIR  = ppc64-POWER8-linux-glibc
POWER8_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(POWER8_GLIBC_DIR)
###                |---Toolchain-spec-handy-ruler----------------|
POWER8_GLIBC_SPEC = Openpower POWER8 MSB GNU Libc toolchain

# POWER9-GLIBC
TOOLCHAIN_POWER9_GLIBC = power9-glibc

POWER9_GLIBC_ARCH = ppc64-power9-linux-gnu
POWER9_GLIBC_DIR  = ppc64-POWER9-linux-glibc
POWER9_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(POWER9_GLIBC_DIR)
###                |---Toolchain-spec-handy-ruler----------------|
POWER9_GLIBC_SPEC = Openpower POWER9 MSB GNU Libc toolchain


# POWER8LE-GLIBC
TOOLCHAIN_POWER8LE_GLIBC = power8le-glibc

POWER8LE_GLIBC_ARCH = ppc64le-power8-linux-gnu
POWER8LE_GLIBC_DIR  = ppc64le-POWER8-linux-glibc
POWER8LE_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(POWER8LE_GLIBC_DIR)
###                  |---Toolchain-spec-handy-ruler----------------|
POWER8LE_GLIBC_SPEC = Openpower POWER8 LSB GNU Libc toolchain

# POWER9LE-GLIBC
TOOLCHAIN_POWER9LE_GLIBC = power9le-glibc

POWER9LE_GLIBC_ARCH = ppc64le-power9-linux-gnu
POWER9LE_GLIBC_DIR  = ppc64le-POWER9-linux-glibc
POWER9LE_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(POWER9LE_GLIBC_DIR)
###                  |---Toolchain-spec-handy-ruler----------------|
POWER9LE_GLIBC_SPEC = Openpower POWER9 LSB GNU Libc toolchain


# R1000-GLIBC
TOOLCHAIN_R1000_GLIBC = r1000-glibc

R1000_GLIBC_ARCH = sparc64-r1000-linux-gnu
R1000_GLIBC_DIR  = sparc64-R1000-linux-glibc
R1000_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(R1000_GLIBC_DIR)
###               |---Toolchain-spec-handy-ruler----------------|
R1000_GLIBC_SPEC = MCST SPARC MSB GNU Libc toolchain


# X86_64-GLIBC
TOOLCHAIN_X86_64_GLIBC = x86_64-glibc

X86_64_GLIBC_ARCH = x86_64-radix-linux-gnu
X86_64_GLIBC_DIR  = x86_64-PC-linux-glibc
X86_64_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(X86_64_GLIBC_DIR)
###                |---Toolchain-spec-handy-ruler----------------|
X86_64_GLIBC_SPEC = Intel x86_64 GNU Libc toolchain


# I686-GLIBC
TOOLCHAIN_I686_GLIBC = i686-glibc

I686_GLIBC_ARCH = i686-radix-linux-gnu
I686_GLIBC_DIR  = i686-PC-linux-glibc
I686_GLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(I686_GLIBC_DIR)
###              |---Toolchain-spec-handy-ruler----------------|
I686_GLIBC_SPEC = Intel i686 GNU Libc toolchain



CONFIG_MK=1
endif
