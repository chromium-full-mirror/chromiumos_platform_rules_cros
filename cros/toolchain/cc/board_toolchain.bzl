load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "flag_group",
    "flag_set",
    "tool",
)

_DEFAULT_LINKER_FLAGS = [
    flag_set(
        flag_groups = [
            flag_group(
                flags = [
                    "-Wl,-znow",
                    "-Wl,-zrelro",
                    "-Wl,--no-rosegment",
                    "-Wl,--hash-style=gnu",
                ],
            ),
        ],
    ),
]

def _impl(ctx):
    is_host = ctx.attr.is_host
    if is_host:
        vendor = "pc"
    else:
        vendor = "cros"

    arch = ctx.attr.cpu_arch
    if arch == "armv7a":
        abi = "gnueabihf"
    else:
        abi = "gnu"

    triple = "{}-{}-linux-{}".format(arch, vendor, abi)
    usr_bin_triple = "/usr/bin/" + triple + "-"
    action_configs = [
        action_config(
            action_name = ACTION_NAMES.cpp_compile,
            tools = [
                tool(
                    path = usr_bin_triple + "clang++",
                ),
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.c_compile,
            tools = [
                tool(
                    path = usr_bin_triple + "clang",
                ),
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_executable,
            tools = [
                tool(
                    path = usr_bin_triple + "clang++",
                ),
            ],
            flag_sets = _DEFAULT_LINKER_FLAGS,
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_dynamic_library,
            tools = [
                tool(
                    path = usr_bin_triple + "clang++",
                ),
            ],
            flag_sets = _DEFAULT_LINKER_FLAGS,
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_nodeps_dynamic_library,
            tools = [
                tool(
                    path = usr_bin_triple + "clang++",
                ),
            ],
            flag_sets = _DEFAULT_LINKER_FLAGS,
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_static_library,
            tools = [
                tool(
                    path = usr_bin_triple + "clang++",
                ),
            ],
            flag_sets = _DEFAULT_LINKER_FLAGS,
        ),
        action_config(
            action_name = ACTION_NAMES.strip,
            tools = [
                tool(
                    path = usr_bin_triple + "strip",
                ),
            ],
        ),
    ]

    if is_host:
        sysroot = None
        include_dirs = [
            "/usr/include/c++/v1",
            "/usr/lib64/clang/14.0.0/include",
            "/usr/local/include",
            "/include",
            "/usr/include",
        ]
    else:
        sysroot = "/usr/" + triple
        include_dirs = [
            "/usr/lib64/clang/14.0.0",
            "/usr/lib64/gcc/{}/10.2.0".format(triple),
            "%sysroot%/usr/local/include",
            "%sysroot%/include",
            "%sysroot%/usr/include",
        ]

    # Documented at
    # https://docs.bazel.build/versions/main/skylark/lib/cc_common.html#create_cc_toolchain_config_info.
    #
    # create_cc_toolchain_config_info is the public interface for registering
    # C++ toolchain behavior.
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "cros-sdk-" + triple,
        host_system_name = "linux",
        target_system_name = "local",
        target_cpu = arch,
        target_libc = "glibc-2.33",
        compiler = "clang",
        abi_version = "local",
        abi_libc_version = "local",
        action_configs = action_configs,
        builtin_sysroot = sysroot,
        cxx_builtin_include_directories = include_dirs,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "cpu_arch": attr.string(mandatory = True),
        "is_host": attr.bool(mandatory = True),
    },
    provides = [CcToolchainConfigInfo],
)

def _generate_cc_toolchain(cpu_arch, is_host, bazel_cpu_arch = None):
    if bazel_cpu_arch == None:
        bazel_cpu_arch = cpu_arch

    if is_host:
        config_name = "host_toolchain_config"
        vendor = "pc"
    else:
        config_name = cpu_arch + "_board_toolchain_config"
        vendor = "cros"

    cc_toolchain_config(name = config_name, cpu_arch = cpu_arch, is_host = is_host)
    cc_toolchain_name = "cros-sdk-{}-{}-linux-gnu-cc".format(cpu_arch, vendor)
    native.cc_toolchain(
        name = cc_toolchain_name,
        all_files = ":none",
        compiler_files = ":none",
        dwp_files = ":none",
        linker_files = ":none",
        objcopy_files = ":none",
        strip_files = ":none",
        toolchain_config = ":" + config_name,
    )

    native.toolchain(
        name = "cros-sdk-{}-{}-linux-gnu-cc-toolchain".format(cpu_arch, vendor),
        exec_compatible_with = [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
        ],
        target_compatible_with = [
            "@platforms//cpu:" + bazel_cpu_arch,
            "@platforms//os:linux",
            "//cros/platforms/vendor:" + vendor,
        ],
        toolchain = ":" + cc_toolchain_name,
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )

def generate_board_cc_toolchain(cpu_arch, bazel_cpu_arch = None):
    _generate_cc_toolchain(cpu_arch = cpu_arch, is_host = False, bazel_cpu_arch = bazel_cpu_arch)

def generate_host_cc_toolchain():
    _generate_cc_toolchain(cpu_arch = "x86_64", is_host = True)
