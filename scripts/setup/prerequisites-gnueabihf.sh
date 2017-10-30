#!/usr/bin/env bash

# Get latest packages
sudo apt update

# Get development tools
sudo apt-get install build-essential -y
sudo apt-get install g++-arm-linux-gnueabihf -y
sudo apt-get install gdb-multiarch -y
