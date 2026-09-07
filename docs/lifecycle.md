# Lifecycle

```
plan  →  tdd / implement  →  review  →  verify  →  ship
                 ↑ debug   (something is broken)
                 ↑ audit   (money, auth, data, prod)
memory runs underneath all of it. handoff closes an unfinished session.
```

| Stage | Skill | Enters when | Leaves with |
|---|---|---|---|
| plan | `plan` | 3+ steps, a schema or API change, an ambiguous ask | spec, ADR if a real choice, ordered tasks |
| build | `tdd` | there is a seam and a "must not" line | red, green, refactored, tests co-located |
| build | `implement` | the task is clear and mostly glue | smallest diff, gate output pasted |
| fix | `debug` | a report, a red test, a broken CI | one-sentence root cause, regression test, fix |
| review | `review` | anything larger than a one-liner | ranked findings, or an empty list |
| review | `audit` | money, auth, user data, secrets, infra | findings by exploitability, plus what was checked |
| verify | `verify` | every task, no exceptions | gate tail, behaviour check, scope check |
| ship | `ship` | an explicit instruction | exactly the action named |
| close | `handoff` | session ends with work open | a note the next session can act on |

Creative work: `brand` → `copy` → `imagegen` / `videogen` / `blender` → `design` → `implement`, then the same review and verify. Workflows: [`landing-page.md`](../workflows/landing-page.md), [`media.md`](../workflows/media.md), [`3d.md`](../workflows/3d.md).

Three engineering workflows chain the rest: [`workflows/feature.md`](../workflows/feature.md), [`workflows/bugfix.md`](../workflows/bugfix.md), [`workflows/release.md`](../workflows/release.md).

## Why one skill per stage

Skills that overlap get invoked at the wrong time. Each one says what it is not for and names the sibling. The agent should never have to guess between two.
