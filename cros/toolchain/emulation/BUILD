# Copyright 2022 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

load(":toolchain.bzl", "emulation_toolchain")

package(default_visibility = ["//visibility:public"])

emulation_toolchain(
    name = "cros-sdk-x86_64-pc-linux-gnu-emulation_impl",
    emulator_path = "/lib64/ld-linux-x86-64.so.2",
)

emulation_toolchain(
    name = "cros-sdk-x86_64-cros-linux-gnu-emulation_impl",
    emulator_path = "qemu-x86_64",
)

toolchain(
    name = "cros-sdk-x86_64-pc-linux-gnu-emulation",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
        "//cros/platforms/vendor:pc",
    ],
    toolchain = ":cros-sdk-x86_64-pc-linux-gnu-emulation_impl",
    toolchain_type = ":toolchain_type",
)

toolchain(
    name = "cros-sdk-x86_64-cros-linux-gnu-emulation",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
        "//cros/platforms/vendor:cros",
    ],
    toolchain = ":cros-sdk-x86_64-cros-linux-gnu-emulation_impl",
    toolchain_type = ":toolchain_type",
)

toolchain_type(
    name = "toolchain_type",
)
