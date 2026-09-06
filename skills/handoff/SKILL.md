---
name: handoff
description: Write a note that lets the next session or agent continue without re-deriving anything. Use at the end of a session with unfinished work, or when passing a task to another agent.
---

# handoff

Under 300 words. Written for someone who has the repo but not this conversation.

## Sections
1. **Goal** in one sentence, and the source (issue number, spec, user message).
2. **State**: what is done and verified, what is in progress, what is untouched. Branch name, last commit, gate status with the actual output tail.
3. **Decisions made** and why, one line each. Especially the ones the user overrode.
4. **Open questions** for the user, phrased so they can answer in one word.
5. **Next step**, exactly one, with the command to run first.
6. **Traps**: anything that cost more than ten minutes this session.

## Where
- Reply text if the same user continues.
- The GitHub issue if one exists.
- Never a file committed to the repo.

## Not this skill
- Summarising for a PR: `ship`.
