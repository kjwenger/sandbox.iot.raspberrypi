# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

# which architecure to compile for
set(MULTIARCH_TUPLE armv7-rpi2-linux-gnueabihf)

# which system root to use
set(CMAKE_PREFIX_PATH ${CMAKE_SOURCE_DIR}/staging/${MULTIARCH_TUPLE})

# specify the cross compiler
SET(CMAKE_C_COMPILER   $ENV{HOME}/x-tools/${MULTIARCH_TUPLE}/bin/${MULTIARCH_TUPLE}-gcc)
SET(CMAKE_CXX_COMPILER $ENV{HOME}/x-tools/${MULTIARCH_TUPLE}/bin/${MULTIARCH_TUPLE}-g++)

# where is the target environment
SET(CMAKE_FIND_ROOT_PATH  $ENV{HOME}/x-tools/${MULTIARCH_TUPLE})

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)