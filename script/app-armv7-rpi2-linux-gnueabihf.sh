#!/usr/bin/env bash

#set -x

CPUS=$(lscpu | grep "^CPU(s):" | sed s/"CPU(s):                "//)

MULTIARCH_TUPLE="armv7-rpi2-linux-gnueabihf"

CURRENT_DIR="$(pwd)"
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"
STAGING_DIR="${PROJECT_DIR}/staging/${MULTIARCH_TUPLE}"
BUILD_DIR="${PROJECT_DIR}/build-${MULTIARCH_TUPLE}"

cd "${PROJECT_DIR}"
mkdir -p "${BUILD_DIR}"
pushd "${BUILD_DIR}"
rm -Rf *
cmake \
      -DMODBUS_INCLUDE_DIR="${STAGING_DIR}/include" \
      -DMODBUS_LIBRARIES="${STAGING_DIR}/lib/libmodbus.so" \
      -DOPENSSL_ROOT_DIR="${STAGING_DIR}" \
      -DOPENSSL_FOUND=true \
      -DOPENSSL_INCLUDE_DIR="${STAGING_DIR}/include" \
      -DOPENSSL_CRYPTO_LIBRARY="${STAGING_DIR}/lib/libcrypto.so" \
      -DOPENSSL_CRYPTO_LIBRARIES="${STAGING_DIR}/lib/libcrypto.so" \
      -DOPENSSL_SSL_LIBRARY="${STAGING_DIR}/lib/libssl.so" \
      -DOPENSSL_SSL_LIBRARIES="${STAGING_DIR}/lib/libssl.so" \
      -DOPENSSL_LIBRARIES="${STAGING_DIR}/lib/libcrypto.so;${STAGING_DIR}/lib/libssl.so" \
      -DMOSQUITTO_INCLUDE_DIR="${STAGING_DIR}/include" \
      -DMOSQUITTO_LIBRARY="${STAGING_DIR}/lib/libmosquitto.so" \
      -DMOSQUITTOPP_INCLUDE_DIR="${STAGING_DIR}/include" \
      -DMOSQUITTOPP_LIBRARY="${STAGING_DIR}/lib/libmosquittopp.so" \
      -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
      -DCMAKE_TOOLCHAIN_FILE="${PROJECT_DIR}/toolchains/${MULTIARCH_TUPLE}.cmake" \
      -DCMAKE_INSTALL_PREFIX="${STAGING_DIR}" \
      -DCMAKE_EXE_LINKER_FLAGS="-Wl,-rpath-link ${STAGING_DIR}/lib" \
      ..
make -j ${CPUS}
popd
cd "${CURRENT_DIR}"
