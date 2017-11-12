# the name of the target operating system
set(CMAKE_SYSTEM_NAME Linux)

# which architecure to compile for
set(MULTIARCH_TUPLE arm-bcm2708hardfp-linux-gnueabi)

# which system root to use
set(CMAKE_PREFIX_PATH ${CMAKE_SOURCE_DIR}/staging/${MULTIARCH_TUPLE})

# Check for Raspberry Pi Tools or set from defaults if they don't have it
if(DEFINED ENV{PI_TOOLS_HOME})
    message("Using Raspberry Pi Tools set up in $ENV{PI_TOOLS_HOME}")
else(DEFINED ENV{PI_TOOLS_HOME})
    set(ENV{PI_TOOLS_HOME} ${CMAKE_SOURCE_DIR}/raspberrypi/tools)
    message("Using Raspberry Pi Tools expected in $ENV{PI_TOOLS_HOME}")
endif(DEFINED ENV{PI_TOOLS_HOME})

set(TOOLCHAIN_PATH $ENV{PI_TOOLS_HOME}/arm-bcm2708/${MULTIARCH_TUPLE})

# which C and C++ compiler to use
set(CMAKE_C_COMPILER ${TOOLCHAIN_PATH}/bin/${MULTIARCH_TUPLE}-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH}/bin/${MULTIARCH_TUPLE}-g++)

# where the target environment is located
set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN_PATH})

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
