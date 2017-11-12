cmake_minimum_required(VERSION 3.2)
project(sandbox-iot-raspberrypi)

message(STATUS "................................................................................")
get_cmake_property(_variableNames VARIABLES)
foreach (_variableName ${_variableNames})
    message(STATUS "${_variableName}=${${_variableName}}")
endforeach()
message(STATUS "................................................................................")

find_package(OpenSSL REQUIRED)

message(STATUS "--------------------------------------------------------------------------------")
get_cmake_property(_variableNames VARIABLES)
foreach (_variableName ${_variableNames})
    message(STATUS "${_variableName}=${${_variableName}}")
endforeach()
message(STATUS "--------------------------------------------------------------------------------")
