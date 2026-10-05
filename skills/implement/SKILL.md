---
name: implement
description: Build a planned task in an existing codebase, matching its patterns, with the smallest diff that satisfies the spec. Use after `plan`, or for any change request that is clear enough to skip planning.
---

# implement

## Before writing
1. Read the repo's `AGENTS.md`, then the language rules for what you are touching.
2. Find the nearest existing example of the same kind of thing (a handler, a component, a migration). Copy its shape. Do not invent a second convention.
3. Run the gate once before changing anything so you know what "green" looked like.
4. For a third-party client, build one vertical path first: strict input, provider call at one boundary, normalized result or error, bounded timeout. Use the existing SDK or native `fetch`; defer abstractions until a second provider or caller exists.

## While writing
- Smallest diff. Fewest files. Delete before adding.
- Stdlib → platform feature → already-installed dependency → new code. Never a new dependency for what a few lines do.
- Guard clauses first, with a message that says what was expected. Reject unknown input with the list of what is allowed.
- No `any`, no `unwrap()`, no empty catch, no `?? default` that hides a bug.
- A deliberate shortcut gets a comment: `// ponytail: <what>, <upgrade path>`.
- Any state change a user cares about emits an event or a log line with structured fields.

## After writing
- Run the gate. Paste the tail of the output, not "tests pass".
- Non-trivial logic leaves one runnable check behind (see `tdd`).
- For external writes, verify idempotency or replay safety. State a skipped production smoke first when credentials or approval are unavailable.
- Update docs the change made wrong. Do not add docs the change does not need.
- Hand over to `review` for anything beyond a one-liner.

## Not this skill
- Deciding what to build: `plan`.
- Something already broken: `debug`.
- Commit, PR, deploy: `ship`.
