#!/usr/bin/env sh
# Blocks edits to files agents must not touch by hand.
input="$(cat)"
deny() { echo "harness: blocked. $1" >&2; exit 2; }
path="$(echo "$input" | sed -n 's/.*"\(file_\)\{0,1\}path":"\([^"]*\)".*/\2/p' | head -1)"
[ -n "$path" ] || exit 0
case "$(basename "$path")" in
	.env|.env.local|.env.production|.env.development) deny ".env holds secrets. Edit .env.example and tell the user." ;;
	pnpm-lock.yaml|package-lock.json|yarn.lock|Cargo.lock|uv.lock) deny "Lockfiles are generated. Run the package manager." ;;
esac
exit 0
