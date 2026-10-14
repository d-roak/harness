---
name: ship
description: Commit, branch, PR, and deploy by the house rules. Only runs on an explicit instruction, and does exactly the action named, nothing more.
---

# ship

Each action below needs its own explicit instruction from the user. "commit" does not include push. "push" does not include a PR. Default flow: feature branch, PR, green CI/review, then merge. Direct `main` work requires an explicit request for that exact action.

## commit

- If on `main`, create a feature branch first unless the user explicitly requested a direct commit to `main`.
- `git status` and `git diff` first. Stage only what the task changed.
- Conventional Commits, one-line subject: `type(scope): description`. No body. No attribution trailers.
- One logical change per commit.

## push

- Push to the current feature branch. If on `main`, create a branch first (`type/short-name`) unless the user explicitly requested a direct push to `main`.
- Never force-push a shared branch.

## pr
- `gh pr create` against `main`. Title is the commit subject. Body: what changed, why, how it was verified (paste the gate tail), what is out of scope.
- No attribution lines. No "Generated with".
- CI must be green before asking for review.

## merge

- Merge an approved PR after CI is green, only when the user explicitly requests the merge.
- Direct merge to `main` requires an explicit user request for that exact action and completed verification.

## deploy
Check the target and confirm with the user unless they named it:
- **Dokploy**: build the image, push to the registry, trigger the redeploy. Env changes go in Dokploy first.
- **Vercel**: merge to `main` deploys. Preview deploys come from the PR.
- **GitHub Pages**: the `ci.yml` / `deploy.yml` workflow on `main`.
- **Contracts**: `forge script` with `--broadcast` only after a dry run and `audit`. Verify on the explorer.
Never deploy from a dirty tree, from red CI, or from a branch other than the one the user named.

## release notes
When asked: bullets grouped by feat / fix / chore from `git log main..HEAD --oneline`. Plain words, no adjectives.

## Not this skill
- Deciding if it is ready: `verify` and `review` come first.
