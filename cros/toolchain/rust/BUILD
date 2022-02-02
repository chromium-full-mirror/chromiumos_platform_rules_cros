load("@rules_rust//rust:toolchain.bzl", "rust_toolchain")

package(default_visibility = ["//visibility:public"])

# TODO: These toolchain declarations should be templated into BUILD files in the
# mapped repository so the file labels can dynamically refer to the right place
# rather than being hardcoded like this.

# Host toolchain
rust_toolchain(
    name = "cros-sdk-x86_64-pc-linux-gnu-rust_impl",
    binary_ext = "",
    cargo = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:cargo",
    clippy_driver = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:clippy-driver",
    default_edition = "2018",
    dylib_ext = ".so",
    os = "linux",
    rust_doc = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:rustdoc",
    rust_lib = "@cros_toolchains//rust/lib/x86_64-pc-linux-gnu:rust_libs",
    rustc = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:rustc",
    rustc_lib = "@cros_toolchains//rust/lib/x86_64-pc-linux-gnu:rustc_libs",
    rustfmt = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:rustfmt",
    staticlib_ext = ".a",
    stdlib_linkflags = [
        "-lpthread",
        "-ldl",
        "-lc++",
    ],
    # TODO(b/215615637): Change this target triple back to x86_64-pc-linux-gnu
    target_triple = "x86_64-unknown-linux-gnu",
)

# x86_64 board toolchain
rust_toolchain(
    name = "cros-sdk-x86_64-cros-linux-gnu-rust_impl",
    binary_ext = "",
    cargo = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:cargo",
    clippy_driver = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:clippy-driver",
    default_edition = "2018",
    dylib_ext = ".so",
    os = "linux",
    rust_doc = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:rustdoc",
    rust_lib = "@cros_toolchains//rust/lib/x86_64-cros-linux-gnu:rust_libs",
    rustc = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:rustc",
    rustc_lib = "@cros_toolchains//rust/lib/x86_64-cros-linux-gnu:rustc_libs",
    rustfmt = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:rustfmt",
    staticlib_ext = ".a",
    stdlib_linkflags = [
        "-lpthread",
        "-ldl",
        "-lc++",
    ],
    target_triple = "x86_64-cros-linux-gnu",
)

toolchain(
    name = "cros-sdk-x86_64-pc-linux-gnu-rust",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
        "//cros/platforms/vendor:pc",
    ],
    toolchain = ":cros-sdk-x86_64-pc-linux-gnu-rust_impl",
    toolchain_type = "@rules_rust//rust:toolchain",
)

toolchain(
    name = "cros-sdk-x86_64-cros-linux-gnu-rust",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
        "//cros/platforms/vendor:cros",
    ],
    toolchain = ":cros-sdk-x86_64-cros-linux-gnu-rust_impl",
    toolchain_type = "@rules_rust//rust:toolchain",
)
