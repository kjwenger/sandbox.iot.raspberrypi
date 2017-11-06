cmake_minimum_required(VERSION 2.6)
project(sandbox-iot-raspberrypi)

if (NOT DEFINED CMAKE_PREFIX_PATH)
    set(CMAKE_PREFIX_PATH ${CMAKE_SOURCE_DIR}/usr)
endif (NOT DEFINED CMAKE_PREFIX_PATH)

include(ExternalProject)
ExternalProject_Add(libmodbus
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libmodbus
        CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/libmodbus/configure --prefix=${CMAKE_PREFIX_PATH}
        BUILD_COMMAND ${MAKE}
)