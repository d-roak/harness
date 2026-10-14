#!/usr/bin/env sh
# MCP-only compatibility entry point. The implementation lives in ../install-lib.sh.
set -eu

HARNESS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export HARNESS_DIR
. "$HARNESS_DIR/install-lib.sh"
install_mcp
