cmake_minimum_required(VERSION 3.2)
project(sandbox-iot-raspberrypi)

if (NOT DEFINED CMAKE_PREFIX_PATH)
    set(CMAKE_PREFIX_PATH ${CMAKE_SOURCE_DIR}/staging)
endif (NOT DEFINED CMAKE_PREFIX_PATH)

include(ExternalProject)

ExternalProject_Add(libmodbus
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libmodbus
        CONFIGURE_COMMAND cd ${CMAKE_CURRENT_SOURCE_DIR}/libmodbus && ./autogen.sh && ./configure --prefix=${CMAKE_PREFIX_PATH}
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        INSTALL_DIR ${CMAKE_PREFIX_PATH}
)

ExternalProject_Add(openssl
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/openssl
        CONFIGURE_COMMAND cd ${CMAKE_CURRENT_SOURCE_DIR}/openssl && ./config --prefix=${CMAKE_PREFIX_PATH}
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        INSTALL_DIR ${CMAKE_PREFIX_PATH}
)

set(CMAKE_ARGS -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH} -DCMAKE_INSTALL_PREFIX=${CMAKE_PREFIX_PATH} -DOPENSSL_ROOT_DIR=${CMAKE_PREFIX_PATH})
set(ENV{OPENSSL_ROOT_DIR} ${CMAKE_PREFIX_PATH})
if(CMAKE_TOOLCHAIN_FILE)
    set(CMAKE_ARGS ${CMAKE_ARGS} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE})
endif(CMAKE_TOOLCHAIN_FILE)

ExternalProject_Add(mosquitto
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mosquitto
        CMAKE_ARGS ${CMAKE_ARGS}
        BUILD_COMMAND make
        INSTALL_COMMAND make install || true
        INSTALL_DIR ${CMAKE_PREFIX_PATH}
)
