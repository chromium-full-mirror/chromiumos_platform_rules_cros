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
    arch = ctx.attr.cpu_arch
    if arch == "armv7a":
        abi = "gnueabihf"
    else:
        abi = "gnu"

    triple = "{}-cros-linux-{}".format(arch, abi)
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
        # TODO(cjmcdonald): Make builtin_sysroot an argument for the rule and figure out how
        #                   to pass it in.
        builtin_sysroot = "/usr/" + triple,
        cxx_builtin_include_directories = [
            "/usr/lib64/clang/14.0.0",
            "/usr/lib64/gcc/{}/10.2.0".format(triple),
            "%sysroot%/usr/local/include",
            "%sysroot%/include",
            "%sysroot%/usr/include",
        ],
    )

board_cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "cpu_arch": attr.string(mandatory = True),
    },
    provides = [CcToolchainConfigInfo],
)
