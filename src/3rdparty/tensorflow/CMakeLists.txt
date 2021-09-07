cmake_minimum_required(VERSION 3.11)

project(tensorflow VERSION 2.5.0 LANGUAGES C)

include(ExternalProject)

set(TENSORFLOW_URL https://storage.googleapis.com/tensorflow/libtensorflow)
set(TENSORFLOW_VERSION ${CMAKE_PROJECT_VERSION} CACHE STRING "Tensorflow version")

if(WIN32)
    set(TENSORFLOW_URL ${TENSORFLOW_URL}/libtensorflow-cpu-windows-x86_64-${TENSORFLOW_VERSION}.zip)
else()
    set(TENSORFLOW_URL ${TENSORFLOW_URL}/libtensorflow-cpu-linux-x86_64-${TENSORFLOW_VERSION}.tar.gz)
endif()

ExternalProject_Add(TensorflowExternal
    URL ${TENSORFLOW_URL}
    BUILD_ALWAYS OFF
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    UPDATE_COMMAND ""
    INSTALL_COMMAND "")

ExternalProject_Get_property(TensorflowExternal SOURCE_DIR)
set(TENSORFLOW_INCLUDE_DIR ${SOURCE_DIR}/include CACHE INTERNAL "")
set(TENSORFLOW_LINK_DIR ${SOURCE_DIR}/lib CACHE INTERNAL "")

add_library(${PROJECT_NAME} STATIC IMPORTED)

add_dependencies(${PROJECT_NAME} TensorflowExternal)
