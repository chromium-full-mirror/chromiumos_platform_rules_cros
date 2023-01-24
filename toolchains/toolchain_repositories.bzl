load("//rules_cros/toolchains/nasm:repositories.bzl", "nasm_repositories")
load("//rules_cros/toolchains/perl:repositories.bzl", "perl_repositories")
load("//rules_cros/toolchains/rules_proto_grpc:repositories.bzl", "rules_proto_grpc_repositories")
load("//rules_cros/toolchains/rust:repositories.bzl", "rust_repositories")

def toolchain_repositories():
    nasm_repositories()
    perl_repositories()
    rules_proto_grpc_repositories()
    rust_repositories()
