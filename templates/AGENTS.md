# <repo name>

<one line: what this repo is and who uses it>

Follows the rules in `harness` (`$HARNESS_DIR/rules`). Repo-specific additions below.

## Stack
<language, framework, package manager, DB, deploy target. Five lines max.>

## Gate
```
pnpm typecheck && pnpm lint && pnpm test && pnpm build
```
Nothing is done until this passes. Paste the tail.

## Layout
<three to six lines: where things live and the one convention that is not obvious>

## Do not
- <the trap someone fell into last month>
- <the file that must never be edited by hand>

## Deploy
<target and the one command or click, or "see workflows/release.md">
