# Memory

Personal, file-based, outside every repo, shared by every tool.

```
~/.agents/memory/
  global/
    MEMORY.md          index, one line per fact
    <slug>.md          one fact
  repos/<repo-name>/
    MEMORY.md
    <slug>.md
```

A fact:

```md
---
name: pnpm-only
description: Never npm or yarn, pnpm everywhere
type: feedback
created: 2026-09-07
---

Ran npm install in a pnpm repo, created package-lock.json.
Why: two lockfiles drift and CI uses pnpm --frozen-lockfile.
How to apply: check for pnpm-lock.yaml before any install command.
```

Types: `user` (who you are, preferences), `feedback` (a correction and how to avoid it), `project` (a decision or trap the code does not explain), `reference` (a URL, ticket, dashboard).

## Commands

```
memory add <type> <slug> "<description>" [--repo]   body on stdin
memory list [--repo]
memory show <slug> [--repo]
memory search <term>
memory rm <slug> [--repo]
memory context                                      global + current repo index
```

`--repo` scopes to the git repo you are standing in, by directory name. Set `HARNESS_MEMORY_DIR` to move the root.

## How it flows

1. Session start: the hook runs `memory context`. The agent sees the indexes, not the bodies.
2. During work: the agent opens a fact only when its description matches the task.
3. After a correction: the agent runs `memory add feedback ...`. This is the rule in `workflow.md`, and the `memory` skill spells it out.
4. Wrong fact: `memory rm`. No tombstones.

## Why not in the repo

Memory is about you and your sessions, not the code. Committing it leaks working notes to collaborators and to public repos. Repo-level knowledge that everyone should have goes in the repo's `AGENTS.md`.

## Why not a database

`grep` is the query engine. The whole store is readable with `cat`. Every tool can consume it with no client. Move to something else when the index passes a few hundred lines.
