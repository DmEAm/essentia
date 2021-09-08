cmake_minimum_required(VERSION 3.11)

project(EssentiaDependencies)

include(ExternalProject)

set(TAGLIB_VERSION 1.12 CACHE STRING "Taglib version")
set(TAGLIB_URL https://taglib.org/releases/taglib-${TAGLIB_VERSION}.tar.gz)
ExternalProject_Add(Taglib URL ${TAGLIB_URL})

set(EIGEN_VERSION 3.4.0 CACHE STRING "Eigen version")
set(EIGEN_URL https://gitlab.com/libeigen/eigen/-/archive/${EIGEN_VERSION}/eigen-${EIGEN_VERSION}.zip)
ExternalProject_Add(Eigen3 URL ${EIGEN_URL})

set(FFTW_VERSION 3.3.9 CACHE STRING "FFTW version")
set(FFTW_URL http://www.fftw.org/fftw-${FFTW_VERSION}.tar.gz)
ExternalProject_Add(FFTW URL ${FFTW_URL})

set(SAMPLERATE_VERSION 0.2.2 CACHE STRING "Samplerate version")
set(SAMPLERATE_URL https://github.com/libsndfile/libsamplerate/archive/refs/tags/${SAMPLERATE_VERSION}.zip)
ExternalProject_Add(Samplerate URL ${SAMPLERATE_URL})

find_program(BASH_PROGRAM NAMES bash)
set(FFMPEG_VERSION 3.4.8 CACHE STRING "FFmpeg version")
set(FFMPEG_URL https://www.ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.xz)
set(FFMPEG_SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/ffmpeg)

message(STATUS "${BASH_PROGRAM} ${FFMPEG_SOURCE_DIR}/configure --cc=${CMAKE_C_COMPILER} --cxx=${CMAKE_CXX_COMPILER} --disable-x86asm")
ExternalProject_Add(FFmpeg
    URL ${FFMPEG_URL}
    SOURCE_DIR ${FFMPEG_SOURCE_DIR}
    CONFIGURE_COMMAND ${BASH_PROGRAM} ${FFMPEG_SOURCE_DIR}/configure --cc=${CMAKE_C_COMPILER} --cxx=${CMAKE_CXX_COMPILER} --disable-x86asm
    BUILD_COMMAND ${CMAKE_MAKE_PROGRAM}
    INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} install)

message(STATUS ${SOURCE_DIR})

