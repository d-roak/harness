---
name: brand
description: Build a brand identity and design system from a brief, and record it as a DESIGN.md a coding agent can follow. Use when a project has no visual identity yet or the existing one is being replaced.
---

# brand

## 1. Strategy before pixels
Write these in the reply:
- Category, audience, the one feeling the brand should leave.
- Three references and, for each, what is borrowed: rhythm, grid, density, tone. Never the logo, name, composition or slogan.
- Symbol logic: a small table of candidate metaphors, what each says, what it risks. Pick one, or fuse at most two.

## 2. System
- Palette: base, primary accent, secondary accent, neutral scale. Hex values. Contrast pairs checked.
- Type: display, body, mono. Named fonts, weights in use, scale from `rules/design.md`.
- Shape: one radius scale. Border and shadow rule.
- Voice: five adjectives and five it is not. Three example lines that pass `writing.md`.
- Motion: intensity dial and the easing curve.
- Icon family and stroke width.

## 3. Logo
Method: monogram with meaning, product action, metaphor fusion, negative space, or constructed geometry. Wordmark and mark, each in one colour, tested at 16px and 512px. Clear space rule. What it must never be placed on.

## 4. Board
One overview image via `imagegen`: 3 by 3 grid, dark charcoal canvas, wide gutters. Panels: logo cover, construction, digital application, essence line, colour, type, physical application, image direction, system detail. Text on the board: name, one tagline, one URL, a few labels. Mockups are browser chrome, terminal, app icon, card, seal.

## 5. Write it down
`DESIGN.md` at the repo root: everything above as values, not adjectives, so `design` and `implement` can apply it without judgement calls. Tailwind config tokens generated from it.

## Not this skill
- Applying an existing system to pages: `design`.
- Marketing copy beyond the voice samples: `copy`.
