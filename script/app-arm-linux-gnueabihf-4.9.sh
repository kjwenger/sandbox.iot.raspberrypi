#!/usr/bin/env bash

#set -x

CPUS=$(lscpu | grep "^CPU(s):" | sed s/"CPU(s):                "//)

MULTIARCH_TUPLE="arm-linux-gnueabihf"

CURRENT_DIR="$(pwd)"
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"
USR_DIR="${PROJECT_DIR}/usr"
BUILD_DIR="${PROJECT_DIR}/build-${MULTIARCH_TUPLE}"

cd "${PROJECT_DIR}"
mkdir -p "${BUILD_DIR}"
pushd "${BUILD_DIR}"
cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
      -DCMAKE_TOOLCHAIN_FILE="${PROJECT_DIR}/toolchains/${MULTIARCH_TUPLE}-4.9.cmake" \
      -DCMAKE_INSTALL_PREFIX="${USR_DIR}/${MULTIARCH_TUPLE}" \
      ..
make -j ${CPUS}
popd
cd "${CURRENT_DIR}"
