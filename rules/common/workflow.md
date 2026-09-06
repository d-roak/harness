# Workflow

## Plan first
- Any task with three or more steps, or an architectural choice, starts with a plan. Write it down before touching code.
- Check the plan with the user before implementing when different readings of the request lead to different work. Otherwise pick the sensible reading and say which one.
- If the plan stops matching reality, stop and re-plan. Do not push through.

## Change vs investigate
- A change request gets the change. Do not go find out why the current behaviour exists first.
- A bug report gets fixed. Point at the log, the error, the failing test, then resolve it. No hand-holding needed.
- Telling those two apart is the whole skill. "Make X the default, mine is Y" is a change request.

## Scope
- The request is the deliverable. Do not narrow it, widen it, or transform it.
- Found a real problem with the task as specified? Say so in two sentences, then build it anyway under stated assumptions.
- Blocked on part of it? Finish every other part in full, then say what was left out and why.

## Subagents
- Offload research, exploration and parallel analysis. Keep the main context for decisions.
- One task per subagent. Give it the exit criteria, not just the topic.

## Done means proven
- Never mark complete without running the gate (`typecheck && lint && test && build`, or the repo's own).
- Diff behaviour against main when the change is behavioural.
- Ask: would a staff engineer approve this diff? If not, keep going.

## After a correction
- Write down the pattern that caused it, in the repo's `AGENTS.md` or the user's notes. The mistake should be impossible to repeat, not just unlikely.

## Simplicity
- Simplest thing that works. Stdlib before a dependency, platform feature before a library, one line before fifty.
- No interface with one implementation, no factory for one product, no config for a value that never changes.
- A deliberate shortcut gets a comment naming the ceiling and the upgrade path: `// ponytail: global lock, per-account locks if throughput matters`.
- Find root causes. No temporary fixes.
