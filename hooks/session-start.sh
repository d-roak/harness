#!/usr/bin/env sh
# Prints memory index and the rules pointer into the session context. Never blocks.
HARNESS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
"$HARNESS_DIR/bin/memory" context
echo
echo "harness: language rules at $HARNESS_DIR/rules/<lang>.md, read on first contact. Skills: plan tdd implement debug review audit verify ship handoff memory."
exit 0
