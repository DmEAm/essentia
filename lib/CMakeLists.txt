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
set(LIBAV_VERSION 12.3 CACHE STRING "FFmpeg version")
set(LIBAV_URL https://libav.org/releases/libav-${LIBAV_VERSION}.tar.xz)
ExternalProject_Add(Av URL ${LIBAV_URL}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND "")

set(YAML_VERSION 0.2.5 CACHE STRING "Yaml version")
set(YAML_URL https://github.com/yaml/libyaml)
ExternalProject_Add(Yaml GIT_REPOSITORY ${YAML_URL} GIT_PROGRESS ON GIT_TAG ${YAML_VERSION})

set(CHROMAPRINT_VERSION v1.5.0 CACHE STRING "Chromaprint version")
set(CHROMAPRINT_URL https://github.com/acoustid/chromaprint.git)
ExternalProject_Add(Chromaprint GIT_REPOSITORY ${CHROMAPRINT_URL} GIT_PROGRESS ON GIT_TAG ${CHROMAPRINT_VERSION})
