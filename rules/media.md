# Media

Read before generating images, video, or 3D. Same standard as code: a spec, a consistent system, a check at the end.

## Prompts are specs
Subject, framing, lens, light, palette, material, mood. Plain nouns, one line each. No "stunning", "masterpiece", "8k", "trending", "ultra-detailed", "cinematic" as a filler word. Those tokens do nothing and mark the output.

## Consistency is a bible, not luck
Before the first frame, write the bible and keep it in the reply or the issue:
- Palette: one primary, one secondary, one accent, a neutral scale, as hex.
- Type family and scale, if text appears.
- Grade: contrast, saturation, grain, colour temperature.
- Framing: aspect ratio, camera height, focal length, margin.
- Materials and surfaces that recur.
- Device or mockup frame, if any: one style, one scale, even margins.
Every generation in the set cites the bible. A viewer flipping through must read them as one thing.

## Sets
- One deliverable per image. A page with eight sections is eight images, never one tall image or a collage.
- Never crop an old image to fake a new one. Regenerate standalone.
- Count the deliverables before starting, lock the number, check the count at the end.
- Reject and regenerate on: text too small to read, nested boxes, uneven mockup margins, a clone of a previous frame, a palette drift.

## Images, UI mockups
- Web: horizontal, 16:9 or 16:10. Compose each section differently. Left-text right-image is the most overused frame; not the default.
- Mobile: one image per screen, device frame present, safe areas respected, bottom nav and status bar where the platform puts them. Text large enough that the design feels finished.
- Brand boards: dark charcoal canvas, 3 by 3 grid by default, gutters wide, text sparse (name, one tagline, one URL, a handful of labels). Mockups show identity, not features.
- No purple-blue gradients, mesh blobs, glow halos, floating shapes, fake charts, identical stat columns, placeholder brand names.

## Video
- Shot list first: number, duration, framing, movement, subject action, transition. Total under the budget.
- Clips of 4 to 8 seconds. One camera move per clip. One subject action per clip.
- Characters and products get a reference image from the image set, used in every clip. No character described only in words.
- Start clips from a generated still (image-to-video) when continuity matters. Text-to-video only for establishing shots.
- Same grade, same lens family, same aspect ratio across the cut. A change of look is a scene change, deliberate and named.
- Reject on: morphing limbs or objects, text that drifts, a second light source appearing, a colour shift between adjacent clips.
- Audio is its own pass: voice, then music, then effects. Never a generated voice reading slop copy.

## 3D
- Units are metres, scale is real. Name every object and material; nothing called `Cube.001`.
- Delete the default scene. Nothing ships lit by a single default point light on a grey plane.
- PBR materials with albedo, roughness, normal. Poly Haven textures and HDRIs before hand-painting.
- Camera at a real focal length (35, 50, 85) and a real height. Match the still bible's framing.
- Lighting: HDRI for ambient, one key, and a rim if the subject needs separation. Colour management AgX or Filmic, never Standard.
- Render: EEVEE for iteration, Cycles for finals with denoising. Fix the sample count and resolution in the scene, not per render.
- Export GLB for the web with draco, textures at 2k unless a close-up needs 4k.
