---
name: review
description: Review a diff, branch or PR for correctness, rule compliance and things to delete. Use before verify on any change larger than a one-liner, and on request for any PR.
---

# review

Output is a ranked list. Most severe first. One line per finding: file:line, what is wrong, what to do instead. Nothing praised. Empty list is a valid result.

## Pass 1: correctness
- Every branch reachable? Every error path handled or deliberately propagated?
- Input at trust boundaries validated with a strict schema? Unknown values rejected, not ignored?
- Concurrency: shared state, double submit, idempotency of job handlers and webhooks.
- Off-by-one, timezone, float money, unbounded loops, N+1 queries.
- Migration reversible or forward-only by design? Runs on a populated table without a lock?

## Pass 2: rules
- `rules/common/style.md` negative-space list: guards, allowlists, exhaustive switch, no silent fallback.
- Language rules: no `any`, no `unwrap()`, no bare `except`, no `require` strings in Solidity.
- Toolchain: pnpm, Vitest, Prettier, Phosphor. Nothing else snuck in.
- Prose in UI copy and docs passes the banned-words list.
- Nothing committed that should not be: `.env`, credentials, generated files.

## Pass 3: delete
- Abstractions with one caller. Config for constants. Dead flexibility.
- A dependency added for something the stdlib or an existing dep does.
- Tests that test the mock.
- Comments that restate the code.

## Pass 4: tests
- Every "must not" in the spec has a test that fires.
- Tests would fail if the logic broke. Rename-safe.

## Rules
- Read the whole diff before writing a finding. Verify each finding against the actual code, not the diff context.
- Findings, not vibes. If you cannot name the failing input, it is a "consider", listed last.

## Not this skill
- Security-specific depth: `audit`.
- Running the gate: `verify`.
