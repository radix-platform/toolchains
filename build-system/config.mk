# include once
ifndef CONFIG_MK

#######
####### Constants:
#######


DOWNLOAD_SERVER      = ftp://ftp.radix.pro

TOOLCHAINS_BASE_PATH = /opt/toolchain
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


# TMS320DM644X
TOOLCHAIN_DM644X_NEWLIB = dm644x-newlib

DM644X_NEWLIB_ARCH = arm-dm644x-eabi
DM644X_NEWLIB_DIR  = arm-DM644X-eabi-newlib
DM644X_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(DM644X_NEWLIB_DIR)

# DM644X-EGLIBC
TOOLCHAIN_DM644X_EGLIBC = dm644x-eglibc

DM644X_EGLIBC_ARCH = arm-dm644x-linux-gnueabi
DM644X_EGLIBC_DIR  = arm-DM644X-linux-eglibc
DM644X_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(DM644X_EGLIBC_DIR)


# LPC17XX-UCLIBC
TOOLCHAIN_LPC17XX_UCLIBC = lpc17xx-uclibc

LPC17XX_UCLIBC_ARCH = arm-lpc17xx-uclinuxeabi
LPC17XX_UCLIBC_DIR  = arm-LPC17XX-uclinuxeabi
LPC17XX_UCLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(LPC17XX_UCLIBC_DIR)


# IMX6-EGLIBC
TOOLCHAIN_IMX6_EGLIBC = imx6-eglibc

IMX6_EGLIBC_ARCH = arm-imx6-linux-gnueabi
IMX6_EGLIBC_DIR  = arm-IMX6-linux-eglibc
IMX6_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(IMX6_EGLIBC_DIR)


# OMAP35X-EGLIBC
TOOLCHAIN_OMAP35X_EGLIBC = omap35x-eglibc

OMAP35X_EGLIBC_ARCH = arm-omap35x-linux-gnueabi
OMAP35X_EGLIBC_DIR  = arm-OMAP35X-linux-eglibc
OMAP35X_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(OMAP35X_EGLIBC_DIR)


# OMAP543X-EGLIBC
TOOLCHAIN_OMAP543X_EGLIBC = omap543x-eglibc

OMAP543X_EGLIBC_ARCH = arm-omap543x-linux-gnueabihf
OMAP543X_EGLIBC_DIR  = arm-OMAP543X-linux-eglibc
OMAP543X_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(OMAP543X_EGLIBC_DIR)


# AllWinner A10
TOOLCHAIN_A1X_NEWLIB = a1x-newlib

A1X_NEWLIB_ARCH = arm-a1x-eabi
A1X_NEWLIB_DIR  = arm-A1X-eabi-newlib
A1X_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(A1X_NEWLIB_DIR)

# AllWinner A10-EGLIBC
TOOLCHAIN_A1X_EGLIBC = a1x-eglibc

A1X_EGLIBC_ARCH = arm-a1x-linux-gnueabihf
A1X_EGLIBC_DIR  = arm-A1X-linux-eglibc
A1X_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(A1X_EGLIBC_DIR)


# AllWinner A20-EGLIBC
TOOLCHAIN_A2X_EGLIBC = a2x-eglibc

A2X_EGLIBC_ARCH = arm-a2x-linux-gnueabihf
A2X_EGLIBC_DIR  = arm-A2X-linux-eglibc
A2X_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(A2X_EGLIBC_DIR)


# BCM74X-EGLIBC
TOOLCHAIN_BCM74X_EGLIBC = bcm74x-eglibc

BCM74X_EGLIBC_ARCH = mipsel-bcm74x-linux-gnu
BCM74X_EGLIBC_DIR  = mipsel-BCM74X-linux-eglibc
BCM74X_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(BCM74X_EGLIBC_DIR)


# X86_64-EGLIBC
TOOLCHAIN_X86_64_EGLIBC = x86_64-eglibc

X86_64_EGLIBC_ARCH = x86_64-radix-linux-gnu
X86_64_EGLIBC_DIR  = x86_64-PC-linux-eglibc
X86_64_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(X86_64_EGLIBC_DIR)


# I486-EGLIBC
TOOLCHAIN_I486_EGLIBC = i486-eglibc

I486_EGLIBC_ARCH = i486-radix-linux-gnu
I486_EGLIBC_DIR  = i486-PC-linux-eglibc
I486_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(I486_EGLIBC_DIR)



CONFIG_MK=1
endif
