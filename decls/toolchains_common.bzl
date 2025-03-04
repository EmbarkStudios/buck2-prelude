# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under both the MIT license found in the
# LICENSE-MIT file in the root directory of this source tree and the Apache
# License, Version 2.0 found in the LICENSE-APACHE file in the root directory
# of this source tree.

load("@prelude//android:android_toolchain.bzl", "AndroidPlatformInfo", "AndroidToolchainInfo")
load("@prelude//cxx:cxx_toolchain_types.bzl", "CxxPlatformInfo", "CxxToolchainInfo")
load("@prelude//go:toolchain.bzl", "GoToolchainInfo")
load("@prelude//haskell:haskell.bzl", "HaskellPlatformInfo", "HaskellToolchainInfo")
load("@prelude//java:dex_toolchain.bzl", "DexToolchainInfo")
load(
    "@prelude//java:java_toolchain.bzl",
    "JavaPlatformInfo",
    "JavaTestToolchainInfo",
    "JavaToolchainInfo",
    "PrebuiltJarToolchainInfo",
)
load(
    "@prelude//kotlin:kotlin_toolchain.bzl",
    "KotlinToolchainInfo",
)
load("@prelude//python:toolchain.bzl", "PythonPlatformInfo", "PythonToolchainInfo")
load("@prelude//python_bootstrap:python_bootstrap.bzl", "PythonBootstrapToolchainInfo")
load("@prelude//rust:rust_toolchain.bzl", "RustToolchainInfo")

def _toolchain(lang: str, providers: list[typing.Any]) -> Attr:
    return attrs.default_only(attrs.toolchain_dep(default = "toolchains//:" + lang, providers = providers))

def _toolchain_with_override(lang: str, providers: list[typing.Any]) -> Attr:
    return attrs.toolchain_dep(default = "toolchains//:" + lang, providers = providers)

def _android_toolchain():
    return _toolchain("android", [AndroidToolchainInfo, AndroidPlatformInfo])

def _cxx_toolchain():
    return _toolchain("cxx", [CxxToolchainInfo, CxxPlatformInfo])

def _dex_toolchain():
    return _toolchain_with_override("dex", [DexToolchainInfo])

def _go_toolchain():
    return _toolchain("go", [GoToolchainInfo])

def _haskell_toolchain():
    return _toolchain("haskell", [HaskellToolchainInfo, HaskellPlatformInfo])

def _java_toolchain():
    return _toolchain_with_override("java", [JavaToolchainInfo, JavaPlatformInfo])

def _java_for_android_toolchain():
    return _toolchain("java_for_android", [JavaToolchainInfo, JavaPlatformInfo])

def _java_for_host_test_toolchain():
    return _toolchain("java_for_host_test", [JavaToolchainInfo, JavaPlatformInfo])

def _java_test_toolchain():
    return _toolchain("java_test", [JavaTestToolchainInfo])

def _kotlin_toolchain():
    return _toolchain_with_override("kotlin", [KotlinToolchainInfo])

def _prebuilt_jar_toolchain():
    # Override is allowed for bootstrapping prebuilt jar toolchains
    return _toolchain_with_override("prebuilt_jar", [PrebuiltJarToolchainInfo])

def _python_toolchain():
    return _toolchain("python", [PythonToolchainInfo, PythonPlatformInfo])

def _python_bootstrap_toolchain():
    return _toolchain("python_bootstrap", [PythonBootstrapToolchainInfo])

def _rust_toolchain():
    return _toolchain("rust", [RustToolchainInfo])

toolchains_common = struct(
    android = _android_toolchain,
    cxx = _cxx_toolchain,
    dex = _dex_toolchain,
    go = _go_toolchain,
    haskell = _haskell_toolchain,
    java = _java_toolchain,
    java_for_android = _java_for_android_toolchain,
    java_for_host_test = _java_for_host_test_toolchain,
    java_test = _java_test_toolchain,
    kotlin = _kotlin_toolchain,
    prebuilt_jar = _prebuilt_jar_toolchain,
    python = _python_toolchain,
    python_bootstrap = _python_bootstrap_toolchain,
    rust = _rust_toolchain,
)
