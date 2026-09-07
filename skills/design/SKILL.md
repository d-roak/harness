---
name: design
description: Design or redesign a web interface with deliberate taste instead of the model's default look. Use for any landing page, marketing site, dashboard, component set or UI review, before writing markup.
---

# design

`rules/design.md` is the standard. This is the procedure. Nothing in markup before step 4.

## 1. Read the brief
- Mode: greenfield, redesign that preserves, or redesign that overhauls. If unclear, ask once.
- Audience and the state they arrive in. One sentence.
- Real design system in play? Use its official package. Do not invent one.

## 2. Audit (redesign only)
Before touching anything, list: brand tokens, information architecture, slugs and anchor IDs, nav labels, copy voice, form field names and order, analytics event names, legal text, accessibility wins, SEO baseline. All of those survive unless the brief says otherwise. SEO loss is the top redesign risk.

Then pull the levers in order and stop when the brief is met: typography, spacing and rhythm, colour recalibration, motion, hero and key-section recomposition, full block replacement. IA sound: levers one to four give most of the value at a fraction of the risk.

## 3. Plan on paper
Write this block in the reply before any code:
- Dials: variance / motion / density, with one line of reasoning.
- Palette (hex), type pairing, radius scale, shadow rule.
- Section list with a layout family per section. Check: no family twice, no third split in a row, eyebrows within limit.
- Hero: headline (under eight words), subtext (under twenty), buttons (verbs, distinct intent).
- Motion list, each with its one-clause reason.
- Images: what is real, what needs `imagegen`. Nothing faked from divs.

## 4. Build
Follow `implement`. Tailwind with tokens, shadcn where it fits, Phosphor icons. Component by component, each one checked against the plan. Copy goes through `copy`.

## 5. Pre-flight
Walk the checklist at the end of `rules/design.md`. Open the page at 375, 768, 1440. Tab through it. Toggle reduced motion. Toggle dark mode if present. Run Lighthouse or the DevTools MCP for the vitals. Paste the numbers. An unticked box means not done.

## Not this skill
- Brand identity, logo, palette from nothing: `brand`.
- Rendering the design as reference images first: `imagegen`.
- The words: `copy`.
