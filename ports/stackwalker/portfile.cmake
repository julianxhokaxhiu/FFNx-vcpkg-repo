# For a list of common variables see https://github.com/microsoft/vcpkg/blob/master/docs/maintainers/vcpkg_common_definitions.md

# Download source packages
# (bgfx requires bx and bimg source for building)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "JochenKalmbach/StackWalker"
    HEAD_REF master
    REF 53320512bd2fe1097b85e38262191d7c55210990
    SHA512 06ee02855c2f0f0d5176f2edc95f704b7ab721a80e26cdb5cc037f7abb98bcd2318ffe23934ad2f1289e69d5a835eb24c496e2e1cecccd442ed107ab4fda28fc
    PATCHES
        cmake.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS_DEBUG
        -DSKIP_INSTALL_HEADERS=ON
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
