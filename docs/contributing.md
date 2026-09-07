# Contributing

## A skill

1. `mkdir skills/<name>`, write `SKILL.md` with `name` and `description` frontmatter. Description ends with "Use when ...".
2. Body: When, Steps or Rules, Not this skill. Under a page.
3. Add a row to `docs/skills.md` and, if it is a lifecycle stage, `docs/lifecycle.md`.
4. Run `./install.sh` to link it. Run `./test.sh`.

## A rule

Add the line with a one-clause reason to the right file in `rules/`. Common if it applies to every language, otherwise the language file. Re-run `install.sh` so the managed block picks it up.

## A hook

1. A shell script in `hooks/`, JSON on stdin, `exit 2` with a message on stderr to block, `exit 0` otherwise. Match on the raw JSON text so it works across tools.
2. Add a case to `test.sh` that proves it blocks and a case that proves it allows.
3. Wire it in `hooks/claude.json` and the other adapters.

## An MCP server

One object in `mcp/servers.json`: `command` array for local, `url` plus `auth: oauth` or `bearer_env` for remote. Re-run `install.sh`. Add a row to `docs/mcp.md`.

## Style

Same rules as the code: direct, specific, no filler. The `style.md` banned-word list applies to docs and skills too.
