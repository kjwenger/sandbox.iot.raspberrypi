#!/usr/bin/env bash

set -x

CPUS=$(lscpu | grep "^CPU(s):" | sed s/"CPU(s):                "//)

CURRENT_DIR="$(pwd)"
THIRDPARTY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$(dirname "${THIRDPARTY_DIR}")"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"
STAGING_DIR="${PROJECT_DIR}/staging"
OPENSSL_DIR="${PROJECT_DIR}/thirdparty/openssl"

cd "${OPENSSL_DIR}"
make -j ${CPUS} distclean
export MULTIARCH_TUPLE="armv7-rpi2-linux-gnueabihf"
export SYSROOT="${HOME}/x-tools/${MULTIARCH_TUPLE}"
export INSTALLDIR="${STAGING_DIR}/${MULTIARCH_TUPLE}"
export TARGETMACH="${MULTIARCH_TUPLE}"
export BUILDMACH="`gcc -dumpmachine`"
export CROSS=arm-none-linux-gnueabi
export CC="${SYSROOT}/bin/${MULTIARCH_TUPLE}-gcc"
export CXX="${SYSROOT}/bin/${MULTIARCH_TUPLE}-g++"
export LD="${SYSROOT}/bin/${MULTIARCH_TUPLE}-ld"
export AS="${SYSROOT}/bin/${MULTIARCH_TUPLE}-as"
export AR="${SYSROOT}/bin/${MULTIARCH_TUPLE}-ar"
./Configure \
    --prefix="${STAGING_DIR}/${MULTIARCH_TUPLE}" \
    "linux-generic32"
make -j ${CPUS}
make -j ${CPUS} install
cd "${CURRENT_DIR}"

#    --cross-compile-prefix="${MULTIARCH_TUPLE}" \
