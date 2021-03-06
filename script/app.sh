#!/usr/bin/env bash

#set -x

CPUS=$(lscpu | grep "^CPU(s):" | sed s/"CPU(s):                "//)

CURRENT_DIR="$(pwd)"
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"
STAGING_DIR="${PROJECT_DIR}/staging"

cd "${PROJECT_DIR}"
mkdir -p build
pushd build
rm -Rf *
cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
      ..
make -j ${CPUS}
popd
cd "${CURRENT_DIR}"
