---
name: imagegen
description: Generate a consistent set of images, whether UI section mockups, mobile screens, brand boards, product shots or illustrations, using whatever image MCP is connected. Use whenever more than one image must read as one system.
---

# imagegen

`rules/media.md` applies. Tooling: the Higgsfield MCP, a fal or Replicate MCP, or whatever is registered; check `mcp/servers.json`.

## 1. Count and lock
List the deliverables with a number each. "Landing page" is six images, "full site" eight, "onboarding flow" one per screen. Say the number. Do not finish under it.

## 2. Bible
Write the bible from `rules/media.md` in the reply: palette, type, grade, framing, materials, mockup frame. If a `DESIGN.md` exists, derive from it and do not contradict it.

## 3. Prompt structure
Per image, one block:
```
[deliverable n of N: name]
subject:    what is in frame, named concretely
composition: anchor (left third / centred / full-bleed / grid), and why it differs from n-1
framing:    aspect, camera height, focal length
light:      source, direction, temperature
palette:    from the bible, hex
type:       family and what text appears, verbatim, short
surface:    material, texture, grain
avoid:      the slop list, plus anything the previous frame did
```
Vary the composition anchor: never the same one more than twice in a row, never the same background mode more than three in a row. For UI: one section per image, horizontal, each a different layout family. For mobile: device frame, safe areas, one screen per image.

## 4. Generate and inspect
Batch when the MCP supports it. Look at every result before showing it. Regenerate on: unreadable text, nested boxes, uneven margins, drift from the palette, a near-clone of an earlier frame, any banned pattern. Never crop an old image to make a new deliverable.

## 5. Deliver
Files named `NN-name.ext`. A one-line caption each: what it is and any known compromise. The bible at the top so the next person can extend the set.

## Not this skill
- Moving images: `videogen`.
- Deciding the identity the images express: `brand`.
- Turning a mockup into code: `design` then `implement`.
