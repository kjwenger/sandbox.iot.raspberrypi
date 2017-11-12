#!/usr/bin/env bash

#set -x

CPUS=$(lscpu | grep "^CPU(s):" | sed s/"CPU(s):                "//)

CURRENT_DIR="$(pwd)"
THIRDPARTY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$(dirname "${THIRDPARTY_DIR}")"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"
STAGING_DIR="${PROJECT_DIR}/staging"
MOSQUITTO_DIR="${PROJECT_DIR}/thirdparty/mosquitto"
export OPENSSL_ROOT_DIR="${STAGING_DIR}"

cd "${MOSQUITTO_DIR}"
mkdir -p build
pushd build
cmake \
      -DOPENSSL_ROOT_DIR="${STAGING_DIR}" \
      -DCMAKE_PREFIX_PATH="${STAGING_DIR}" \
      -DCMAKE_INSTALL_PREFIX="${STAGING_DIR}" \
      ..
make -j ${CPUS}
make -j ${CPUS} install
popd
cd "${CURRENT_DIR}"
