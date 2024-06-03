vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nugulinux/njson
    REF msvc
    SHA512 06a09a94dd5a226017a59dc40989b37141cb1106ab449f40b654aef2d727c0cdd41b6db27f8e467e19f742a223d8f9a3a85a6c51d58f3fb781e9fa2ab1c28ff7
    HEAD_REF msvc
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_TEST=OFF
    OPTIONS_DEBUG
        -DENABLE_TEST=ON
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
    vcpkg_copy_tools(TOOL_NAMES test_njson
        SEARCH_DIR ${CURRENT_PACKAGES_DIR}/debug/bin
        DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools/${PORT}
        AUTO_CLEAN)
endif()

# Clean
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
