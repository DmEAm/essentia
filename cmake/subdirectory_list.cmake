
function(subdirectory_list RESULT TARGET_DIR)
    set(flags RECURSIVE)
    set(args "")
    set(variadic_args "")
    cmake_parse_arguments(SUBDIRECTORY_LIST "${flags}" "${args}" "${variadic_args}" ${ARGN})

    file(GLOB_RECURSE ENTRIES LIST_DIRECTORIES ON ${TARGET_DIR}/*)
    set(DIRECTORY_LIST "")

    foreach(ENTRY ${ENTRIES})
        if(IS_DIRECTORY ${ENTRY})
            list(APPEND DIRECTORY_LIST ${ENTRY})
        endif()
    endforeach()

    set(${RESULT} ${DIRECTORY_LIST} PARENT_SCOPE)
endfunction()
