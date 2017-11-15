#!/usr/bin/env bash

# Get latest packages
sudo apt update

# Get network tools
sudo apt install curl -y
sudo apt install wget -y

# Get version control tools
sudo apt install git -y
sudo apt install subversion -y

# Get development tools
sudo apt install build-essential -y
sudo apt install gcc -y
sudo apt install g++ -y
sudo apt install cmake -y
sudo apt install cppcheck -y
sudo apt install autotools-dev -y
sudo apt install autoconf -y
sudo apt install libtool -y
sudo apt install libpam0g-dev -y

sudo apt install clang-3.9 -y
sudo apt install clang-3.9-doc -y
sudo apt install clang-3.9-examples -y
sudo apt install clang-format-3.9 -y
sudo apt install clang-tidy-3.9 -y

# Get thirdparty prerequisites
sudo apt install libmodbus-dev -y
sudo apt install libmodbus5 -y
sudo apt install libssl1.0-dev -y
sudo apt install libssl-dev -y
sudo apt install libmosquitto-dev -y
sudo apt install libmosquitto1 -y
sudo apt install libmosquittopp-dev -y
sudo apt install libmosquittopp1 -y
sudo apt install mosquitto-dev -y
sudo apt install mosquitto -y
sudo apt install mosquitto-clients -y

# Get test prerequisites
sudo apt install libcurl4-openssl-dev -y
sudo apt install libjsoncpp-dev -y
sudo apt install libjsoncpp1 -y
