#!/usr/bin/env bash

set -x

CMAKE_PROJECT_DIR="/com.u14n/development/projects/sandbox/sandbox.iot/sandbox.iot.raspberrypi"
MULTIARCH_TUPLE="armv7-rpi2-linux-gnueabihf"
STAGING_DIR="${CMAKE_PROJECT_DIR}/staging/${MULTIARCH_TUPLE}"

mkdir -p build
pushd build
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
      -DCMAKE_TOOLCHAIN_FILE="${CMAKE_PROJECT_DIR}/toolchains/armv7-rpi2-linux-gnueabihf.cmake" \
      .. \
      1>.log 2>&1
popd
