if(NOT PKG_CONFIG_FOUND)
    find_package(PkgConfig QUIET)
else()
    pkg_search_module(PC_CHROMAPRINT QUIET chromaprint)
endif()

find_path(CHROMAPRINT_INCLUDE_DIR "chromaprint.h"
        HINTS ${PC_CHROMAPRINT_INCLUDE_DIRS})

find_library(CHROMAPRINT_LIBRARIES chromaprint
        HINTS ${CHROMAPRINT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
        PATH_SUFFIXES lib)

if(PC_CHROMAPRINT_VERSION)
    set(CHROMAPRINT_VERSION "${PC_CHROMAPRINT_VERSION}")
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(chromaprint
        FOUND_VAR CHROMAPRINT_FOUND
        REQUIRED_VARS CHROMAPRINT_INCLUDE_DIR CHROMAPRINT_LIBRARIES
        VERSION_VAR CHROMAPRINT_VERSION)

if(CHROMAPRINT_FOUND)
    add_library(chromaprint::chromaprint UNKNOWN IMPORTED)
    set_target_properties(chromaprint::chromaprint PROPERTIES
            INTERFACE_COMPILE_OPTIONS "${PC_CHROMAPRINT_CFLAGS_OTHER}"
            INTERFACE_INCLUDE_DIRECTORIES "${CHROMAPRINT_INCLUDE_DIR}"
            IMPORTED_LOCATION "${CHROMAPRINT_LIBRARY}")
else()
    if (chromaprint_FIND_REQUIRED)
        message (FATAL_ERROR "Could not find chromaprint!")
    endif()
endif()

