#!/usr/bin/env bash

set -u

rc=0

echo "=== Testing armel ==="
if /usr/libexec/arch-test/armel; then
  echo "armel: PASS"
else
  echo "armel: FAIL"
  rc=1
fi

echo
echo "=== Testing armhf ==="
if /usr/libexec/arch-test/armhf; then
  echo "armhf: PASS"
else
  echo "armhf: FAIL"
  rc=1
fi

echo
if [ "$rc" -eq 0 ]; then
  echo "All architecture tests passed."
else
  echo "One or more architecture tests failed."
fi

exit "$rc"
