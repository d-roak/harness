---
name: plan
description: Turn a vague request into a spec, a decision record when needed, and an ordered task list. Use before any task with three or more steps, any schema or API change, or when the request could be read two ways.
---

# plan

## When
- Three or more steps, or an architectural choice.
- The request names a symptom instead of a change.
- Two reasonable readings lead to different work.

## Steps

1. **Grill.** Ask the questions whose answers change the work. Stop when the next question would not. Typical ones:
   - Who calls this and what do they do with the result?
   - What must never happen? (money moved twice, a row without an owner, a 500 on bad input)
   - What exists already that this must fit? Read it before asking.
   - What is out of scope, explicitly?
   If the user is not available, answer each question yourself, mark it as an assumption, and continue.

2. **Spec.** One markdown block, under a page:
   - Goal, one sentence.
   - Behaviour: inputs, outputs, errors. Tables beat prose here.
   - Constraints: what must not happen. Every line becomes a test.
   - Out of scope.
   - Assumptions made on the user's behalf.

3. **Decide.** If a real choice exists (two libraries, two schemas, sync vs queue), write a short ADR: context, options with one trade-off each, decision, consequence. Recommend one. Never present a menu without a pick.

4. **Tasks.** Ordered list, each one shippable on its own, each with its verification command. Small enough that a reviewer can hold the diff in their head.

5. **Check in** if the plan touches something the user did not mention (a migration, a public API, a cost). Otherwise proceed with the plan visible at the top of the response.

## Output
The spec and task list, in the reply. Persist to a GitHub issue if the work outlives the session. Never a todo file in the repo.

## Not this skill
- Writing code: `implement` or `tdd`.
- Something is broken and you know it: `debug`.
