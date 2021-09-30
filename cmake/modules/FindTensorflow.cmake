# - Check for the presence of TENSORFLOW
#
# The following variables are set when TENSORFLOW is found:
#  TENSORFLOW_FOUND      = Set to true, if all components of TENSORFLOW have been found.
#  TENSORFLOW_INCLUDES   = Include path for the header files of TENSORFLOW
#  TENSORFLOW_LIBRARIES  = Link these to use TENSORFLOW
#  TENSORFLOW_LFLAGS     = Linker flags (optional)

if (NOT TENSORFLOW_FOUND)

    if (NOT TENSORFLOW_ROOT_DIR)
        set (TENSORFLOW_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
    endif (NOT TENSORFLOW_ROOT_DIR)

    find_path (TENSORFLOW_INCLUDES tensorflow
            HINTS ${TENSORFLOW_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
            PATH_SUFFIXES include
            )

    find_library (TENSORFLOW_LIBRARIES tensorflow
            HINTS ${TENSORFLOW_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
            PATH_SUFFIXES lib
            )

    find_package_handle_standard_args (Tensorflow
            FOUND_VAR TENSORFLOW_FOUND
            REQUIRED_VARS TENSORFLOW_LIBRARIES TENSORFLOW_INCLUDES
            VERSION_VAR TENSORFLOW_VERSION)

    if (TENSORFLOW_INCLUDES AND TENSORFLOW_LIBRARIES)
        set (TENSORFLOW_FOUND TRUE)
    else (TENSORFLOW_INCLUDES AND TENSORFLOW_LIBRARIES)
        set (TENSORFLOW_FOUND FALSE)
        if (NOT TENSORFLOW_FIND_QUIETLY)
            if (NOT TENSORFLOW_INCLUDES)
                message (STATUS "Unable to find TENSORFLOW header files!")
            endif (NOT TENSORFLOW_INCLUDES)
            if (NOT TENSORFLOW_LIBRARIES)
                message (STATUS "Unable to find TENSORFLOW library files!")
            endif (NOT TENSORFLOW_LIBRARIES)
        endif (NOT TENSORFLOW_FIND_QUIETLY)
    endif (TENSORFLOW_INCLUDES AND TENSORFLOW_LIBRARIES)

    if (TENSORFLOW_FOUND)
        if (NOT Tensorflow_FIND_QUIETLY)
            message (STATUS "Found components for TENSORFLOW")
            message (STATUS "TENSORFLOW_ROOT_DIR  = ${TENSORFLOW_ROOT_DIR}")
            message (STATUS "TENSORFLOW_INCLUDES  = ${TENSORFLOW_INCLUDES}")
            message (STATUS "TENSORFLOW_LIBRARIES = ${TENSORFLOW_LIBRARIES}")
        endif (NOT Tensorflow_FIND_QUIETLY)
    else (TENSORFLOW_FOUND)
        if (TENSORFLOW_FIND_REQUIRED)
            message (FATAL_ERROR "Could not find TENSORFLOW!")
        endif (TENSORFLOW_FIND_REQUIRED)
    endif (TENSORFLOW_FOUND)

    mark_as_advanced (
            TENSORFLOW_ROOT_DIR
            TENSORFLOW_INCLUDES
            TENSORFLOW_LIBRARIES
    )

endif (NOT TENSORFLOW_FOUND)