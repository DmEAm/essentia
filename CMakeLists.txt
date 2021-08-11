cmake_minimum_required(VERSION 3.18)

project(essentia LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_program(WAF waf ${CMAKE_CURRENT_SOURCE_DIR})

if(WIN32)
    set(CMAKE_SHARED_LIBRARY_PREFIX "")
    set(CMAKE_STATIC_LIBRARY_PREFIX "")

    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

set(WAF_BUILD_BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/build)

add_custom_command(OUTPUT ${WAF_BUILD_BINARY_DIR}
        COMMAND CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER} ${WAF} configure
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "Configure essentia project with waf build system")

add_custom_target(configure ALL
        DEPENDS ${WAF_BUILD_BINARY_DIR}
        COMMENT "Successfully configured ${PROJECT_NAME}")

set(ESSENTIA_LINK_DIR ${WAF_BUILD_BINARY_DIR}/src)
set(ESSENTIA_LIB ${ESSENTIA_LINK_DIR}/libessentia.so)

add_custom_command(OUTPUT ${ESSENTIA_LIB}
        COMMAND ${WAF}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        DEPENDS ${WAF_BUILD_BINARY_DIR}
        COMMENT "Start build ${PROJECT_NAME} lib")

add_custom_target(${PROJECT_NAME} ALL
        DEPENDS ${ESSENTIA_LIB}
        COMMENT "Successfully build ${PROJECT_NAME} package")