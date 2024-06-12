# $env:VCPKG_KEEP_ENV_VARS="AUTH_TOKEN"
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nugulinux/nugu-extension
    REF aaaf53576e751da54998cbd84827735fecd56da3
    SHA512 c5eeeab3878874192ac0bb48ea84744c7c3d0f96ef2f69512aab2d8cbceebf9e88bda83c57bc979126fd69471b251cd7abe0474902d8d841086a59fd8450ac59
    HEAD_REF master
    AUTHORIZATION_TOKEN $ENV{AUTH_TOKEN}
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_ASAN=OFF
        -DENABLE_EXAMPLES_SAMPLE=OFF
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

# Clean
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
