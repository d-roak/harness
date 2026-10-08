---
name: verification
description: Create or maintain an app-owned verification CLI and Feature Map for reproducible local behavior checks. Use when an application lacks agent-controllable runtime verification or its map is stale.
---

# verification

## Create

1. Confirm the target is a Git repository.
2. Run `create-verification-skill <repo>`.
3. Fill `.claude/skills/verify-app/config.json` with local-only runtime, test data reset, and test-user details. Never add credentials.
4. Run `node .claude/skills/verify-app/control-app.mjs doctor`.
5. Add Feature Map entries for the first user path. Run it, snapshot it, then prove one rejected path.

## Maintain

1. Update only files describing changed behavior.
2. Keep entries behavior-level, selector/state-grounded, and runnable without source inspection.
3. Run `doctor`, changed paths, and a rejection. State blocked account, OS, entitlement, or driver paths.

## Rules

- The CLI belongs to the application, not the global harness.
- Commands need strict arguments, JSON output, help text, one seam test, and a Feature Map path.
- Start read-only. External writes require an app-specific `--dry-run`, explicit approval, and test.
- Do not add remote origins, arbitrary evaluation, uploads, feature flags, or persistent shared sessions by default.

## Not this skill

- Repository gate: `verify`.
- Bug root cause: `debug`.
