---
name: tdd
description: Red-green-refactor loop for a piece of behaviour with a clear seam. Use when a spec lists constraints, when touching money, auth, parsing or arithmetic, or when the user asks for tests first.
---

# tdd

## When
- The behaviour has a callable seam: a function, a handler, a contract method.
- The spec has "must never" lines.
- Bug with a reproducible input (write the failing test first, then go to `debug`).

## Loop

1. **Red.** Write one test that fails for the right reason. Run it. Read the failure. If it fails because of a typo or a missing import, that is not red.
2. **Green.** The least code that passes. Ugly is fine. No extra cases.
3. **Refactor.** Remove duplication, name things, keep it green. Run the whole file, not only the new test.
4. Next constraint. Rejections before happy paths: the guard tests are the ones that matter.

## Rules
- One assertion of behaviour per test. The name says what is expected: `rejects_negative_amount`, not `test1`.
- Real dependencies where cheap (tmp dir, docker Postgres). Mock only the network edge.
- Property tests when the input has structure: fast-check, proptest, `forge` fuzz.
- Do not test private helpers. If you want to, the seam is wrong.
- Never edit a test to make it pass unless the test was wrong. Say so if it was.

## Runners
Vitest · `cargo test` · `forge test -vvv` · pytest. Use the repo's script, not a bare runner.

## Not this skill
- Code with no seam yet (a new page, glue): `implement`, then add a check.
- Full-suite health, coverage: `verify`.
