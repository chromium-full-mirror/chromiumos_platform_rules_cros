workspace(name = "rules_cros")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//cros/toolchain:rust_repository.bzl", "cros_rust_repository")

http_archive(
    name = "rules_rust",
    sha256 = "4d9a243e69a1e9d4f6538ea2c7f2cd8c811ddc6003aa01f16d4a2d69f65d2856",
    strip_prefix = "rules_rust-b188f1b1eb67e2a596c80c362f94b5218b388c7a",
    urls = [
        # `main` branch as of 2022-01-19
        "https://github.com/bazelbuild/rules_rust/archive/b188f1b1eb67e2a596c80c362f94b5218b388c7a.tar.gz",
    ],
)

http_archive(
    name = "bazel_skylib",
    sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
    urls = [
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
    ],
)

cros_rust_repository(name = "cros")
