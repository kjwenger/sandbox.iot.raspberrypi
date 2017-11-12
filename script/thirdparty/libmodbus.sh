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
chmod +x ./autogen.sh
./autogen.sh
chmod +x ./configure
./configure \
    --prefix="${STAGING_DIR}"
make -j ${CPUS}
make -j ${CPUS} install
cd "${CURRENT_DIR}"
