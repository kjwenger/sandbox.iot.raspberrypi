#!/usr/bin/env bash

#set -x

CPUS=$(lscpu | grep "^CPU(s):" | sed s/"CPU(s):                "//)

CURRENT_DIR="$(pwd)"
THIRDPARTY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$(dirname "${THIRDPARTY_DIR}")"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"
USR_DIR="${PROJECT_DIR}/usr"
LIBMODBUS_DIR="${PROJECT_DIR}/thirdparty/libmodbus"

cd "${LIBMODBUS_DIR}"
make -j ${CPUS} distclean
export MULTIARCH_TUPLE="arm-bcm2708hardfp-linux-gnueabi"
export SYSROOT="${PROJECT_DIR}/raspberrypi/tools/arm-bcm2708/${MULTIARCH_TUPLE}"
export CC="${SYSROOT}/bin/${MULTIARCH_TUPLE}-gcc"
export LD="${SYSROOT}/bin/${MULTIARCH_TUPLE}-ld"
export AS="${SYSROOT}/bin/${MULTIARCH_TUPLE}-as"
chmod +x ./autogen.sh
./autogen.sh
chmod +x ./configure
ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes \
./configure \
    --with-sysroot="${HOME}/x-tools/${MULTIARCH_TUPLE}" \
    --host="${MULTIARCH_TUPLE}" \
    --prefix="${USR_DIR}/${MULTIARCH_TUPLE}"
make -j ${CPUS}
make -j ${CPUS} install
cd "${CURRENT_DIR}"
