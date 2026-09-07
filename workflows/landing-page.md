# Landing page

```
brand? → copy → imagegen → design → implement → review → verify → ship
```

1. `brand` if there is no `DESIGN.md`. Skip if the identity exists.
2. `copy`: headline, subtext, section headings, button labels. Words before pixels; a layout built around lorem ipsum gets rebuilt.
3. `imagegen`: one horizontal image per section as the reference set, plus any real imagery the page needs. Six for a landing page. The bible is the `DESIGN.md`.
4. `design`: dials, palette, layout family per section, hero fit, motion list. Written down before markup.
5. `implement`: Vite or Next, Tailwind tokens, shadcn, Phosphor. Section by section against the reference image.
6. `review`, with the design pre-flight as the checklist. Open at 375, 768, 1440. Reduced motion. Dark mode. Lighthouse or Chrome DevTools MCP for the vitals.
7. `verify`, then `ship` on instruction. GitHub Pages or Vercel.
