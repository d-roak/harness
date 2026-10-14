#!/usr/bin/env sh
# Installs harness targets. Idempotent, never deletes user-owned content.
set -eu

HARNESS_DIR="$(cd "$(dirname "$0")" && pwd)"
export HARNESS_DIR

if [ "$#" -gt 1 ]; then
	echo "usage: $0 [all|claude|codex|opencode|mcp]" >&2
	exit 1
fi

target="${1:-all}"
case "$target" in
	all|claude|codex|opencode|mcp) ;;
	*)
		echo "install: unknown target '$target'; allowed: all, claude, codex, opencode, mcp" >&2
		exit 1
		;;
esac

. "$HARNESS_DIR/install-lib.sh"

case "$target" in
	all)
		install_shared
		install_claude
		install_codex
		install_opencode
		install_mcp
		echo "all: done"
		echo "Codex asks you to trust new hooks once: run /hooks inside codex."
		;;
	claude) install_claude ;;
	codex) install_codex ;;
	opencode) install_opencode ;;
	mcp) install_mcp ;;
esac
