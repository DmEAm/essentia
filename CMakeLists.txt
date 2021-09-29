cmake_minimum_required(VERSION 3.14)

project(Essentia LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules)

find_program(WAF waf ${CMAKE_CURRENT_SOURCE_DIR})

find_package(Python2 COMPONENTS Interpreter REQUIRED)

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

install(TARGETS essentia nnls spline cephes
        EXPORT essentiaLibraryDepends
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

set(PREFIX ${essentia_INSTALL_PREFIX})
set(VERSION ${essentia_VERSION})

set(exec_prefix ${CMAKE_INSTALL_PREFIX})
set(libdir ${CMAKE_INSTALL_FULL_LIBDIR})
set(includedir ${CMAKE_INSTALL_FULL_INCLUDEDIR})

configure_file(essentia.pc.in essentia.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/essentia.pc
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
        COMPONENT Development)

set(ESSENTIA_LIBRARIES "essentia::essentia")
configure_file(essentiaConfig.cmake.in essentiaConfig.cmake @ONLY)
configure_file(essentiaConfigVersion.cmake.in essentiaConfigVersion.cmake @ONLY)
install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/essentiaConfig.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/essentiaConfigVersion.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/essentia
        COMPONENT Development)

export(TARGETS essentia nnls spline cephes NAMESPACE essentia:: FILE ${PROJECT_BINARY_DIR}/essentiaLibraryDepends.cmake)
install(EXPORT essentiaLibraryDepends
        NAMESPACE essentia::
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/essentia
        COMPONENT Development)

set(ESSENTIA_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include CACHE STRING "Essentia include dir")

install(FILES src/version.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(DIRECTORY src/essentia
        DESTINATION include
        FILES_MATCHING PATTERN "*.h")
install(DIRECTORY src/essentia/utils
        DESTINATION include/essentia
        FILES_MATCHING PATTERN "*.h")
install(DIRECTORY src/essentia/streaming
        DESTINATION include/essentia
        FILES_MATCHING PATTERN "*.h")
