cmake_minimum_required(VERSION 3.2)
project(sandbox-iot-raspberrypi)

if (NOT DEFINED CMAKE_PREFIX_PATH)
    set(CMAKE_PREFIX_PATH ${CMAKE_SOURCE_DIR}/staging)
endif (NOT DEFINED CMAKE_PREFIX_PATH)

