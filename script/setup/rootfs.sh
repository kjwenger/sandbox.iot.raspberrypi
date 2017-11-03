#!/usr/bin/env bash

#set -x

CURRENT_DIR="$(pwd)"
SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$(dirname "${SETUP_DIR}")"
PROJECT_DIR="$(dirname "${SCRIPTS_DIR}")"

cd "${PROJECT_DIR}"
mkdir -p ./raspberrypi/rootfs
sudo mount \
     -v -o offset=48234496 \
     ./image/2017-09-07-raspbian-stretch-lite.img \
     ./raspberrypi/rootfs
cd "${CURRENT_DIR}"
