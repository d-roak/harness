# harness

Rules, skills and workflows for the whole lifecycle: plan, build, test, review, audit, ship.
Written for any coding agent (Claude Code, Codex, OpenCode) — plain markdown, no tool-specific syntax.

## How this is organised

- `rules/common/` — always on. Workflow, git, style, testing, security.
- `rules/<lang>.md` — read on demand. typescript, rust, python, solidity, infra, and for anything visual: design, media.
- `skills/<name>/SKILL.md` — a procedure the agent runs on demand. Each one says when to use it and what it does not cover.
- `workflows/` — which skills to chain, in what order, for a feature, a bugfix, a release.
- `templates/` — starters for a repo: `AGENTS.md`, CI workflows.
- `mcp/` — the MCP servers every tool gets: blender, playwright, chrome-devtools, higgsfield, fal.
- `hooks/` — mechanical guards: no force push, no push to main, no `.env` edits. Same scripts for every tool.
- `bin/memory` — facts that outlive a session, in `~/.agents/memory`. The session-start hook shows the index.

## The lifecycle

```
plan  →  tdd / implement  →  review  →  verify  →  ship
                 ↑ debug (when something is broken)
                 ↑ audit (before anything touches money, auth or prod)
```

Skills map to those stages one to one. `memory` runs underneath: recall at start, record after a correction.

Creative work has its own stages: `brand` → `copy` → `imagegen` / `videogen` / `blender` → `design` → `implement`. Same review and verify gates. See `workflows/landing-page.md`, `media.md`, `3d.md`. A feature goes through all of them. A typo fix goes through `verify` and `ship`.

## Non-negotiables

Read `rules/common/*.md`. The short version:

1. Plan before any task with three or more steps. Re-plan when it goes sideways.
2. Nothing is done until it is proven: run the gate, show the output.
3. Never commit, push, or open a PR unless told to. One instruction, one action.
4. Simplest change that works. No abstractions for one caller. Delete before you add.
5. Reject bad input loudly. No silent fallbacks, no empty catch.
6. Phosphor icons, pnpm, Vitest, Prettier. Not Lucide, npm, Jest, Biome.
7. No slop. Text passes `writing.md`, interfaces pass `design.md`, generated media passes `media.md`. The model's default output is the thing to avoid.

## Stack

TypeScript first, frontend and backend (pnpm, React, Vite, Tailwind, shadcn, Hono, Drizzle, Better Auth, TanStack).
Rust for systems programming and backends where performance matters (axum, sqlx, tokio). Solidity via Foundry. Python where a library forces it (uv, pytest).
Postgres. Docker + Dokploy for self-hosted, Vercel and GitHub Pages for static, GitHub Actions for CI.

## Language

`HARNESS_DIR` is where this repo lives. Read `$HARNESS_DIR/rules/<lang>.md` on first contact with a language in a session.
