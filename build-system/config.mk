# include once
ifndef CONFIG_MK

#######
####### Constants:
#######

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
HOST_DIR  = $(word 1, $subst -, ,$(BUILD_ARCH))
HOST_PATH = $(TOOLCHAINS_BASE_PATH)/$(HOST_DIR)


#######
####### Additional Available Toolchains:
#######

# AT91SAM7S
TOOLCHAIN_AT91SAM7S_NEWLIB = at91sam7s-newlib

AT91SAM7S_NEWLIB_ARCH = arm-at91sam7s-elf
AT91SAM7S_NEWLIB_DIR  = arm-AT91SAM7S-elf-newlib
AT91SAM7S_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(AT91SAM7S_NEWLIB_DIR)


# TMS320DM644X
TOOLCHAIN_DM644X_NEWLIB = dm644x-newlib

DM644X_NEWLIB_ARCH = arm-dm644x-elf
DM644X_NEWLIB_DIR  = arm-DM644X-elf-newlib
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


# OMAP35X-EGLIBC
TOOLCHAIN_OMAP35X_EGLIBC = omap35x-eglibc

OMAP35X_EGLIBC_ARCH = arm-omap35x-linux-gnueabi
OMAP35X_EGLIBC_DIR  = arm-OMAP35X-linux-eglibc
OMAP35X_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(OMAP35X_EGLIBC_DIR)


# AllWinner A10
TOOLCHAIN_A1X_NEWLIB = a1x-newlib

A1X_NEWLIB_ARCH = arm-a1x-eabi
A1X_NEWLIB_DIR  = arm-A1X-eabi-newlib
A1X_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(A1X_NEWLIB_DIR)

# AllWinner A10-EGLIBC
TOOLCHAIN_A1X_EGLIBC = a1x-eglibc

A1X_EGLIBC_ARCH = arm-a1x-linux-gnueabi
A1X_EGLIBC_DIR  = arm-A1X-linux-eglibc
A1X_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(A1X_EGLIBC_DIR)


# BCM74X-EGLIBC
TOOLCHAIN_BCM74X_EGLIBC = bcm74x-eglibc

BCM74X_EGLIBC_ARCH = mipsel-bcm74x-linux-gnu
BCM74X_EGLIBC_DIR  = mipsel-BCM74X-linux-eglibc
BCM74X_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(BCM74X_EGLIBC_DIR)


# X86_64-EGLIBC
TOOLCHAIN_X86_64_EGLIBC = x86_64-eglibc

X86_64_EGLIBC_ARCH = x86_64-kxLab-linux-gnu
X86_64_EGLIBC_DIR  = x86_64-PC-linux-eglibc
X86_64_EGLIBC_PATH = $(TOOLCHAINS_BASE_PATH)/$(X86_64_EGLIBC_DIR)



CONFIG_MK=1
endif
