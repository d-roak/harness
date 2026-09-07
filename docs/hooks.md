# Hooks

Guards that a prompt alone cannot enforce. Four shell scripts in `hooks/`, shared by every tool. Each reads the tool call as JSON on stdin and matches on the raw text, so the field names of a given tool do not matter.

| Script | Event | Does |
|---|---|---|
| `session-start.sh` | session start | prints `memory context` and a pointer to the language rules. Never blocks. |
| `guard-bash.sh` | before a shell command | blocks force push, push to main, `--no-verify`, `git reset --hard` and friends, `rm -rf` on root or home, npm/yarn in a pnpm repo |
| `guard-edit.sh` | before a file edit | blocks edits to `.env*` (not `.env.example`) and lockfiles |
| `format.sh` | after a file edit | runs prettier, rustfmt, ruff or forge fmt if the repo has it. Never blocks. |

Contract: `exit 2` with a one-line reason on stderr blocks and the reason reaches the model. `exit 0` allows. Stdout from `session-start.sh` becomes context.

## Wiring

`install.sh` does all of this. Listed so you know what to look at when something does not fire.

| Tool | Where | How |
|---|---|---|
| Claude Code | `~/.claude/settings.json` | `hooks/hooks.json` merged into the `hooks` key. Existing entries kept, harness entries replaced. |
| Codex | `~/.codex/hooks.json` | same file, same merge. Codex uses Claude Code's format. Run `/hooks` inside Codex once to trust them. |
| OpenCode | `~/.config/opencode/plugins/harness.js` | a plugin that calls the scripts on `tool.execute.before` / `after` and pushes session context via the system-prompt transform. Throws on exit 2. |

## Testing a hook

```sh
printf '%s' '{"tool_input":{"command":"git push -f"}}' | hooks/guard-bash.sh; echo "exit $?"
```

`./test.sh` runs the block-and-allow cases for every guard. Add a case when you add a pattern.

## What is deliberately not hooked

- Commit and push themselves. The rule is "only on instruction", and a hook cannot see the instruction. The prompt handles it; the guard stops the dangerous variants.
- Running the gate on stop. It would fire on every tiny turn. `verify` runs it when the task says done.
- Anything that needs a network call. Hooks run on every tool call; keep them under a few milliseconds.
