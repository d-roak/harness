# Design

Read before any UI work: a page, a component, a dashboard, a redesign. Distilled from leonxlnx/taste-skill, kept to what is testable.

## The one idea
The model's first instinct is the statistical average of every landing page it has seen. That average is slop. Read the audience, then reach past the default on purpose. The audience picks the aesthetic, not you.

## Slop, by name
Purple-to-blue gradient. Centred hero over a dark mesh. Three equal feature cards. Glassmorphism on everything. Infinite micro-animations. Inter on slate-900. A div-built fake dashboard in the hero. Cards inside cards inside cards. A logo wall of unknown logos. "Acme", "Nexus", "John Doe", "99.99%". Version badges ("BETA", "v0.6") as decoration. Section-number eyebrows ("01 · Capabilities"). Scroll cues. Emoji in headings. Any of these on a page is a fail, not a style choice.

## Set the dials first
Declare before coding: `variance` (how far from the default), `motion`, `density`, each 1 to 10. SaaS landing 7/6/4. Agency 9/8/3. Portfolio 8/7/3. Editorial 6/4/3. Public sector or internal tool 3/2/5. A dashboard is a tool: density up, motion down, variance low.

## Type
- Not Inter, Roboto, Arial, Open Sans, Helvetica as the default. Pick from Geist, Satoshi, Cabinet Grotesk, Outfit, GT America, or a serif chosen on purpose, never by reflex.
- Pair one sans with one mono: Geist + Geist Mono, Satoshi + JetBrains Mono, GT America + IBM Plex Mono.
- Display: `text-4xl md:text-6xl tracking-tighter leading-none`. Body: `text-base leading-relaxed max-w-[65ch]`. Bigger display only for headlines of five words or fewer.
- Emphasis inside a headline is italic or weight of the same family. Mixing families for one word is amateur.
- Descenders in italic headlines need `leading-[1.1]` and `pb-1` or they clip.

## Colour
- One accent, saturation under 80 percent. One palette for the whole page. No section that inverts the theme.
- No pure `#000` or `#fff`. Tint neutrals toward the accent.
- Shadows carry the background hue. No `rgba(0,0,0,.3)`, no `shadow-md` reflex. On light themes shadow opacity under 0.05.
- The warm-beige-and-gold "premium consumer" palette is banned as a default. Rotate: cold luxury, forest, black and tan, cobalt and cream, terracotta and slate, olive and brick, mono plus one pop.
- Contrast: WCAG AA, 4.5:1 body, 3:1 at 18px and up. Check the buttons, not just the text.

## Layout
- Each layout family appears once per page. Eight sections means at least four families.
- No three equal columns of feature cards. No third consecutive image-left text-right split.
- Eyebrows (the small uppercase label above a heading): at most one per three sections.
- Cards only when elevation means hierarchy. Otherwise `border-t`, `divide-y`, whitespace.
- One radius scale for the whole page: all sharp, all 12 to 16px, or all pill. Never mixed.
- Bento grids have exactly as many cells as items, `grid-flow-dense`, and at least two cells that differ in content type.
- Section padding: sparse `py-32` to `py-48`, standard `py-16` to `py-24`, dense tools tighter with `font-mono` for numbers.
- Container `max-w-7xl` or `max-w-[1400px]`. `min-h-[100dvh]`, never `h-screen`. Grid, never `w-[calc(33%-1rem)]`.
- Nav one line on desktop, 64 to 72px tall, 80 max.

## Hero
- Fits the first viewport: headline two lines max, subtext twenty words max, buttons visible without scrolling. Top padding at most `pt-24`.
- At most four text elements: optional eyebrow, headline, subtext, buttons.
- Nothing else in it. Trust strips, pricing teasers, avatar rows, feature bullets, fake product UI all go below or nowhere. Logo wall under the hero, real SVGs, recognisable names only.

## Buttons and forms
- Buttons: verb, three words max, one line on desktop. Two buttons with the same intent is a fail.
- `:active` gets `scale-[0.98]` or `-translate-y-px`. Focus rings visible. Disabled explained.
- Every input has a label, a visible error state, and the right `type` and `autocomplete`.
- Empty, loading and error states designed, not defaulted.

## Motion
- Motivated or absent. Each animation justified in one clause: hierarchy, story, feedback, or state change.
- Animate `transform` and `opacity` only. Spring `stiffness 100, damping 20`, or `cubic-bezier(0.16, 1, 0.3, 1)`.
- No scroll listeners in React state, no rAF touching state. GSAP ScrollTrigger with `pin` and `scrub` if pinning is the point.
- One marquee per page at most. `prefers-reduced-motion` honoured whenever motion is above 3.

## Content on the page
- `writing.md` applies. Zero em dashes in UI copy. Middle dot at most once per line.
- Real images, real product screenshots, real logos. A fake screenshot built from divs is the loudest tell there is.
- Quotes: three lines max, name and role, typographic quote marks.
- Icons: Phosphor, one family, one stroke width. Never hand-drawn SVG icons.

## Honesty about systems
If a real design system fits (shadcn, Radix, Material, the client's own), use the official package. Do not present a trend as a system. There is no official liquid-glass.css.

## Redesign
Audit first. See the `design` skill. SEO and information architecture survive the redesign unless the brief says otherwise.

## Pre-flight, before "done"
Dials declared. Hero fits the viewport. No banned pattern from the slop list. One accent, one radius scale, one theme. Eyebrow count within limit. No duplicate CTA intent. Every button passes contrast. Empty, loading, error states exist. Reduced motion respected. Dark mode checked if it exists. Core Web Vitals in budget: LCP under 2.5s, INP under 200ms, CLS under 0.1. Every checkbox honest or the page is not done.
