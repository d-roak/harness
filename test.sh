#!/usr/bin/env sh
# The one runnable check. Fails if memory or a guard hook stops doing its job.
set -eu
cd "$(dirname "$0")"
export HARNESS_MEMORY_DIR="$(mktemp -d)"
pass=0; fail=0
ok()   { pass=$((pass+1)); }
bad()  { fail=$((fail+1)); echo "FAIL: $1"; }
blocks() { printf '%s' "$2" | "$1" >/dev/null 2>&1 && bad "$1 allowed: $2" || ok; }
allows() { printf '%s' "$2" | "$1" >/dev/null 2>&1 && ok || bad "$1 blocked: $2"; }

# memory
echo "body" | bin/memory add feedback test-fact "a test fact" >/dev/null
bin/memory list | grep -q 'test-fact.*a test fact' && ok || bad "memory index"
bin/memory show test-fact | grep -q '^type: feedback' && ok || bad "memory show"
echo "x" | bin/memory add bogus slug "d" >/dev/null 2>&1 && bad "memory accepted bad type" || ok
echo "x" | bin/memory add user "Bad Slug" "d" >/dev/null 2>&1 && bad "memory accepted bad slug" || ok
bin/memory rm test-fact; [ -s "$HARNESS_MEMORY_DIR/global/MEMORY.md" ] && bad "memory rm left index" || ok
echo "b" | bin/memory add project repo-fact "repo scoped" --repo >/dev/null
bin/memory context | grep -q '## memory: harness' && ok || bad "memory context in repo"
bin/memory rm repo-fact --repo

# guard-bash
G=hooks/guard-bash.sh
blocks $G '{"tool_input":{"command":"git push --force origin feat"}}'
blocks $G '{"tool_input":{"command":"git push -f"}}'
blocks $G '{"tool_input":{"command":"git push origin main"}}'
blocks $G '{"tool_input":{"command":"git commit -m x --no-verify"}}'
blocks $G '{"tool_input":{"command":"git reset --hard HEAD~1"}}'
blocks $G '{"tool_input":{"command":"rm -rf ~"}}'
allows $G '{"tool_input":{"command":"git push origin feat/thing"}}'
allows $G '{"tool_input":{"command":"git push origin main-backup"}}'
allows $G '{"tool_input":{"command":"rm -rf ./dist"}}'
allows $G '{"tool_input":{"command":"git commit -m \"fix: x\""}}'
allows $G '{"tool_input":{"command":"npm install"}}'   # no pnpm-lock here
d="$(mktemp -d)"; touch "$d/pnpm-lock.yaml"
( cd "$d" && printf '%s' '{"command":"npm install"}' | "$OLDPWD/$G" >/dev/null 2>&1 ) && bad "npm allowed in pnpm repo" || ok
( cd "$d" && printf '%s' '{"command":"pnpm install"}' | "$OLDPWD/$G" >/dev/null 2>&1 ) && ok || bad "pnpm blocked"

# guard-edit
E=hooks/guard-edit.sh
blocks $E '{"tool_input":{"file_path":"/x/app/.env"}}'
blocks $E '{"tool_input":{"file_path":"/x/app/pnpm-lock.yaml"}}'
allows $E '{"tool_input":{"file_path":"/x/app/.env.example"}}'
allows $E '{"tool_input":{"file_path":"/x/app/src/env.ts"}}'
allows $E '{"path":"/x/app/README.md"}'

# session-start prints something and never fails
hooks/session-start.sh | grep -q 'harness:' && ok || bad "session-start"

rm -rf "$HARNESS_MEMORY_DIR" "$d"
echo "$pass passed, $fail failed"; [ "$fail" -eq 0 ]
