---
name: verify
description: Prove a change works before calling it done. Run the repo's gate, diff behaviour against main when relevant, and report faithfully. Use at the end of every task, no matter how small.
---

# verify

"Done" is a claim. This skill is the evidence.

## Steps
1. **Gate.** The repo's own chain from `AGENTS.md` or `package.json` scripts. If none: `typecheck && lint && test && build`. Rust: `cargo fmt --check && cargo clippy -- -D warnings && cargo test`. Solidity: `forge fmt --check && forge test`. Run all of it, once, from a clean state.
2. **Behaviour.** For anything user-visible: run it. A server gets a curl. A page gets opened in the browser. A CLI gets invoked with the new flag. Compare against main when the change alters existing behaviour.
3. **Negative check.** Feed it the input that must be rejected. Watch it reject.
4. **Scope check.** `git status` and `git diff --stat`. Every changed file is explained by the task. Nothing generated, nothing stray.
5. **Report.** Paste the tail of the gate output. State what was verified and how. If something could not be verified, say that first, not last.

## Rules
- Never write "tests pass" without the output.
- Never skip a slow step because it is slow. Say it was skipped if it was.
- Screenshots are for your own eyes. Verify, then delete them.
- A failing gate is a report, not a reason to weaken the gate.

## Not this skill
- Fixing what fails: `debug`.
- Committing: `ship`.
