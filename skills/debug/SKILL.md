---
name: debug
description: Take a bug report, a failing test, a stack trace or a broken CI run to a root-cause fix with a regression test. Use whenever something that used to work does not, or a test is red.
---

# debug

## Steps

1. **Reproduce.** Get the failure on your machine or in a test before touching code. If you cannot reproduce, say so and stop. Capture the exact error text.
2. **Localise.** Bisect: git log, comment out, narrow the input. Read the code path with the failure in hand. Log with structured fields, not `console.log("here")`.
3. **Root cause.** Write one sentence: "X happens because Y." If the sentence has "sometimes" or "probably" in it, keep going.
4. **Regression test** that fails on the current code and encodes the root cause, not the symptom.
5. **Fix** the cause. Not the symptom, not the caller. If the fix is in a dependency, pin and file upstream.
6. **Gate.** Full run. Paste the tail.
7. **Look sideways.** Same bug pattern elsewhere in the repo? Fix it in the same change if it is the same shape, otherwise file an issue.

## Rules
- Never retry-loop a flaky test. Fix it or delete it and say which.
- Never widen a type or catch an exception to make red go away.
- CI red on a PR you did not write: still fix it. No hand-holding needed.
- Report faithfully. If it still fails, show the output.

## Not this skill
- Nothing is broken, the user wants different behaviour: `implement`.
- The fix implies a redesign: `plan`, with the root cause as context.
