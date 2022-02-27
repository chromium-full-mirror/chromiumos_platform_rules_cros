# Copyright 2022 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
load(":board_toolchain.bzl", "generate_board_cc_toolchain", "generate_host_cc_toolchain")

package(default_visibility = ["//visibility:public"])

# TODO: Set these CC toolchains to track the appropriate files as dependencies.
#
# Currently, these cc_toolchain declarations don't track *any* files.
filegroup(
    name = "none",
    srcs = [],
)

generate_host_cc_toolchain()

generate_board_cc_toolchain(
    bazel_cpu_arch = "armv7",
    cpu_arch = "armv7a",
)

generate_board_cc_toolchain(cpu_arch = "x86_64")

# Workaround for https://github.com/bazelbuild/bazel/issues/12712
cc_toolchain_suite(
    name = "cros-cc-toolchain-suite",
    toolchains = {
        "x86_64": "cros-sdk-x86_64-pc-linux-gnu-cc",
        "k8": "cros-sdk-x86_64-pc-linux-gnu-cc",
    },
)
