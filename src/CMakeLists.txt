project(essentia LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(subdirectory_list)

find_package(Eigen3 3.3 REQUIRED NO_MODULE)
find_package(Taglib REQUIRED)
find_package(FFTW REQUIRED)
find_package(samplerate REQUIRED)
find_package(Yaml REQUIRED)
find_package(chromaprint REQUIRED)
find_package(FFmpeg COMPONENTS AVCODEC AVFORMAT AVRESAMPLE AVUTIL REQUIRED)

add_subdirectory(3rdparty)
add_subdirectory(examples)

set(ESSENTIA_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/essentia)
set(ESSENTIA_ALGORITHMS_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/algorithms)

file(GLOB_RECURSE SOURCE_FILES ${ESSENTIA_SOURCE_DIR}/*.cpp ${ESSENTIA_ALGORITHMS_SOURCE_DIR}/*.cpp)
file(GLOB_RECURSE HEADER_FILES ${ESSENTIA_SOURCE_DIR}/*.h ${ESSENTIA_ALGORITHMS_SOURCE_DIR}/*.h)

list(FILTER SOURCE_FILES EXCLUDE REGEX "gaia.*")
list(FILTER HEADER_FILES EXCLUDE REGEX "gaia.*")

if(NOT APPLE)
    list(FILTER SOURCE_FILES EXCLUDE REGEX ".*fft[ka].*")
    list(FILTER HEADER_FILES EXCLUDE REGEX ".*ffta[ka].*")
endif()

subdirectory_list(INCLUDE_DIRS ${ESSENTIA_SOURCE_DIR} RECURSIVE)
list(APPEND INCLUDE_DIRS ${ESSENTIA_SOURCE_DIR})

include_directories(${INCLUDE_DIRS})

set(PROJECT_SOURCES ${SOURCE_FILES} ${HEADER_FILES})

add_library(${PROJECT_NAME} SHARED ${PROJECT_SOURCES})

add_dependencies(${PROJECT_NAME} TensorflowExternal)

target_include_directories(${PROJECT_NAME} PRIVATE
        ${CHROMAPRINT_INCLUDE_DIR}
        ${SAMPLERATE_INCLUDE_DIR}
        ${YAML_INCLUDES}
        ${FFTW_INCLUDE_DIRS}
        ${TAGLIB_INCLUDES}
        ${vamp-sdk_SOURCE_DIR}
        ${TENSORFLOW_INCLUDE_DIR}
        ${spline_SOURCE_DIR}
        ${nnls_SOURCE_DIR}
        ${FFMPEG_INCLUDE_DIRS})

target_link_libraries(${PROJECT_NAME}
        tensorflow
        nnls
        spline
        cephes
        Eigen3::Eigen
        ${SAMPLERATE_LIBRARY}
        ${CHROMAPRINT_LIBRARIES}
        ${FFMPEG_LIBRARIES}
        ${TAGLIB_LIBRARIES}
        ${FFTW_LIBRARIES}
        ${YAML_LIBRARIES})

target_link_directories(${PROJECT_NAME} PUBLIC ${TENSORFLOW_LINK_DIR} ${CMAKE_LIBRARY_PATH})
