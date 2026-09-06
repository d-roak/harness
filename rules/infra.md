# Infra

## Containers
- One Dockerfile per deployable, multi-stage, non-root final user, `.dockerignore` present.
- Node images: `node:22-alpine`, `corepack enable`, `pnpm fetch` before copying source for layer caching.
- Rust images: build stage on `rust:1-slim`, runtime on `debian:bookworm-slim` or distroless.
- `docker-compose.yml` for local Postgres/Redis. Same env var names as prod.

## Deploy targets
- Self-hosted services: Dokploy. Image built by hand or CI, pushed to registry, redeployed via Dokploy. Env vars set in Dokploy, never baked into the image.
- Static sites: GitHub Pages (via Actions) or Vercel. `vercel.json` only when defaults are wrong.
- Never deploy from a dirty tree or from `main` with failing CI.

## CI (GitHub Actions)
- One workflow per repo named `ci.yml`, triggered on `pull_request` and `push` to `main`.
- Jobs mirror the local gate exactly. If it passes locally and fails in CI, the gate is wrong, fix it.
- Cache pnpm store / cargo registry. Pin action versions to a major tag.
- Secrets via repository secrets. Never echo them.

## Postgres
- Migrations checked in and forward-only. Never edit a migration that has run anywhere.
- Constraints in the schema: `NOT NULL`, `CHECK`, `UNIQUE`, FK. The database is the last line.
- `timestamptz` not `timestamp`. `text` not `varchar(n)`. UUID or ULID primary keys.
- Indexes for every FK and every column in a `WHERE` on a hot path. `EXPLAIN ANALYZE` before adding one anyway.
- Backups verified by restoring them, not by their existence.

## Auth and analytics
- Better Auth for first-party apps, Privy for wallet login, Supabase Auth only when already on Supabase.
- PostHog for product analytics. Events named `object_verb` (`invoice_paid`), never PII in properties.
