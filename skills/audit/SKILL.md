---
name: audit
description: Security review for anything touching money, auth, user data, secrets, or production infra. Use before shipping such a change and on request for a repo or a contract.
---

# audit

Scope first: list the assets (funds, sessions, PII, keys) and the entry points (routes, contract functions, webhooks, CLI). Then walk each entry point to each asset.

## Web and API (TypeScript, Rust)
- Auth checked in the handler, on the server, every route. Object-level access: can user A fetch B's row by ID?
- Input: strict schema, size limits, rejects unknown fields. Pagination cursors signed or opaque.
- SQL only through sqlx macros or Drizzle. grep for string concatenation into queries.
- Secrets: grep for keys in source, in logs, in error responses, in client bundles (`VITE_` / `NEXT_PUBLIC_` prefixes leak by design).
- Sessions: httpOnly, secure, sameSite. CSRF on state-changing form posts. Rate limits on auth and expensive endpoints.
- Webhooks: signature verified before parsing. Idempotency key stored.
- Dependencies: `pnpm audit`, `cargo audit`. Unmaintained or typosquat names.
- Headers: CSP, HSTS, no `*` CORS with credentials.

## Contracts (Solidity)
- Reentrancy on every external call that moves value. Checks-effects-interactions.
- Access control per function, with a test that the wrong caller reverts.
- Arithmetic: overflow behaviour by version, rounding direction favours the protocol, no division before multiplication.
- Oracle and price manipulation, flash-loan-able state, front-running of approvals and swaps.
- Upgradeability: storage layout, initialiser called once, admin key custody.
- Run Slither. Every finding fixed or explained in writing.

## Infra
- Containers non-root, no secrets in image layers, `.dockerignore` excludes `.env` and `.git`.
- Dokploy / Vercel env vars scoped per environment. No prod creds in preview.
- CI: secrets never echoed, third-party actions pinned, `pull_request_target` avoided.
- Postgres: least-privilege roles, no public schema grants, backups restorable.

## Output
Findings ranked by exploitability, each with: entry point, asset, how it is reached, fix. Then a short "checked and fine" list so the reader knows what was covered. No finding is fixed silently; every one is reported.

## Not this skill
- General bugs and style: `review`.
- Fixing what was found: `debug` or `implement`, then re-run `audit` on the fix.
