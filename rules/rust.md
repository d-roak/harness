# Rust

For systems programming and backends where throughput or latency justify it. Default backend language is TypeScript; reach for Rust when the profile says so, not by taste.

## Toolchain
- Cargo workspace for multi-crate projects. `main.rs` thin, logic in `lib.rs`.
- `cargo fmt`, `cargo clippy -- -D warnings`, `cargo test` as the gate. `cargo audit` in CI.
- Edition 2021 or later. MSRV pinned in `rust-toolchain.toml` when it matters.

## Errors
- `thiserror` for library errors, `anyhow` for binaries.
- `?` over explicit match. No `unwrap()` / `expect()` outside tests and provably infallible spots (comment why).
- Functions that can fail return `Result`. Panics are bugs.

## Ownership
- Borrow by default. `&str` over `String`, `&[T]` over `Vec<T>` in parameters.
- `Cow<'_, T>` when a function might allocate. `impl Into<T>` / `impl AsRef<T>` for ergonomic APIs.
- Clone when it is the simplest correct thing. Do not fight the borrow checker for a microsecond.

## Patterns
- Derive `Debug, Clone, PartialEq` as a baseline. `#[must_use]` on builders and results.
- Iterators and combinators over index loops.
- Newtypes for IDs and units. Make invalid states unrepresentable with enums.
- Group by module, re-export from `lib.rs`.

## Services
- axum + tokio + tower. sqlx with compile-time checked queries against Postgres. `sqlx migrate` for schema.
- Config via env, parsed once at startup into a struct. Fail fast on missing values.
- `tracing` for logs, structured fields, no `println!` in services.
- Graceful shutdown on SIGTERM. Health endpoint. Non-root container user.

## Tests
- Unit tests in `#[cfg(test)] mod tests`. Integration tests in `tests/`.
- proptest for anything parsing or arithmetic-heavy.
