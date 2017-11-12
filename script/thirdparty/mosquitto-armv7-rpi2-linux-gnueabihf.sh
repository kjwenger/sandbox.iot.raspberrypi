#!/usr/bin/env bash

#set -x

CPUS=$(lscpu | grep "^CPU(s):" | sed s/"CPU(s):                "//)

MULTIARCH_TUPLE="armv7-rpi2-linux-gnueabihf"

CURRENT_DIR="$(pwd)"
THIRDPARTY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$(dirname "${THIRDPARTY_DIR}")"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"
STAGING_DIR="${PROJECT_DIR}/staging/${MULTIARCH_TUPLE}"
MOSQUITTO_DIR="${PROJECT_DIR}/thirdparty/mosquitto"
SYSROOT="${HOME}/x-tools/${MULTIARCH_TUPLE}"

cd "${MOSQUITTO_DIR}"
mkdir -p "build-${MULTIARCH_TUPLE}"
pushd "build-${MULTIARCH_TUPLE}"
rm -Rf *
cmake \
      -DOPENSSL_ROOT_DIR="${STAGING_DIR}" \
      -DOPENSSL_FOUND=true \
      -DOPENSSL_INCLUDE_DIR="${STAGING_DIR}/include" \
      -DOPENSSL_CRYPTO_LIBRARY="${STAGING_DIR}/lib/libcrypto.so" \
      -DOPENSSL_CRYPTO_LIBRARIES="${STAGING_DIR}/lib/libcrypto.so" \
      -DOPENSSL_SSL_LIBRARY="${STAGING_DIR}/lib/libssl.so" \
      -DOPENSSL_SSL_LIBRARIES="${STAGING_DIR}/lib/libssl.so" \
      -DOPENSSL_LIBRARIES="${STAGING_DIR}/lib/libcrypto.so;${STAGING_DIR}/lib/libssl.so" \
      -DCMAKE_LIBRARY_ARCHITECTURE="${MULTIARCH_TUPLE}" \
      -DCMAKE_TOOLCHAIN_FILE="${PROJECT_DIR}/toolchains/${MULTIARCH_TUPLE}.cmake" \
      -DCMAKE_PREFIX_PATH="${STAGING_DIR}" \
      -DCMAKE_INSTALL_PREFIX="${STAGING_DIR}" \
      ..
make -j ${CPUS}
make -j ${CPUS} install
popd
cd "${CURRENT_DIR}"

#      -C"${PROJECT_DIR}/cache.cmake" \
