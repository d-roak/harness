# Bugfix

```
debug → verify → ship
```

1. `debug`: reproduce, localise, one-sentence root cause, regression test, fix the cause, look sideways for the same shape.
2. `review` if the fix is more than a few lines or crosses a module boundary.
3. `verify`: full gate, the regression test now green, the original report re-tried by hand.
4. `ship` on instruction. Commit subject `fix(scope): ...`.

If the root cause implies a redesign, stop and run `plan` with the root cause as context. Do not patch around it.
