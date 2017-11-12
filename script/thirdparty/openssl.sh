#!/usr/bin/env bash

#set -x

CPUS=$(lscpu | grep "^CPU(s):" | sed s/"CPU(s):                "//)

CURRENT_DIR="$(pwd)"
THIRDPARTY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$(dirname "${THIRDPARTY_DIR}")"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"
STAGING_DIR="${PROJECT_DIR}/staging"
OPENSSL_DIR="${PROJECT_DIR}/thirdparty/openssl"

cd "${OPENSSL_DIR}"
./config \
    --prefix="${STAGING_DIR}"
make -j ${CPUS}
make -j ${CPUS} install
cd "${CURRENT_DIR}"
