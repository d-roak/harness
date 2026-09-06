# harness

Rules, skills and workflows for the full lifecycle of a software project, from planning to audit to deploy. Built for the stack I actually use, not for completeness.

Works with Claude Code, Codex and OpenCode. Everything is plain markdown in the formats those tools share: `AGENTS.md` for instructions, `SKILL.md` directories for skills.

## Layout

```
AGENTS.md          instructions every tool loads: lifecycle, non-negotiables, stack
rules/common/      always on: workflow, git, style, testing, security
rules/<lang>.md    read on demand: typescript, rust, python, solidity, infra
skills/<name>/     plan, tdd, implement, debug, review, audit, verify, ship, handoff
workflows/         feature, bugfix, release: which skills, in which order
templates/         per-repo AGENTS.md starter, CI workflows for node, rust, foundry
install.sh         links it all into ~/.agents, ~/.claude, ~/.codex, ~/.config/opencode
```

## Install

```sh
git clone git@github.com:d-roak/harness.git ~/code/harness
~/code/harness/install.sh
```

The script symlinks each skill into the skills directory of every tool and writes a managed block (`AGENTS.md` plus `rules/common`) into each tool's global instructions file. Anything outside the block is left alone. Re-run after pulling.

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

## Adding a skill

One directory under `skills/`, one `SKILL.md` with `name` and `description` frontmatter. The description ends with "Use when ...". The body ends with a "Not this skill" section pointing at siblings. Keep it under a page.
