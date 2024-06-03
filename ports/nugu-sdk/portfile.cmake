vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nugu-developers/nugu-linux
    REF 6964e70e738d5ba2aa2f40b5b77e2bf85659c69e
    SHA512 01b878613932be22c58838697ed0caf25535c63b5621e65b07f83c148f5022318ff65784cf34fac4b035fbb5c4d53dcea4c27d9fea1216fd9b51b2a8a15e2fde
    HEAD_REF master
    PATCHES
        0001-fix-plugin-path.patch
        0002-fix-tools.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        "gstreamer"   ENABLE_GSTREAMER_PLUGIN
        "examples"    ENABLE_EXAMPLES_OOB_SETUP
        "examples"    ENABLE_EXAMPLES_STANDALONE
        "examples"    ENABLE_EXAMPLES_SIMPLE_TEXT
        "examples"    ENABLE_EXAMPLES_SIMPLE_ASR
        "examples"    ENABLE_EXAMPLES_SIMPLE_PLAY
        "examples"    ENABLE_EXAMPLES_SIMPLE_TTS
        "examples"    ENABLE_EXAMPLES_PROFILING
        "examples"    ENABLE_EXAMPLES_CAP_INJECTION
        "examples"    ENABLE_EXAMPLES_RESP_FILTER
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_VENDOR_LIBRARY=OFF
        -DENABLE_OPUSENC_PLUGIN=ON
        -DENABLE_VOICE_STREAMING=ON
        -DENABLE_BUILTIN_NJSON=OFF
        -DENABLE_BUILTIN_PLUGIN="dummy,opus,opus_encoder"
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

if("examples" IN_LIST FEATURES)
    list(APPEND NUGU_TOOLS
        nugu_capability_injection
        nugu_prof
        nugu_response_filter
        nugu_sample
        nugu_simple_asr
        nugu_simple_play
        nugu_simple_text
        nugu_simple_tts)
endif()

if(EXISTS "${CURRENT_PACKAGES_DIR}/bin/nugu_oob_server.py")
    file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/${PORT}")
    file(RENAME "${CURRENT_PACKAGES_DIR}/bin/nugu_oob_server.py" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/nugu_oob_server.py")
endif()

vcpkg_copy_tools(TOOL_NAMES ${NUGU_TOOLS} AUTO_CLEAN)

# Clean
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
