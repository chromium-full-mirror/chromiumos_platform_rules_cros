"""cros_rust_repository is a repository rule for importing the Rust toolchain from the CrOS SDK."""

def _execute_bash(repo_ctx, cmd):
    return repo_ctx.execute(["/bin/bash", "-c", cmd]).stdout.strip("\n")

def _get_rustlib_filenames(repo_ctx, target_triple):
    filenames = _execute_bash(
        repo_ctx,
        "find /usr/lib64/rustlib/{}/lib -type f -printf '%P\\n'".format(target_triple),
    )
    if filenames:
        return filenames.split("\n")
    else:
        return None

_TRIPLES = ["x86_64-pc-linux-gnu", "x86_64-cros-linux-gnu"]

_RUSTC_TOOLS = ["rustc", "cargo", "clippy-driver", "rustdoc", "rustfmt"]

# TODO: Remove the default public visibility once the toolchains are also
#       declared in this generated repository.
_RUSTLIB_BUILD_FILE_TEMPLATE = """\
load("@rules_rust//rust:toolchain.bzl", "rust_stdlib_filegroup")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "rustc_libs",
    srcs = glob([
        "lib/*.so",
    ]),
)

rust_stdlib_filegroup(
    name = "rust_libs",
    srcs = glob([
        "lib/*.rlib",
        "lib/*.so",
        "lib/*.a",
    ]),
)
"""

def _impl(repo_ctx):
    # Symlink necessary rustc binaryes and libraries into this repository so
    # that they can be mapped to Bazel labels and tracked as proper dependencies
    # via filegroups.

    # The repository directory structure looks like:
    # rust/
    #   BUILD
    #   bin/
    #       BUILD
    #       {platform triple}/
    #           BUILD
    #           rustc, rustfmt, etc.
    #   lib/
    #       BUILD
    #       {platform triple}/
    #           BUILD
    #           lib/
    #               *.rlib
    #               *.a

    repo_ctx.file("rust/BUILD")

    # Symlink in necessary binaries mentioned in _RUSTC_TOOLS
    repo_ctx.file("rust/bin/BUILD")
    repo_ctx.file(
        "rust/bin/x86_64-pc-linux-gnu/BUILD",
        content = "exports_files({})\n".format(repr(_RUSTC_TOOLS)),
    )
    for tool in _RUSTC_TOOLS:
        repo_ctx.symlink(
            "/usr/bin/{}".format(tool),
            "rust/bin/x86_64-pc-linux-gnu/{}".format(tool),
        )

    repo_ctx.file("rust/lib/BUILD")

    # For each target triple, symlink in every file we find under the
    # appropriate rustlib directory.
    for triple in _TRIPLES:
        repo_ctx.file(
            "rust/lib/{triple}/BUILD".format(triple = triple),
            content = _RUSTLIB_BUILD_FILE_TEMPLATE,
        )

        lib_files = _get_rustlib_filenames(repo_ctx, triple)
        for rustc_file in lib_files:
            repo_ctx.symlink(
                "/usr/lib64/rustlib/{triple}/lib/{file}".format(triple = triple, file = rustc_file),
                "rust/lib/{triple}/lib/{file}".format(triple = triple, file = rustc_file),
            )

cros_rust_repository = repository_rule(
    implementation = _impl,
    local = True,
)
