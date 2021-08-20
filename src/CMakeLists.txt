project(essentia LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Eigen3 3.3 REQUIRED NO_MODULE)
find_package(Taglib )
find_package(FFTW REQUIRED)
find_package(samplerate REQUIRED)

find_path(AVCODEC_INCLUDE_DIR libavcodec/avcodec.h)

find_library(AVCODEC_LIBRARY avcodec REQUIRED)
find_library(AVFORMAT_LIBRARY avformat REQUIRED)
find_library(AVRESAMPLE_LIBRARY avresample REQUIRED)

find_library(YAML_LIBRARY yaml REQUIRED)
find_package(yaml-cpp)

set(AV_LIBRARIES ${AVCODEC_LIBRARY} ${AVFORMAT_LIBRARY} ${AVRESAMPLE_LIBRARY})

add_subdirectory(3rdparty)
include_directories(3rdparty)
#add_subdirectory(algorithms)

file(GLOB_RECURSE SOURCE_FILES ${PROJECT_SOURCE_DIR} essentia/*.cpp algorithms/*.cpp)
file(GLOB_RECURSE HEADER_FILES ${PROJECT_SOURCE_DIR} essentia/*.h algorithms/*.h)

list(FILTER SOURCE_FILES EXCLUDE REGEX "gaia.*")
list(FILTER HEADER_FILES EXCLUDE REGEX "gaia.*")

if(NOT APPLE)
    list(FILTER SOURCE_FILES EXCLUDE REGEX ".*fft[ka].*")
    list(FILTER HEADER_FILES EXCLUDE REGEX ".*ffta[ka].*")
endif()

include_directories(
    ${FFTW_INCLUDE_DIRS}
    ${TAGLIB_INCLUDES}
    ${vamp-sdk_SOURCE_DIR}
    ${tensorflow_SOURCE_DIR}
    ${spline_SOURCE_DIR}
    ${nnls_SOURCE_DIR}
    ${AVCODEC_INCLUDE_DIR})

include_directories(
    ${PROJECT_SOURCE_DIR}/essentia
    ${PROJECT_SOURCE_DIR}/essentia/scheduler
    ${PROJECT_SOURCE_DIR}/essentia/utils
    ${PROJECT_SOURCE_DIR}/essentia/streaming
    ${PROJECT_SOURCE_DIR}/essentia/streaming/algorithms
    ${PROJECT_SOURCE_DIR}/essentia/streaming/algorithms/standard
    ${PROJECT_SOURCE_DIR}/essentia/extractor_music
    ${PROJECT_SOURCE_DIR}/essentia/extractor_freesound)

set(PROJECT_SOURCES ${SOURCE_FILES} ${HEADER_FILES})

add_library(${PROJECT_NAME} SHARED ${PROJECT_SOURCES})

add_dependencies(${PROJECT_NAME} TensorflowExternal)

target_link_libraries(${PROJECT_NAME}
        tensorflow
        nnls
        spline
        cephes
        Eigen3::Eigen
        samplerate::samplerate
        ${AV_LIBRARIES}
        ${YAML_CPP_LIBRARIES}
        ${TAGLIB_LIBRARIES}
        ${FFTW_LIBRARIES}
        ${YAML_LIBRARY})

target_link_directories(${PROJECT_NAME} PUBLIC ${TENSORFLOW_LINK_DIR})
target_include_directories(${PROJECT_NAME} PRIVATE ${AVCODEC_INCLUDE_DIR})
