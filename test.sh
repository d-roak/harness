#!/usr/bin/env sh
# The one runnable check. Fails if memory or a guard hook stops doing its job.
set -eu
HARNESS_DIR="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
cd "$HARNESS_DIR"
TMP="$(mktemp -d)"
export HOME="$TMP/home"
export HARNESS_MEMORY_DIR="$TMP/memory"
trap 'rm -rf "$TMP"' EXIT
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
echo "x" | bin/memory add user safe "bad: description" >/dev/null 2>&1 && bad "memory accepted unsafe description" || ok
bin/memory show ../../etc/passwd >/dev/null 2>&1 && bad "memory show accepted traversal" || ok
bin/memory rm ../../sentinel >/dev/null 2>&1 && bad "memory rm accepted traversal" || ok
bin/memory rm absent >/dev/null && ok || bad "memory rm missing scope"
bin/memory rm test-fact; [ -s "$HARNESS_MEMORY_DIR/global/MEMORY.md" ] && bad "memory rm left index" || ok
echo "b" | bin/memory add project repo-fact "repo scoped" --repo >/dev/null
repo_name="$(git rev-parse --git-common-dir | xargs dirname | xargs basename)"
bin/memory context | grep -q "## memory: $repo_name" && ok || bad "memory context in repo"
bin/memory rm repo-fact --repo

# guard-bash
G=hooks/guard-bash.sh
blocks $G '{"tool_input":{"command":"git push --force origin feat"}}'
blocks $G '{"tool_input":{"command":"git push -f"}}'
blocks $G '{"tool_input":{"command":"git push --force-with-lease origin feat"}}'
blocks $G '{"tool_input":{"command":"git push github main"}}'
blocks $G '{"tool_input":{"command":"git commit -m x --no-verify"}}'
blocks $G '{"tool_input":{"command":"git commit -m \\"x\\" --no-verify"}}'
blocks $G '{"tool_input":{"command":"git reset --hard HEAD~1"}}'
blocks $G '{"tool_input":{"command":"rm -rf ~"}}'
blocks $G '{"tool_input":{"command":"rm -fr /"}}'
blocks $G '{"tool_input":{"command":"rm --force --recursive -- /Users/test"}}'
allows $G '{"tool_input":{"command":"git push origin feat/thing"}}'
allows $G '{"tool_input":{"command":"git push origin main-backup"}}'
allows $G '{"tool_input":{"command":"rm -rf ./dist"}}'
allows $G '{"tool_input":{"command":"git commit -m \"fix: x\""}}'
allows $G '{"tool_input":{"command":"npm install"}}'   # no pnpm-lock here
d="$(mktemp -d)"; touch "$d/pnpm-lock.yaml"
( cd "$d" && printf '%s' '{"command":"npm install"}' | "$HARNESS_DIR/$G" >/dev/null 2>&1 ) && bad "npm allowed in pnpm repo" || ok
( cd "$d" && printf '%s' '{"command":"pnpm install"}' | "$HARNESS_DIR/$G" >/dev/null 2>&1 ) && ok || bad "pnpm blocked"

# installers preserve user-owned collisions
mkdir -p "$HOME/.config/opencode" "$HOME/.codex"
printf '%s\n' '{"mcpServers":{"blender":{"command":"user-blender"}}}' > "$HOME/.claude.json"
printf '%s\n' '{"mcp":{"blender":{"type":"local","command":["user-blender"]}}}' > "$HOME/.config/opencode/opencode.json"
printf '%s\n' '[mcp_servers.blender]' 'command = "user-blender"' > "$HOME/.codex/config.toml"
mcp/install.sh >/dev/null
python3 - "$HOME" <<'PY' && ok || bad "mcp preserved user collisions"
import json, pathlib, sys
home = pathlib.Path(sys.argv[1])
assert json.loads((home / '.claude.json').read_text())['mcpServers']['blender']['command'] == 'user-blender'
assert json.loads((home / '.config/opencode/opencode.json').read_text())['mcp']['blender']['command'] == ['user-blender']
toml = (home / '.codex/config.toml').read_text()
assert toml.count('[mcp_servers.blender]') == 1 and 'command = "user-blender"' in toml
PY
before="$(cat "$HOME/.claude.json" "$HOME/.config/opencode/opencode.json" "$HOME/.codex/config.toml")"
mcp/install.sh >/dev/null
after="$(cat "$HOME/.claude.json" "$HOME/.config/opencode/opencode.json" "$HOME/.codex/config.toml")"
[ "$before" = "$after" ] && ok || bad "mcp install idempotence"
mkdir -p "$HOME/.agents/skills/plan"
( ./install.sh >/dev/null 2>&1 ) && bad "installer replaced skill directory" || ok
[ ! -e "$HOME/.agents/skills/plan/plan" ] && ok || bad "installer nested skill link"

# verification template
fixture="$(mktemp -d)"; git -C "$fixture" init -q
bin/create-verification-skill "$fixture" >/dev/null
node "$fixture/.claude/skills/verify-app/control-app.test.mjs" && ok || bad "verification template"
test -f "$fixture/.claude/skills/verify-app/references/features/example-feature.md" && ok || bad "verification feature map"
grep -q '## Sub-features' "$fixture/.claude/skills/verify-app/references/features/example-feature.md" && grep -q 'multi-surface-journeys.md' "$fixture/.claude/skills/verify-app/references/features/README.md" && ok || bad "verification feature map shape"
mkdir "$fixture/nested"
bin/create-verification-skill "$fixture/nested" >/dev/null 2>&1 && bad "verification generator accepted nested target" || ok
bin/create-verification-skill "$fixture" >/dev/null 2>&1 && bad "verification generator overwrote skill" || ok
rm -rf "$fixture"

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
