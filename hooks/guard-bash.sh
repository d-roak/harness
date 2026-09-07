#!/usr/bin/env sh
# Blocks shell commands the rules forbid. Reads the tool call JSON on stdin and
# matches on the raw text so it works with every tool's field names.
# ponytail: regex on raw JSON, parse it properly if a tool ever nests commands
input="$(cat)"
deny() { echo "harness: blocked. $1" >&2; exit 2; }

echo "$input" | grep -Eq 'git push[^"]*( -f| --force)' && deny "No force push. Rebase locally, push a new branch if you must."
echo "$input" | grep -Eq 'git push[^"]*(origin|upstream) +(main|master)([^a-z0-9-]|$)' && deny "Never push to main. Branch and PR."
echo "$input" | grep -Eq 'git (commit|push)[^"]*--no-verify' && deny "--no-verify skips the gate. Fix what the hook complains about."
echo "$input" | grep -Eq 'git reset --hard|git clean -[a-zA-Z]*f|git checkout -- \.|git restore \.' && deny "Destructive git on the working tree. Ask first."
echo "$input" | grep -Eq 'rm -rf? +(/|~|\$HOME)( |\\"|"|$)' && deny "rm -rf on root or home."
if [ -f pnpm-lock.yaml ]; then
	echo "$input" | grep -Eq '(^|[^a-z])(npm|yarn) +(i|install|add|remove|ci)([^a-z]|$)' && deny "This repo uses pnpm."
fi
exit 0
