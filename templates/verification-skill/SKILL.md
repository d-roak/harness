---
name: verify-app
description: Drive this application's local verification CLI and maintain its Feature Map. Use after app changes and before calling user-visible behavior verified.
---

# verify app

## Create

1. Copy `config.example.json` to `config.json`. Fill the local origin, dev command, test data reset, and test-user procedure.
2. Run `node control-app.mjs doctor`. Fix every reported prerequisite before feature work.
3. Add one Feature Map entry for each behavior this CLI drives.
4. Prove one user path with `home`, then a snapshot. Add a negative case.

## Maintain

1. Update only Feature Map entries changed by the work.
2. Run `doctor`, the changed feature path, and a rejection path.
3. State blocked paths with the account, OS, entitlement, or driver reason.

## Rules

- This CLI controls only configured localhost runtime behavior.
- Add a command only with an explicit contract, a Feature Map entry, and a seam test.
- Do not add credentials, remote origins, arbitrary eval, uploads, or destructive commands without an app-specific approval and dry run.

## Not this skill

- Repository gate and scope review: `verify`.
- Root-cause work: `debug`.
