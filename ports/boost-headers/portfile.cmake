# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/headers
    REF boost-${VERSION}
    SHA512 25df8bd5e925bbcb6254f21b34ca3e4786178ca1af900f0c5c781f16127539688143ee79f200c132772eb5bb2a519f1f8feafc91ca222d48511fb4eaa135f6f0
    HEAD_REF master
)

set(FEATURE_OPTIONS "")
boost_configure_and_install(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)