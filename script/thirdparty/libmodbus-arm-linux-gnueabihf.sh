#!/usr/bin/env bash

set -x

CPUS=$(lscpu | grep "^CPU(s):" | sed s/"CPU(s):                "//)

CURRENT_DIR="$(pwd)"
THIRDPARTY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$(dirname "${THIRDPARTY_DIR}")"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"
USR_DIR="${PROJECT_DIR}/usr"
LIBMODBUS_DIR="${PROJECT_DIR}/thirdparty/libmodbus"

cd "${LIBMODBUS_DIR}"
make -j ${CPUS} distclean
export CROSS=arm-linux-gnueabihf
export CC="${CROSS}-gcc"
export LD="${CROSS}-ld"
export AS="${CROSS}-as"
chmod +x ./autogen.sh
./autogen.sh
chmod +x ./configure
./configure --prefix="${USR_DIR}/arm-linux-gnueabihf"
make -j ${CPUS}
make -j ${CPUS} install
cd "${CURRENT_DIR}"
