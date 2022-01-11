load(":local_cc_toolchain.bzl", "local_cc_toolchain_config")

filegroup(
    name = "none",
    srcs = [],
)

local_cc_toolchain_config(
    name = "local_toolchain_semantics",
)

cc_toolchain(
    name = "cros-sdk-x86_64-pc-linux-gnu-cc",
    all_files = ":none",
    compiler_files = ":none",
    dwp_files = ":none",
    linker_files = ":none",
    objcopy_files = ":none",
    strip_files = ":none",
    toolchain_config = ":local_toolchain_semantics",
)

toolchain(
    name = "cros-sdk-x86_64-pc-linux-gnu-cc-toolchain",
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    toolchain = ":cros-sdk-x86_64-pc-linux-gnu-cc",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

cc_toolchain_suite(
    name = "cros-cc-toolchain-suite",
    toolchains = {
        "x86_64": "cros-sdk-x86_64-pc-linux-gnu-cc",
        "k8": "cros-sdk-x86_64-pc-linux-gnu-cc",
    },
)
