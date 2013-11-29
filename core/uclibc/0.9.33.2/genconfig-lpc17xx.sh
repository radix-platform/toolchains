#!/bin/sh

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
# Valid multilibs="arm fpu thumb thumb1 thumb2 armv7-m armv7e-m"
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
    fpu)
      runtime_prefix=/fpu/
      dev_prefix=/fpu/usr
      multilib_dir=lib
      extra_cflags="-mfloat-abi=hard"
      source_config_file=lpc17xx-config.fpu
      target_config_file=.config.fpu
      ;;
    thumb)
      runtime_prefix=/thumb/
      dev_prefix=/thumb/usr
      multilib_dir=lib
      extra_cflags="-mthumb"
      source_config_file=lpc17xx-config.thumb
      target_config_file=.config.thumb
      ;;
    thumb1)
      runtime_prefix=/thumb1/
      dev_prefix=/thumb1/usr
      multilib_dir=lib
      extra_cflags="-mthumb -march=armv4t"
      source_config_file=lpc17xx-config.thumb
      target_config_file=.config.thumb1
      ;;
    thumb2)
      runtime_prefix=/thumb2/
      dev_prefix=/thumb2/usr
      multilib_dir=lib
      extra_cflags="-mthumb -march=armv6t2"
      source_config_file=lpc17xx-config.thumb
      target_config_file=.config.thumb2
      ;;
    armv7-m)
      runtime_prefix=/armv7-m/
      dev_prefix=/armv7-m/usr
      multilib_dir=lib
      extra_cflags="-mthumb -march=armv7-m"
      source_config_file=lpc17xx-config.thumb
      target_config_file=.config.armv7-m
      ;;
    armv7e-m)
      runtime_prefix=/armv7e-m/
      dev_prefix=/armv7e-m/usr
      multilib_dir=lib
      extra_cflags="-mthumb -march=armv7e-m"
      source_config_file=lpc17xx-config.thumb
      target_config_file=.config.armv7e-m
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
