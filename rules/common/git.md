# Git

- Never commit, push, branch on a remote, open a PR, or create a repo unless explicitly told to. Passing tests and a good stopping point are not permission.
- One instruction, one action. "commit" is not "commit and push".
- Never push to `main`. Branch, then PR.
- Conventional Commits, one-line subject, no body: `feat(web): add landing page`, `fix(api): reject empty cursor`.
- Types: feat, fix, chore, refactor, docs, test, ci, style, perf, build.
- No AI attribution anywhere: no `Co-Authored-By`, no "Generated with". Commits are authored by the human.
- Never commit `.env`, keys, or private submodule references from public code.
- Work that must outlive the session becomes a GitHub issue (`gh issue create`), not a todo file in the repo.
