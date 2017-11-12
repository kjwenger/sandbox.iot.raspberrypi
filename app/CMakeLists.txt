cmake_minimum_required(VERSION 3.2)
project(sandbox-iot-raspberrypi)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-rpath -Wl,-rpath-link")

if (NOT DEFINED CMAKE_PREFIX_PATH)
    set(CMAKE_PREFIX_PATH ${CMAKE_SOURCE_DIR}/staging)
endif (NOT DEFINED CMAKE_PREFIX_PATH)

find_package(OpenSSL)

set(MOSQUITTO_INCLUDE_DIRS ${CMAKE_PREFIX_PATH}/include)
set(MOSQUITTO_LIBRARY ${CMAKE_PREFIX_PATH}/lib/libmosquitto.so)

set(MOSQUITTOPP_INCLUDE_DIRS ${CMAKE_PREFIX_PATH}/include)
set(MOSQUITTOPP_LIBRARY ${CMAKE_PREFIX_PATH}/lib/libmosquittopp.so)

file(GLOB INCLUDE
        include/*.hpp
)
file(GLOB SRC
        src/*.cpp
)
add_executable(sandbox-iot-raspberrypi
        ${INCLUDE}
        ${SRC}
)
add_dependencies(sandbox-iot-raspberrypi
        ${MOSQUITTOPP_INCLUDE_DIRS}
        ${MOSQUITTO_INCLUDE_DIRS}
)
include_directories(
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${MOSQUITTOPP_INCLUDE_DIRS}
        ${MOSQUITTO_INCLUDE_DIRS}
        ${CMAKE_PREFIX_PATH}/local/include
        ${CMAKE_PREFIX_PATH}/include
        /usr/local/include
        /usr/include/jsoncpp
        /usr/include
)
find_package(Threads)
target_link_libraries(sandbox-iot-raspberrypi
        ${MOSQUITTOPP_LIBRARY}
        ${MOSQUITTO_LIBRARY}
        ${CMAKE_THREAD_LIBS_INIT}
)
