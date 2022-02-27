load("@rules_rust//rust:toolchain.bzl", "rust_toolchain")

def _generate_rust_toolchain(cpu_arch, vendor, bazel_cpu_arch = None, custom_target_triple = None):
    if bazel_cpu_arch == None:
        bazel_cpu_arch = cpu_arch

    abi = "gnu"
    if cpu_arch == "armv7a":
        abi = "gnueabihf"

    triple = "{}-{}-linux-{}".format(cpu_arch, vendor, abi)
    if custom_target_triple == None:
        custom_target_triple = triple

    toolchain_name = "cros-sdk-{}-rust_impl".format(triple)
    rust_toolchain(
        name = toolchain_name,
        binary_ext = "",
        cargo = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:cargo",
        clippy_driver = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:clippy-driver",
        default_edition = "2018",
        dylib_ext = ".so",
        os = "linux",
        rust_doc = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:rustdoc",
        rust_lib = "@cros_toolchains//rust/lib/{}:rust_libs".format(triple),
        rustc = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:rustc",
        rustc_lib = "@cros_toolchains//rust/lib/{}:rustc_libs".format(triple),
        rustfmt = "@cros_toolchains//rust/bin/x86_64-pc-linux-gnu:rustfmt",
        staticlib_ext = ".a",
        stdlib_linkflags = [
            "-lpthread",
            "-ldl",
            "-lc++",
        ],
        target_triple = custom_target_triple,
    )

    native.toolchain(
        name = "cros-sdk-{}-rust".format(triple),
        exec_compatible_with = [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
        ],
        target_compatible_with = [
            "@platforms//cpu:" + bazel_cpu_arch,
            "@platforms//os:linux",
            "//cros/platforms/vendor:" + vendor,
        ],
        toolchain = ":" + toolchain_name,
        toolchain_type = "@rules_rust//rust:toolchain",
    )

def generate_host_rust_toolchain():
    # TODO(b/215615637): Change this target triple back to x86_64-pc-linux-gnu
    _generate_rust_toolchain(
        cpu_arch = "x86_64",
        vendor = "pc",
        custom_target_triple = "x86_64-unknown-linux-gnu",
    )

def generate_board_rust_toolchain(cpu_arch, bazel_cpu_arch = None):
    _generate_rust_toolchain(
        cpu_arch = cpu_arch,
        vendor = "cros",
        bazel_cpu_arch = bazel_cpu_arch,
    )
