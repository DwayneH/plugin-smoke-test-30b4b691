#!/usr/bin/env bash
# Test for debug env test
set -euo pipefail

echo "Running debug env test..."

# Test that hello.sh outputs "hello"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
output="$(bash "$SCRIPT_DIR/hello.sh")"

if [ "$output" = "hello" ]; then
  echo "PASS: hello.sh outputs 'hello'"
else
  echo "FAIL: expected 'hello', got '$output'"
  exit 1
fi

echo "All tests passed."
