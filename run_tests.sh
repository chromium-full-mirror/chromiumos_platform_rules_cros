#!/bin/bash
#
# Copyright 2022 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Runs the rules_cros tests.  Must be run in the chroot.

if ! test -f "/etc/cros_chroot_version"; then
  echo "Must be run in the chroot."
  exit 1
fi

cd $(dirname ${BASH_SOURCE[0]})
bazel-5 test --test_output=all //test:rules_cros_toolchain_test
