cmake_minimum_required(VERSION 3.14)

project(Essentia LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

find_program(WAF waf ${CMAKE_CURRENT_SOURCE_DIR})

find_package(Python2 COMPONENTS Interpreter REQUIRED)

set(ESSENTIA_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include CACHE INTERNAL "")

file(GLOB_RECURSE HEADER_FILES src/essentia/*.h src/algorithms/*.h src/version.h)

file(GLOB UTILS_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} src/essentia/utils/*)
file(GLOB ALGORITHMS_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} src/essentia/streaming/algorithms/*)
file(GLOB STREAMING_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} src/essentia/streaming/*)

file(COPY ${HEADER_FILES} DESTINATION ${ESSENTIA_INCLUDE_DIR})
file(COPY ${UTILS_FILES} DESTINATION ${ESSENTIA_INCLUDE_DIR}/utils)
file(COPY ${ALGORITHMS_FILES} DESTINATION ${ESSENTIA_INCLUDE_DIR}/algorithms)
file(COPY ${STREAMING_FILES} DESTINATION ${ESSENTIA_INCLUDE_DIR}/streaming)

if(WIN32)
    set(CMAKE_SHARED_LIBRARY_PREFIX "")
    set(CMAKE_STATIC_LIBRARY_PREFIX "")

    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

add_subdirectory(src)

set(WAF_BUILD_BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/build)

string(TOLOWER ${CMAKE_BUILD_TYPE} BUILD_TYPE)
add_custom_command(OUTPUT ${WAF_BUILD_BINARY_DIR}
        COMMAND ${Python2_EXECUTABLE} ${WAF} -j 2 configure --fft --mode=${BUILD_TYPE}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "Configure essentia project with waf build system")

add_custom_target(Configure${PROJECT_NAME} ALL
        DEPENDS ${WAF_BUILD_BINARY_DIR}
        COMMENT "Successfully configured ${PROJECT_NAME}")

add_dependencies(essentia Configure${PROJECT_NAME})