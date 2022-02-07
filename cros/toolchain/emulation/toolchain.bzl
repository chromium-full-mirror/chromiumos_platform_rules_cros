EmuInfo = provider(
    fields = ["emulator_path"],
)

def _impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        emuinfo = EmuInfo(
            emulator_path = ctx.attr.emulator_path,
        ),
    )
    return [toolchain_info]

emulation_toolchain = rule(
    implementation = _impl,
    attrs = {
        "emulator_path": attr.string(),
    },
    provides = [platform_common.ToolchainInfo],
)
