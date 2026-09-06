# Testing

- Test the seam, not the implementation. A test that breaks on a rename is a bad test.
- Non-trivial logic (a branch, a loop, a parser, anything touching money or auth) leaves at least one runnable check behind. Trivial one-liners need none.
- Test the rejections. A suite that only walks happy paths says nothing about the guards.
- Prefer real dependencies (a Postgres in docker, a tmp dir) over mocks. Mock only at the network edge.
- Runners: Vitest for TS, `cargo test` for Rust, `forge test` for Solidity, pytest for Python. Playwright for browser flows.
- Co-locate tests with the code (`foo.test.ts` next to `foo.ts`, `#[cfg(test)]` in the same file).
- Property-based tests where inputs have structure: fast-check, proptest, Foundry fuzz.
- The gate is the repo's own command chain. If a repo has none, it is `typecheck && lint && test && build`.
- Flaky test found: fix it or delete it in the same PR. Never retry-loop it.
