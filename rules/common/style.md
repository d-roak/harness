# Style

## Code
- Strict types everywhere. No `any`, no `unwrap()` in production paths, no untyped Python signatures.
- Prefer named exports, functional components, `const`, early returns.
- Prettier: tabs, no semicolons, print width 120. ESLint flat config. No Biome.
- Icons: `@phosphor-icons/react` only.
- No hardcoded colours. Design tokens or tenant config.
- Comments explain why, never what. A guard with no reason gets deleted by the next person.

## Negative space
Define what must not happen, not only the happy path.
- Guard clauses at the top of a function, before any work, with a message that says what was expected.
- Allowlists, never denylists. Unknown enum, filter, sort field or action is rejected with the list of what is allowed.
- Strict schemas at trust boundaries (`.strict()` in zod). A typo'd field name 4xxs, it does not vanish.
- Discriminated unions over optional-field soup. DB constraints (`CHECK`, `NOT NULL`, `UNIQUE`, FK) over app-level checks alone.
- `?? default` for a real default only, never for "I don't know what happened". No empty `catch`.
- `switch` on a union ends with a `never` check.
- Every guard gets a test proving it fires.

Prose of any kind: see `writing.md`.
