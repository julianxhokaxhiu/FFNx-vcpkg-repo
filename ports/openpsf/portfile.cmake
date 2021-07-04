# For a list of common variables see https://github.com/microsoft/vcpkg/blob/master/docs/maintainers/vcpkg_common_definitions.md

# Checkout dependencies

vcpkg_from_github(
    OUT_SOURCE_PATH HE_SOURCE_DIR
    REPO "julianxhokaxhiu/highly_experimental"
    HEAD_REF master
    REF 9790e0bf726ac7f3120f860dfcbb550003df45f6
    SHA512 e3943edbbffde2e0c5e170755beb57043b6d1f78464c40766af7a5c1d6a0d91a80b8466a75e421d87271b10fffcc24a40950290f9b1f901f506963545da1676a
)

vcpkg_from_github(
    OUT_SOURCE_PATH PSFLIB_SOURCE_DIR
    REPO "julianxhokaxhiu/psflib"
    HEAD_REF master
    REF b74d6e8e9fcf0d3a5ebb147f036d80067ee09cb8
    SHA512 19f53f4d8519c343b7f2a2acf6315daf00938a59bd9366a989db0845fdb1307638e1b5d0ae57bd72fef4e586952d3a58369ae8b9914e52a29fe773a80b00c083
)

# Checkout this project

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_DIR
    REPO "julianxhokaxhiu/openpsf"
    HEAD_REF master
    REF cdee811929fd76c9938471bc41a388c315cd187b
    SHA512 603a9ad6e918563c9358f92907c51f0a3c8caf48789d23e3d64e5ff9251a9a228c830d8de9d402237634daad0223e612168efeff9f9472de0591914098e6a32d
)

# Move dependencies inside the project directory
file(RENAME ${HE_SOURCE_DIR} "${SOURCE_DIR}/highly_experimental")
file(RENAME ${PSFLIB_SOURCE_DIR} "${SOURCE_DIR}/psflib")

# Run MSBuild

vcpkg_install_msbuild(
    SOURCE_PATH "${SOURCE_DIR}"
    PROJECT_SUBPATH "openpsf.sln"
    LICENSE_SUBPATH "LICENSE"
    INCLUDES_SUBPATH "include"
    USE_VCPKG_INTEGRATION
)

# Copy dependencies headers
file(INSTALL "${SOURCE_DIR}/highly_experimental/include" DESTINATION "${CURRENT_PACKAGES_DIR}/include")
file(INSTALL "${SOURCE_DIR}/psflib/include" DESTINATION "${CURRENT_PACKAGES_DIR}/include")
