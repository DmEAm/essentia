cmake_minimum_required(VERSION 3.11)

project(tensorflow VERSION 2.5.0 LANGUAGES C)

include(ExternalProject)

set(TENSORFLOW_URL https://storage.googleapis.com/tensorflow/libtensorflow)

if(WIN32)
    set(TENSORFLOW_URL ${TENSORFLOW_URL}/libtensorflow-cpu-windows-x86_64-${CMAKE_PROJECT_VERSION}.zip)
else()
    set(TENSORFLOW_URL ${TENSORFLOW_URL}/libtensorflow-cpu-linux-x86_64-${CMAKE_PROJECT_VERSION}.tar.gz)
endif()

ExternalProject_Add(TensorflowExternal
    URL ${TENSORFLOW_URL}
    BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    UPDATE_COMMAND ""
    INSTALL_COMMAND "")

set(TENSORFLOW_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/include CACHE INTERNAL "")
set(TENSORFLOW_LINK_DIR ${CMAKE_CURRENT_BINARY_DIR}/lib CACHE INTERNAL "")

add_library(${PROJECT_NAME} STATIC IMPORTED)
