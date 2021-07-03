# For a list of common variables see https://github.com/microsoft/vcpkg/blob/master/docs/maintainers/vcpkg_common_definitions.md

# Checkout dependencies

vcpkg_from_github(
    OUT_SOURCE_PATH HE_SOURCE_DIR
    REPO "myst6re/highly_experimental"
    HEAD_REF master
    REF 0768ebd43e7be05786e67d346091117457ddab2b
    SHA512 7385770b2e834c36a2b53fb02cde099faf7e1a77443b6bb66dfb1db71cfee7d4cf4fb4588a266472821829fa4d511871a7f6205de7c3cb956a51fcd95c237a26
)

vcpkg_from_github(
    OUT_SOURCE_PATH PSFLIB_SOURCE_DIR
    REPO "julianxhokaxhiu/psflib"
    HEAD_REF master
    REF 6d276bc19c49d3913f5bac2b85f2c5566ff7fea4
    SHA512 feba0b96f79284c7863f478098bd245008c0d7cabc418034d53b0200850811fbe2cd73fa095813156edf602a292c7a662356c82270d0acb5a943a9b4a0ff2e44
)

# Checkout this project

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_DIR
    REPO "julianxhokaxhiu/openpsf"
    HEAD_REF master
    REF 71e747a217fd1f7e396bb824f5a925f34fcf4990
    SHA512 a4878ad3f54f35633191e717ac8f74e69848cdfbb2b6e46f3e5b1c4a36edcd1772d18f183132c8e55c9b28e69daafbabfe0116bd18ac9e3dff19b31310e66069
)

# Move dependencies inside the project directory
file(RENAME ${HE_SOURCE_DIR} "${SOURCE_DIR}/highly_experimental")
file(RENAME ${PSFLIB_SOURCE_DIR} "${SOURCE_DIR}/psflib")

# Run MSBuild

vcpkg_install_msbuild(
    SOURCE_PATH "${SOURCE_DIR}"
    PROJECT_SUBPATH "openpsf.vcxproj"
    LICENSE_SUBPATH "LICENSE"
    INCLUDES_SUBPATH "src"
    ALLOW_ROOT_INCLUDES
    USE_VCPKG_INTEGRATION
)

# Copy psflib.h header
file(COPY "${SOURCE_DIR}/psflib/psflib.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include")
