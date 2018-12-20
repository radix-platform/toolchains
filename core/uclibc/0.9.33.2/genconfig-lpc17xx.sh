#!/bin/bash

if [ $# -lt 3 ]; then
  exit 1
fi

TARGET=$1
shift
SYSROOT_DIR=$1
shift
multilibs=$@

runtime_prefix=/
dev_prefix=/usr
multilib=lib
extra_cflags=

#
# Valid multilibs="arm armv7-m"
#

for mlib in $multilibs ; do

  case $mlib in
    arm)
      runtime_prefix=/
      dev_prefix=/usr
      multilib_dir=lib
      extra_cflags=
      source_config_file=lpc17xx-config.arm
      target_config_file=.config.arm
      ;;
    armv7-m)
      runtime_prefix=/
      dev_prefix=/usr
      multilib_dir=lib/thumb/armv7-m
      extra_cflags="-mthumb -march=armv7-m"
      source_config_file=lpc17xx-config.armv7-m
      target_config_file=.config.armv7-m
      ;;
    *)
      runtime_prefix=/
      dev_prefix=/usr
      multilib_dir=lib
      extra_cflags=
      source_config_file=lpc17xx-config.arm
      target_config_file=.config.arm
      ;;
  esac

  cat ${source_config_file} | sed \
    -e "/^CROSS_COMPILER_PREFIX/s:=.*:=\"${TARGET}-\":" \
    -e "/^KERNEL_HEADERS/s:=.*:=\"${SYSROOT_DIR}/usr/include\":" \
    -e "/^RUNTIME_PREFIX/s:=.*:=\"${runtime_prefix}\":" \
    -e "/^DEVEL_PREFIX/s:=.*:=\"${dev_prefix}\":" \
    -e "/^MULTILIB_DIR/s:=.*:=\"${multilib_dir}\":" \
    -e "/^UCLIBC_EXTRA_CFLAGS/s:=.*:=\" ${extra_cflags}\":" \
    > ${target_config_file}
done
