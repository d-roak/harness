---
name: videogen
description: Plan and generate a short video as a sequence of consistent clips, from shot list to assembled cut, with the connected video MCP. Use for product demos, ads, explainers, social clips, and any moving image longer than one shot.
---

# videogen

`rules/media.md` applies. Tooling: Higgsfield MCP for generation, `imagegen` for stills and references.

## 1. Brief
Purpose, audience, where it plays (feed, site hero, pitch), length, aspect ratio, sound or silent. One line each.

## 2. Script and shot list
Narration or on-screen text first, through `copy`. Then a table:

| # | sec | framing | move | subject action | transition |

Clips 4 to 8 seconds. One move per clip, one action per clip. Sum the seconds against the target. Establishing shot, then the product, then the proof, then the ask. Cut anything that does not serve the ask.

## 3. References
- Style frame: one still from `imagegen` that fixes grade, lens and palette for the whole piece.
- Character and product references: one image each, reused in every clip they appear in.
- Start each clip from a still (image-to-video) when the subject must match across cuts. Text-to-video for establishing shots only.

## 4. Generate
One clip at a time, or a batch when the MCP supports it. Prompt is the shot-list row plus the bible, plain nouns. Watch each result at full size. Regenerate on morphing, drifting text, a new light source, a colour shift from the neighbour clip, an extra move.

## 5. Assemble
Order per the shot list. Hard cuts by default. Audio in three passes: voice, music, effects. Music under the voice, effects only where an action needs weight. Captions burned in if it plays muted.

## 6. Check
Play it through once without pausing. Does it read as one piece? Is the ask clear by the end? Paste the shot list with the final durations.

## Not this skill
- Single images or the style frame: `imagegen`.
- 3D renders for a shot: `blender`, then bring the render in as a still.
