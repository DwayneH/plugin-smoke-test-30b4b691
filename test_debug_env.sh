#!/usr/bin/env bash
# Extended debug environment validation tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PASS=0
FAIL=0

pass() {
  echo "PASS: $1"
  PASS=$((PASS + 1))
}

fail() {
  echo "FAIL: $1"
  FAIL=$((FAIL + 1))
}

echo "Running debug environment tests..."

# Test 1: hello.sh outputs exactly "hello"
output="$(bash "$SCRIPT_DIR/hello.sh")"
if [ "$output" = "hello" ]; then
  pass "hello.sh outputs 'hello'"
else
  fail "expected 'hello', got '$output'"
fi

# Test 2: hello.sh exits with code 0
if bash "$SCRIPT_DIR/hello.sh" > /dev/null 2>&1; then
  pass "hello.sh exits with code 0"
else
  fail "hello.sh exited with non-zero code"
fi

# Test 3: hello.sh is executable
if [ -x "$SCRIPT_DIR/hello.sh" ]; then
  pass "hello.sh is executable"
else
  fail "hello.sh is not executable"
fi

# Test 4: bash is available
if command -v bash > /dev/null 2>&1; then
  pass "bash is available"
else
  fail "bash is not available"
fi

# Test 5: git is available
if command -v git > /dev/null 2>&1; then
  pass "git is available"
else
  fail "git is not available"
fi

# Summary
echo ""
echo "Results: $PASS passed, $FAIL failed"

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi

echo "All debug environment tests passed."
