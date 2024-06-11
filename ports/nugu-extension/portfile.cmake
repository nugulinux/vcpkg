# $env:VCPKG_KEEP_ENV_VARS="AUTH_TOKEN"
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nugulinux/nugu-extension
    REF 28fee497e26607c8e3850519c2c1b6af95560e40
    SHA512 a17b5e0cce7cfbd55bb4e0549286aa0db667462f71846904a8502e8335611b2d6b7b5698bb60f10a96165258906a28267049b25759164ed18ec58b3f5fa6b1e3
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
