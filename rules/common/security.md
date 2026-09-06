# Security

- Secrets come from the environment, never from source. `.env` is gitignored, `.env.example` is committed with empty values.
- Validate at every trust boundary: HTTP body, query, headers, webhook payloads, CLI args, file contents. Strict schema, reject unknowns.
- Auth checks on the server, in the handler, every time. Never trust the client's idea of who it is.
- Parameterised queries only. sqlx macros, Drizzle query builder. No string-built SQL.
- Least privilege for tokens, DB roles, container users. Non-root in Dockerfiles.
- Log the event, not the payload. No tokens, passwords, or PII in logs.
- Dependencies: pin versions in lockfiles, `pnpm audit` / `cargo audit` in CI, no new dependency for what a few lines can do.
- Anything touching money, keys, or user data goes through the `audit` skill before it ships.
