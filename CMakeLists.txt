cmake_minimum_required(VERSION 2.8.12)
include(CheckCXXCompilerFlag)

project(imagick)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

set (imagick_VERSION_MAJOR 1)
set (imagick_VERSION_MINOR 0)

file(GLOB sources "src/[a-zA-Z]*.c")
file(GLOB private_headers "src/[a-zA-Z]*.h")

include_directories(${imagick_SOURCE_DIR}/src)
include_directories(${LUA_INCDIR})

add_definitions("-Wall")

find_package(ImageMagick COMPONENTS MagickWand MagickCore REQUIRED)

if(APPLE)
    set(CMAKE_SHARED_MODULE_CREATE_C_FLAGS
        "${CMAKE_SHARED_MODULE_CREATE_C_FLAGS} -undefined dynamic_lookup")
endif()

if(WIN32)
    # Win32 modules need to be linked to the Lua library.
    target_link_libraries(imagick ${LUA_LIBDIR})
endif()

add_library(imagick MODULE ${sources})
set_target_properties(imagick PROPERTIES PREFIX "")
if (NOT WIN32)
  set_target_properties(imagick PROPERTIES SUFFIX ".so")
endif ()
target_compile_options(imagick PRIVATE -fopenmp -DMAGICKCORE_HDRI_ENABLE=0 -DMAGICKCORE_QUANTUM_DEPTH=16 -DIMAGICK_VERSION=\"${imagick_VERSION_MAJOR}.${imagick_VERSION_MINOR}\")
target_include_directories(imagick PRIVATE ${ImageMagick_INCLUDE_DIRS})
target_link_libraries(imagick ${ImageMagick_LIBRARIES})

install(TARGETS imagick DESTINATION "${INST_LIBDIR}")

add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/tests/
                   COMMAND rm -rf ${CMAKE_BINARY_DIR}/tests/
                   COMMAND mkdir ${CMAKE_BINARY_DIR}/tests/
                   COMMAND cp ${CMAKE_SOURCE_DIR}/test/luaunit.lua ${CMAKE_BINARY_DIR}/tests/
                   COMMAND cp ${CMAKE_SOURCE_DIR}/test/input.* ${CMAKE_BINARY_DIR}/tests/
                   COMMAND cp ${CMAKE_BINARY_DIR}/imagick.so ${CMAKE_BINARY_DIR}/tests/)

add_custom_target(unittest
                    COMMAND cp ${CMAKE_SOURCE_DIR}/test/test.lua ${CMAKE_BINARY_DIR}/tests/
                    COMMAND ${LUA_COMMAND} test.lua -v
                    DEPENDS ${CMAKE_BINARY_DIR}/tests/
                    DEPENDS imagick
                    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/tests/)
