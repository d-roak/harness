#!/usr/bin/env sh
# After an edit, format the file with whatever the repo already uses. Never blocks.
input="$(cat)"
file="$(echo "$input" | sed -n 's/.*"\(file_\)\{0,1\}path":"\([^"]*\)".*/\2/p' | head -1)"
[ -n "$file" ] && [ -f "$file" ] || exit 0
case "$file" in
	*.ts|*.tsx|*.js|*.jsx|*.json|*.css|*.md|*.yml|*.yaml)
		[ -x node_modules/.bin/prettier ] && node_modules/.bin/prettier --write --log-level silent "$file" ;;
	*.rs) command -v rustfmt >/dev/null && rustfmt --edition 2021 "$file" ;;
	*.py) command -v ruff >/dev/null && ruff format -q "$file" ;;
	*.sol) command -v forge >/dev/null && forge fmt "$file" ;;
esac
exit 0
