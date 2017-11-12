#!/usr/bin/env bash

pushd mbpoll/

mkdir build
cd build/
cmake \
      ..
make
sudo make install
cd -

mkdir build-armv7-rpi2-linux-gnueabihf
cd build-armv7-rpi2-linux-gnueabihf/
cmake \
      -DCMAKE_TOOLCHAIN_FILE="../../toolchains/armv7-rpi2-linux-gnueabihf.cmake" \
      -DCMAKE_INSTALL_PREFIX="../../usr/armv7-rpi2-linux-gnueabihf" \
      ..
make
sshpass -p raspberry scp mbpoll pi@raspberrypi:/home/pi
cd -

popd