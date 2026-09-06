#!/usr/bin/env sh
# Links harness into every agent tool that reads the open formats.
#   skills  -> ~/.agents/skills (Codex, OpenCode, skills.sh), ~/.claude/skills, ~/.codex/skills, ~/.config/opencode/skill
#   rules   -> a managed block in the global instructions file of each tool
# Idempotent. Re-run after pulling.
set -eu

HARNESS_DIR="$(cd "$(dirname "$0")" && pwd)"
START='<!-- harness:start -->'
END='<!-- harness:end -->'

link_skills() {
	dir="$1"
	mkdir -p "$dir"
	for s in "$HARNESS_DIR"/skills/*/; do
		name="$(basename "$s")"
		ln -sfn "$s" "$dir/$name"
	done
	echo "skills -> $dir"
}

# Replace the managed block in a file, or append it. Everything outside the block is left alone.
write_block() {
	file="$1"
	mkdir -p "$(dirname "$file")"
	touch "$file"
	tmp="$(mktemp)"
	{
		# ponytail: awk state machine, swap for a real templater if the block ever needs params
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

link_skills "$HOME/.agents/skills"
link_skills "$HOME/.claude/skills"
link_skills "$HOME/.codex/skills"
link_skills "$HOME/.config/opencode/skill"

write_block "$HOME/.codex/AGENTS.md"
write_block "$HOME/.config/opencode/AGENTS.md"
write_block "$HOME/.claude/CLAUDE.md"

echo "done. language rules stay on disk at $HARNESS_DIR/rules and are read on demand."
