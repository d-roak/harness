# Feature

```
plan → (tdd | implement) → review → verify → ship
```

1. `plan`: grill, spec, ADR if there is a real choice, ordered tasks. Present it and proceed; pause only at the boundaries in `rules/common/workflow.md`.
2. Per task: `tdd` where there is a seam and a "must not" line, `implement` for glue and UI. Small diffs. Third-party clients follow this lifecycle; keep provider-specific code at one boundary.
3. `review` the whole branch, not each commit.
4. `audit` if it touches money, auth, user data, or prod infra.
5. `verify`: gate, behaviour check in the browser or with curl, negative check, scope check.
6. `ship` only on instruction, one action at a time.
7. `handoff` if it did not finish in the session.
