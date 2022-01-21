# Chrome OS Bazel Rules

## Overview

This repository provides common rules and configuration for Bazel projects in
Chrome OS.

## Usage

`rules_cros` is only expected to function inside the Chrome OS SDK. You may copy
the following snippet into your WORKSPACE file and fix up the relative path in
`local_repository` to point from your project to where `rules_cros` is checked
out.

```python
local_repository(
    name = "rules_cros",
    path = "../src/platform/rules_cros",
)

load("@rules_cros//cros:repositories.bzl", "rules_cros_dependencies")

rules_cros_dependencies()
```

You will also need to symlink `.bazelrc` in the root of your project to
[common.bazelrc](common.bazelrc) in this repo. You can put additional settings
in a file named `user.bazelrc` in the root of your WORKSPACE and it will
automatically be imported by `common.bazelrc`.

## Documentation

The code is this directory is experimental and under active development.
Stability and functionality is not guaranteed :)
