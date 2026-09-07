# Skills

Each skill is one directory under `skills/` with a `SKILL.md`. Frontmatter: `name`, `description` ending in "Use when ...". Body under a page, ending with "Not this skill".

| Skill | One line | Hands off to |
|---|---|---|
| `plan` | grill the request, write a spec, decide, list tasks | `implement`, `tdd` |
| `tdd` | red, green, refactor at a seam | `verify` |
| `implement` | build a clear task with the smallest diff | `review` |
| `debug` | reproduce, root cause, regression test, fix | `verify`, or `plan` if it needs a redesign |
| `review` | correctness, rules, things to delete, tests | `verify` |
| `audit` | security walk from entry points to assets | `debug` / `implement` for fixes, then `audit` again |
| `verify` | gate, behaviour, negative check, scope check | `ship` |
| `ship` | commit, push, PR, deploy, one action per instruction | nothing |
| `handoff` | note for the next session | nothing |
| `memory` | recall at start, record after corrections | everything |
| `copy` | words without slop: UI strings, pages, docs, notes | `design`, `implement` |
| `brand` | identity and design system as a `DESIGN.md` | `imagegen`, `design` |
| `design` | audit, dials, layout plan, pre-flight for a UI | `implement` |
| `imagegen` | a consistent image set from a written bible | `videogen`, `design` |
| `videogen` | shot list, references, clips, assembly | nothing |
| `blender` | scene, materials, light, render or GLB via blender-mcp | `imagegen`, `videogen`, `implement` |

## Invocation

- Claude Code: `/plan`, `/review` and so on, or the model picks one from the description.
- Codex and OpenCode: the model reads `~/.agents/skills` (or its own dir) and picks by description. Ask by name if it does not.

## Writing style inside a skill

Imperative. Numbered steps where order matters, bullets where it does not. Commands in code blocks. No preamble about what a skill is.
