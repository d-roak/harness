---
name: memory
description: Recall and record facts that outlive a session, using the shared file-based memory in ~/.agents/memory. Use at session start, after any user correction, and when a decision or trap is worth keeping.
---

# memory

Memory lives in `~/.agents/memory`, never in a repo. `bin/memory` is the only writer. Every tool reads the same files.

## Recall (session start)
1. `memory context` prints the global index and the current repo's index. The session-start hook does this for you; if it did not run, do it by hand.
2. Open a fact (`memory show <slug> [--repo]`) only when its description is relevant to the task. The index is cheap, the bodies are not.
3. A fact names a file, flag or command? Check it still exists before acting on it.

## Record
Write when one of these happens, not before:
- The user corrects you. Type `feedback`. Body says what went wrong, why it matters, how to avoid it.
- A decision was made that the code does not explain. Type `project`, scope `--repo`.
- Something cost more than ten minutes and will again. Type `project`, scope `--repo`.
- A stable fact about the user's setup or preferences. Type `user`.
- A URL, dashboard, ticket. Type `reference`.

```sh
memory add feedback pnpm-only "Never npm or yarn, pnpm everywhere" <<'EOF'
Ran npm install in a pnpm repo, created package-lock.json.
Why: two lockfiles drift and CI uses pnpm --frozen-lockfile.
How to apply: check for pnpm-lock.yaml before any install command.
EOF
```

## Do not record
- What the repo already says (README, AGENTS.md, git log).
- Anything that only matters this session.
- Secrets. Ever.

## Maintain
- A fact turns out wrong: `memory rm <slug>`. Do not leave it with a note.
- Same fact twice: re-run `memory add` with the same slug, it overwrites and reindexes.

## Not this skill
- Handing over unfinished work: `handoff`.
