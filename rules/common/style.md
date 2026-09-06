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

## Prose (UI copy, docs, commits, replies)
- Direct, specific, a little dry. Concrete nouns and numbers over abstractions.
- Vary sentence length. Fragments are fine.
- Banned: delve, tapestry, testament, pivotal, crucial, vibrant, intricate, meticulous, landscape, interplay, leverage, seamless, robust, holistic, streamline, empower, unlock, supercharge, game-changer, cutting-edge, journey, realm.
- Banned shapes: "not just X, but Y"; lists of exactly three everywhere; "serves as" instead of "is"; participle tails ("...ensuring reliability"); "Additionally", "Furthermore", "Overall"; "experts argue" without a source.
- One em dash per paragraph at most. No sycophantic openers or closers.
- English for everything a developer reads. UI strings localised, all locales in the same PR.
