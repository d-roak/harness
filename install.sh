#!/usr/bin/env sh
# Links harness into every agent tool that reads the open formats. Idempotent, never deletes.
#   skills  -> ~/.agents/skills (Codex, OpenCode), ~/.claude/skills (Claude Code)
#   rules   -> managed block in each tool's global instructions file
#   hooks   -> ~/.claude/settings.json and ~/.codex/hooks.json (same format), ~/.config/opencode/plugins/harness.js
#   mcp     -> ~/.claude.json, ~/.codex/config.toml, ~/.config/opencode/opencode.json (see mcp/install.sh)
#   memory  -> ~/.local/bin/memory
set -eu

HARNESS_DIR="$(cd "$(dirname "$0")" && pwd)"
START='<!-- harness:start -->'
END='<!-- harness:end -->'

link_skills() {
	mkdir -p "$1"
	for s in "$HARNESS_DIR"/skills/*/; do
		dest="$1/$(basename "$s")"
		if [ -e "$dest" ] && [ ! -L "$dest" ]; then
			echo "skills: refusing to replace existing path: $dest" >&2
			return 1
		fi
		ln -sfn "$s" "$dest"
	done
	echo "skills -> $1"
}

# Replace the managed block in a file, or append it. Everything outside the block is left alone.
write_block() {
	file="$1"; mkdir -p "$(dirname "$file")"; touch "$file"
	tmp="$(mktemp)"
	{
		awk -v s="$START" -v e="$END" '$0==s{skip=1} !skip{print} $0==e{skip=0}' "$file"
		echo "$START"
		echo "<!-- managed by $HARNESS_DIR/install.sh, edits here are overwritten -->"
		sed "s|\$HARNESS_DIR|$HARNESS_DIR|g" "$HARNESS_DIR/AGENTS.md"
		for r in "$HARNESS_DIR"/rules/common/*.md; do echo; cat "$r"; done
		echo "$END"
	} > "$tmp"
	mv "$tmp" "$file"
	echo "rules  -> $file"
}

# Merge hooks/hooks.json into a settings file. Harness entries (command under HARNESS_DIR) are replaced, everything else kept.
merge_hooks() {
	file="$1"; mkdir -p "$(dirname "$file")"
	[ -s "$file" ] || echo '{}' > "$file"
	HARNESS_DIR="$HARNESS_DIR" python3 - "$file" <<'PY'
import json, os, sys
path, hd = sys.argv[1], os.environ["HARNESS_DIR"]
cfg = json.load(open(path))
ours = json.loads(open(f"{hd}/hooks/hooks.json").read().replace("$HARNESS_DIR", hd))["hooks"]
hooks = cfg.setdefault("hooks", {})
if not isinstance(hooks, dict):
    raise SystemExit(f"{path}: hooks must be an object")
for event, entries in ours.items():
    current = hooks.get(event, [])
    if not isinstance(current, list) or any(not isinstance(entry, dict) or not isinstance(entry.get("hooks", []), list) for entry in current):
        raise SystemExit(f"{path}: hooks.{event} must be a list of hook objects")
    kept = [entry for entry in current if not any(isinstance(hook, dict) and hd in hook.get("command", "") for hook in entry["hooks"])]
    hooks[event] = kept + entries
json.dump(cfg, open(path, "w"), indent=2); open(path, "a").write("\n")
PY
	echo "hooks  -> $file"
}

link_skills "$HOME/.agents/skills"
link_skills "$HOME/.claude/skills"
link_skills "$HOME/.codex/skills"
link_skills "$HOME/.config/opencode/skill"

write_block "$HOME/.claude/CLAUDE.md"
write_block "$HOME/.codex/AGENTS.md"
write_block "$HOME/.config/opencode/AGENTS.md"

merge_hooks "$HOME/.claude/settings.json"
merge_hooks "$HOME/.codex/hooks.json"
mkdir -p "$HOME/.config/opencode/plugins"
sed "s|\$HARNESS_DIR|$HARNESS_DIR|g" "$HARNESS_DIR/hooks/opencode.js" > "$HOME/.config/opencode/plugins/harness.js"
echo "hooks  -> $HOME/.config/opencode/plugins/harness.js"

"$HARNESS_DIR/mcp/install.sh"

mkdir -p "$HOME/.local/bin"; ln -sfn "$HARNESS_DIR/bin/memory" "$HOME/.local/bin/memory"
echo "memory -> $HOME/.local/bin/memory (make sure ~/.local/bin is on PATH)"

echo "done. Codex asks you to trust new hooks once: run /hooks inside codex."
