# Testing

- Test the seam, not the implementation. A test that breaks on a rename is a bad test.
- Non-trivial logic (a branch, a loop, a parser, anything touching money or auth) leaves at least one runnable check behind. Trivial one-liners need none.
- Test the rejections. A suite that only walks happy paths says nothing about the guards.

## Client flows

- Non-trivial provider code gets one contract-shaped seam check plus one distinct rejection, timeout, or malformed-response check.
- Run one sandbox smoke when authorized credentials already exist. Do not create credentials or use production writes to prove a flow.
- Do not test SDK internals, every provider permutation, or mocks without a contract-shaped seam.

## What not to write

A suite is a liability as well as an asset. Four kinds of case cost maintenance and prove nothing, so do not add them, and delete them when you find them.

- **One case per branch, not per input.** A second case that walks the same branch with a different value is noise. Two inputs earn two cases only when they take different paths.
- **Never assert prose.** Assert the status code, the header, a stable machine-readable `code`, the exported constant. A test comparing against a hardcoded copy of a message breaks the next time someone edits the wording, which tells you nothing about the code. Where the message itself is the contract, import the constant and compare against that.
- **Nothing the type system already proves.** A case asserting a default equals its own literal, or that a getter returns what was passed in, is a tautology.
- **Never reach past the interface.** No asserting on internal shapes, generated SQL fragments, or private state. If the only way to test something is from inside, the module is the wrong shape.

Coverage is branches reached, never cases counted. When trimming, classify each case first: seam, duplicate, tautology, implementation. Keep the seams, cut the rest, and name what went in the PR body.
- Prefer real dependencies (a Postgres in docker, a tmp dir) over mocks. Mock only at the network edge.
- Runners: Vitest for TS, `cargo test` for Rust, `forge test` for Solidity, pytest for Python. Playwright for browser flows.
- Co-locate tests with the code (`foo.test.ts` next to `foo.ts`, `#[cfg(test)]` in the same file).
- Property-based tests where inputs have structure: fast-check, proptest, Foundry fuzz.
- The gate is the repo's own command chain. If a repo has none, it is `typecheck && lint && test && build`.
- Flaky test found: fix it or delete it in the same PR. Never retry-loop it.
