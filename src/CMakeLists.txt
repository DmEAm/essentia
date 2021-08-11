project(essentia LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Eigen3 3.3 REQUIRED NO_MODULE)

find_path(AVCODEC_INCLUDE_DIR libavcodec/avcodec.h)
find_library(AVCODEC_LIBRARY avcodec)

add_subdirectory(3rdparty)

file(GLOB_RECURSE SOURCE_FILES ${PROJECT_SOURCE_DIR} essentia/*.cpp)
file(GLOB_RECURSE HEADER_FILES ${PROJECT_SOURCE_DIR} essentia/*.h)

include_directories(
    ${vamp-sdk_SOURCE_DIR}
    ${AVCODEC_INCLUDE_DIR})

include_directories(
    ${PROJECT_SOURCE_DIR}/essentia
    ${PROJECT_SOURCE_DIR}/essentia/utils
    ${PROJECT_SOURCE_DIR}/essentia/streaming
    ${PROJECT_SOURCE_DIR}/essentia/extractor_music
    ${PROJECT_SOURCE_DIR}/essentia/extractor_freesound)

set(PROJECT_SOURCES ${SOURCE_FILES} ${HEADER_FILES})

add_library(${PROJECT_NAME} SHARED ${PROJECT_SOURCES})

target_link_libraries(${PROJECT_NAME} Eigen3::Eigen ${AVCODEC_LIBRARY})
target_include_directories(${PROJECT_NAME} PRIVATE ${AVCODEC_INCLUDE_DIR})
