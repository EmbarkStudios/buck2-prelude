load("@prelude//apple:apple_bundle_types.bzl", "AppleBundleResourceInfo")
load("@prelude//apple:apple_code_signing_types.bzl", "CodeSignType")
load("@prelude//apple:apple_toolchain_types.bzl", "AppleToolchainInfo", "AppleToolsInfo")
load("@prelude//apple/user:resource_group_map.bzl", "resource_group_map_attr")

def get_apple_toolchain_attr():
    # FIXME: prelude// should be standalone (not refer to fbcode//)
    return attrs.toolchain_dep(default = "fbcode//buck2/platform/toolchain:apple-default", providers = [AppleToolchainInfo])

def get_apple_xctoolchain_attr():
    # FIXME: prelude// should be standalone (not refer to fbcode//)
    return attrs.toolchain_dep(default = "fbcode//buck2/platform/toolchain:apple-xctoolchain")

def get_apple_xctoolchain_bundle_id_attr():
    # FIXME: prelude// should be standalone (not refer to fbcode//)
    return attrs.toolchain_dep(default = "fbcode//buck2/platform/toolchain:apple-xctoolchain-bundle-id")

def apple_bundle_extra_attrs():
    return {
        "resource_group_map": resource_group_map_attr(),
        # FIXME: prelude// should be standalone (not refer to buck//)
        "_apple_installer": attrs.label(default = "buck//src/com/facebook/buck/installer/apple:apple_installer"),
        "_apple_toolchain": get_apple_toolchain_attr(),
        # FIXME: prelude// should be standalone (not refer to fbsource//)
        "_apple_tools": attrs.exec_dep(default = "fbsource//xplat/buck2/platform/apple:apple-tools", providers = [AppleToolsInfo]),
        "_apple_xctoolchain": get_apple_xctoolchain_attr(),
        "_apple_xctoolchain_bundle_id": get_apple_xctoolchain_bundle_id_attr(),
        "_codesign_entitlements": attrs.option(attrs.source(), default = None),
        "_codesign_type": attrs.option(attrs.enum(CodeSignType.values()), default = None),
        "_incremental_bundling_enabled": attrs.bool(),
        # FIXME: prelude// should be standalone (not refer to fbsource//)
        "_provisioning_profiles": attrs.dep(default = "fbsource//xplat/buck2/platform/apple:provisioning_profiles"),
        "_resource_bundle": attrs.option(attrs.dep(providers = [AppleBundleResourceInfo]), default = None),
    }
