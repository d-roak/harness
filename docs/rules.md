# Rules

Two layers.

## Always on: `rules/common/`

Concatenated into the managed block by `install.sh`, so every session starts with them.

| File | Covers |
|---|---|
| `workflow.md` | plan first, change vs investigate, scope, subagents, done means proven, simplicity |
| `git.md` | never commit or push unasked, one instruction one action, conventional commits, no attribution |
| `style.md` | code style, negative-space programming, prose without AI tells |
| `testing.md` | seams, rejections, real deps, runners, the gate |
| `security.md` | secrets, boundaries, auth, SQL, least privilege, when to `audit` |
| `writing.md` | banned words and shapes, rhythm, UI copy, prompts as specs |

## On demand: `rules/<lang>.md`

Not loaded by default. `AGENTS.md` tells the agent to read the file on first contact with a language in a session. Keeps the always-on context small.

| File | Stack |
|---|---|
| `typescript.md` | pnpm, Vite, Vitest, React, Tailwind, shadcn, Hono, Drizzle, Better Auth, TanStack |
| `rust.md` | cargo workspace, thiserror/anyhow, axum, sqlx, tracing |
| `python.md` | uv, ruff, pytest, dataclasses |
| `solidity.md` | Foundry, OpenZeppelin, CEI, fuzz and invariant tests, Slither |
| `infra.md` | Docker, Dokploy, Vercel, GitHub Pages, GitHub Actions, Postgres |
| `design.md` | UI taste: slop by name, dials, type, colour, layout, hero, motion, pre-flight |
| `media.md` | image, video, 3D: prompts as specs, the bible, sets, rejection rules |

## Editing rules

A rule earns its line by being broken once. Add it with the reason. Remove rules that a hook now enforces mechanically, unless the wording still helps the agent understand why.
