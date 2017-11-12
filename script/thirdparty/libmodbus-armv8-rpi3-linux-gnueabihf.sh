#!/usr/bin/env bash

#set -x

CPUS=$(lscpu | grep "^CPU(s):" | sed s/"CPU(s):                "//)

CURRENT_DIR="$(pwd)"
THIRDPARTY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$(dirname "${THIRDPARTY_DIR}")"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"
STAGING_DIR="${PROJECT_DIR}/staging"
LIBMODBUS_DIR="${PROJECT_DIR}/thirdparty/libmodbus"

cd "${LIBMODBUS_DIR}"
make -j ${CPUS} distclean
export MULTIARCH_TUPLE="armv8-rpi3-linux-gnueabihf"
export SYSROOT="${HOME}/x-tools/${MULTIARCH_TUPLE}"
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
    --prefix="${STAGING_DIR}/${MULTIARCH_TUPLE}"
make -j ${CPUS}
make -j ${CPUS} install
cd "${CURRENT_DIR}"
