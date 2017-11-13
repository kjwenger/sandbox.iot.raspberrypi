cmake_minimum_required(VERSION 3.2)
project(sandbox-iot-raspberrypi)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

if (NOT DEFINED CMAKE_PREFIX_PATH)
    set(CMAKE_PREFIX_PATH ${CMAKE_SOURCE_DIR}/staging)
endif (NOT DEFINED CMAKE_PREFIX_PATH)

#add_subdirectory(thirdparty)

add_subdirectory(sample)

#add_subdirectory(test)

add_subdirectory(app)
