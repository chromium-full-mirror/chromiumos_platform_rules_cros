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
    action_configs = [
        action_config(
            action_name = ACTION_NAMES.cpp_compile,
            tools = [
                tool(
                    path = "/usr/bin/x86_64-pc-linux-gnu-clang++",
                ),
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.c_compile,
            tools = [
                tool(
                    path = "/usr/bin/x86_64-pc-linux-gnu-clang",
                ),
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_executable,
            tools = [
                tool(
                    path = "/usr/bin/x86_64-pc-linux-gnu-clang++",
                ),
            ],
            flag_sets = _DEFAULT_LINKER_FLAGS,
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_dynamic_library,
            tools = [
                tool(
                    path = "/usr/bin/x86_64-pc-linux-gnu-clang++",
                ),
            ],
            flag_sets = _DEFAULT_LINKER_FLAGS,
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_nodeps_dynamic_library,
            tools = [
                tool(
                    path = "/usr/bin/x86_64-pc-linux-gnu-clang++",
                ),
            ],
            flag_sets = _DEFAULT_LINKER_FLAGS,
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_static_library,
            tools = [
                tool(
                    path = "/usr/bin/x86_64-pc-linux-gnu-clang++",
                ),
            ],
            flag_sets = _DEFAULT_LINKER_FLAGS,
        ),
        action_config(
            action_name = ACTION_NAMES.strip,
            tools = [
                tool(
                    path = "/usr/bin/x86_64-pc-linux-gnu-strip",
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
        toolchain_identifier = "cros-sdk-x86_64-pc-linux-gnu",
        host_system_name = "linux",
        target_system_name = "local",
        target_cpu = "x86_64",
        target_libc = "glibc-2.33",
        compiler = "clang",
        abi_version = "local",
        abi_libc_version = "local",
        action_configs = action_configs,
        cxx_builtin_include_directories = [
            "/usr/include/c++/v1",
            "/usr/lib64/clang/14.0.0/include",
            "/usr/local/include",
            "/include",
            "/usr/include",
        ],
    )

cros_sdk_host_cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
