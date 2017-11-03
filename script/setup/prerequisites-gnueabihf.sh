#!/usr/bin/env bash

# Get latest packages
sudo apt update

# Get development tools
sudo apt install build-essential -y
sudo apt install gcc-4.9-arm-linux-gnueabihf -y
sudo apt install g++-4.9-arm-linux-gnueabihf -y
sudo apt install gcc-arm-linux-gnueabihf -y
sudo apt install g++-arm-linux-gnueabihf -y
sudo apt install pkg-config-arm-linux-gnueabihf -y
sudo apt install gdb-multiarch -y
sudo apt install lib32z1 -y
