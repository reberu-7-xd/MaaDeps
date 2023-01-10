if(NOT DEFINED VCPKG_TARGET_TRIPLET)
  find_package(Python3 COMPONENTS Interpreter REQUIRED)
  execute_process(COMMAND "${Python3_EXECUTABLE}" "${CMAKE_CURRENT_LIST_DIR}/host_triplet.py" OUTPUT_VARIABLE VCPKG_HOST_TRIPLET OUTPUT_STRIP_TRAILING_WHITESPACE)
  set(VCPKG_TARGET_TRIPLET "maa-${VCPKG_HOST_TRIPLET}")
endif()
if(NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/vcpkg/installed/${VCPKG_TARGET_TRIPLET}")
  message(FATAL_ERROR
    " "
    " Dependencies not found for ${VCPKG_TARGET_TRIPLET}\n"
    " run MaaDeps/download.py to download prebuilt binaries\n"
    " or MaaDeps/build.py to build from source\n"
  )
endif()
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_CURRENT_LIST_DIR}/vcpkg/installed/${VCPKG_TARGET_TRIPLET}")