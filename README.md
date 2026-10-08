# harness

Rules, skills and workflows for the full lifecycle of a software project, from planning to audit to deploy. Built for the stack I actually use, not for completeness.

Works with Claude Code, Codex and OpenCode. Everything is plain markdown in the formats those tools share: `AGENTS.md` for instructions, `SKILL.md` directories for skills.

## Layout

```
AGENTS.md          instructions every tool loads: lifecycle, non-negotiables, stack
rules/common/      always on: workflow, git, style, testing, security
rules/<lang>.md    read on demand: typescript, rust, python, solidity, infra, design, media
skills/<name>/     plan, tdd, implement, debug, review, audit, verify, verification, ship, handoff, memory
                   brand, copy, design, imagegen, videogen, blender
workflows/         feature, bugfix, release, landing-page, media, 3d: which skills, in which order
mcp/               one server list, registered into every tool by the installer
templates/         per-repo AGENTS.md starter, CI workflows for node, rust, foundry
hooks/             guards and formatter, one set of scripts, adapters per tool
bin/               memory plus app-verification-skill generator
docs/              longer-form pages, start at docs/index.md
install.sh         links it all into ~/.agents, ~/.claude, ~/.codex, ~/.config/opencode
test.sh            block/allow cases for every guard and the memory CLI
```

## Install

```sh
git clone git@github.com:d-roak/harness.git ~/code/harness
~/code/harness/install.sh
```

The script symlinks skills into `~/.agents/skills` and `~/.claude/skills`, writes a managed block (`AGENTS.md` plus `rules/common`) into each tool's global instructions file, merges the hooks into Claude Code and Codex settings, drops an OpenCode plugin, and puts `memory` on your PATH. Anything outside the managed block is left alone. Re-run after pulling.

Memory lives in `~/.agents/memory`, one fact per file, never in a repo. `create-verification-skill <repo>` creates that app's local control CLI and Feature Map. Hooks block force pushes, pushes to main, edits to `.env` and lockfiles, and npm in pnpm repos. See `docs/`.

Claude Code can also take it as a plugin:

```
/plugin marketplace add d-roak/harness
/plugin install harness@harness
```

Per repo: copy `templates/AGENTS.md`, fill in the gate and the traps, pick a CI template.

## Stack

TypeScript for frontend and backend (pnpm, React, Vite, Tailwind, Hono, Drizzle). Rust for systems work and backends where performance matters. Solidity via Foundry. Python where a library forces it. Postgres, Docker, Dokploy, Vercel, GitHub Actions.

## Lifecycle

```
plan  →  tdd / implement  →  review  →  verify  →  ship
                 ↑ debug   (something is broken)
                 ↑ audit   (money, auth, data, prod)
```

Each skill says when to use it and which sibling to use instead. Workflows chain them.

## Taste

The model's default output is the baseline to beat. `rules/common/writing.md` bans the words and shapes that mark text as generated. `rules/design.md`, distilled from leonxlnx/taste-skill, does the same for interfaces: named slop patterns, dials set before code, a pre-flight that has to be ticked honestly. `rules/media.md` covers image, video and 3D: prompts as specs, a written bible per set, one deliverable per image, regenerate instead of crop.

## Adding a skill

One directory under `skills/`, one `SKILL.md` with `name` and `description` frontmatter. The description ends with "Use when ...". The body ends with a "Not this skill" section pointing at siblings. Keep it under a page.
