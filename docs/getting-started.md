# Getting started

## Install

```sh
git clone git@github.com:d-roak/harness.git ~/code/harness
~/code/harness/install.sh
```

What that does:

| Piece | Where it lands |
|---|---|
| skills | symlinks in `~/.agents/skills` (Codex, OpenCode) and `~/.claude/skills` (Claude Code) |
| `AGENTS.md` + `rules/common` | a managed block in `~/.claude/CLAUDE.md`, `~/.codex/AGENTS.md`, `~/.config/opencode/AGENTS.md` |
| hooks | `~/.claude/settings.json`, `~/.codex/hooks.json`, `~/.config/opencode/plugins/harness.js`, see [hooks.md](hooks.md) |
| MCP servers | `~/.claude.json`, `~/.codex/config.toml`, `~/.config/opencode/opencode.json`, see [mcp.md](mcp.md) |
| `bin/memory` | symlink in `~/.local/bin` |

The managed block sits between `<!-- harness:start -->` and `<!-- harness:end -->`. Everything outside it is yours and untouched. Re-run the script after every `git pull`.

## Wire a repo

1. Copy `templates/AGENTS.md` to the repo root. Fill in the gate command and the traps. Delete the placeholders you have nothing for.
2. Pick a CI template from `templates/github/` into `.github/workflows/ci.yml`.
3. Make sure the gate passes on a clean checkout before the first agent session.

## First session

The session-start hook prints your memory index. The agent reads `AGENTS.md`, then the language rule for whatever it touches first. From there:

- vague request: `plan`
- clear request: `implement`
- something broken: `debug`
- before saying done: `verify`
- app runtime lacks repeatable controls: `verification`
- on your instruction only: `ship`
- anything a person will look at or read: `design`, `copy`, `imagegen`

## Uninstall

Delete the managed blocks and the symlinks. The script does not do this for you; it never deletes.
