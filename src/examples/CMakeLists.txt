cmake_minimum_required(VERSION 3.14)

project(EssentiaExamples LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_executable(OnSetDetector onset_detector.cpp)

target_link_libraries(OnSetDetector PRIVATE essentia)

include_directories(${ESSENTIA_INCLUDE_DIR})
