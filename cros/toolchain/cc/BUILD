# Copyright 2022 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

load(":board_toolchain.bzl", "board_cc_toolchain_config")
load(":host_toolchain.bzl", "cros_sdk_host_cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

# TODO: Set these CC toolchains to track the appropriate files as dependencies.
#
# Currently, these cc_toolchain declarations don't track *any* files.
filegroup(
    name = "none",
    srcs = [],
)

board_cc_toolchain_config(
    name = "x86_64_board_toolchain_semantics",
    cpu_arch = "x86_64",
)

# x86_64 board toolchain
cc_toolchain(
    name = "cros-sdk-x86_64-cros-linux-gnu-cc",
    all_files = ":none",
    compiler_files = ":none",
    dwp_files = ":none",
    linker_files = ":none",
    objcopy_files = ":none",
    strip_files = ":none",
    toolchain_config = ":x86_64_board_toolchain_semantics",
)

toolchain(
    name = "cros-sdk-x86_64-cros-linux-gnu-cc-toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
        "//cros/platforms/vendor:cros",
    ],
    toolchain = ":cros-sdk-x86_64-cros-linux-gnu-cc",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

cros_sdk_host_cc_toolchain_config(
    name = "host_toolchain_semantics",
)

# armv7 board toolchain

board_cc_toolchain_config(
    name = "armv7a_board_toolchain_semantics",
    cpu_arch = "armv7a",
)

cc_toolchain(
    name = "cros-sdk-armv7a-cros-linux-gnu-cc",
    all_files = ":none",
    compiler_files = ":none",
    dwp_files = ":none",
    linker_files = ":none",
    objcopy_files = ":none",
    strip_files = ":none",
    toolchain_config = ":armv7a_board_toolchain_semantics",
)

toolchain(
    name = "cros-sdk-armv7a-cros-linux-gnu-cc-toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:armv7",
        "@platforms//os:linux",
        "//cros/platforms/vendor:cros",
    ],
    toolchain = ":cros-sdk-armv7a-cros-linux-gnu-cc",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# Host toolchain
cc_toolchain(
    name = "cros-sdk-x86_64-pc-linux-gnu-cc",
    all_files = ":none",
    compiler_files = ":none",
    dwp_files = ":none",
    linker_files = ":none",
    objcopy_files = ":none",
    strip_files = ":none",
    toolchain_config = ":host_toolchain_semantics",
)

toolchain(
    name = "cros-sdk-x86_64-pc-linux-gnu-cc-toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
        "//cros/platforms/vendor:pc",
    ],
    toolchain = ":cros-sdk-x86_64-pc-linux-gnu-cc",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# Workaround for https://github.com/bazelbuild/bazel/issues/12712
cc_toolchain_suite(
    name = "cros-cc-toolchain-suite",
    toolchains = {
        "x86_64": "cros-sdk-x86_64-pc-linux-gnu-cc",
        "k8": "cros-sdk-x86_64-pc-linux-gnu-cc",
    },
)
