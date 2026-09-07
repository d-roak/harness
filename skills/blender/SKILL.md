---
name: blender
description: Build, light and render a 3D scene in Blender through the Blender MCP, from a blank file to a render or a GLB for the web. Use for product visuals, hero renders, scene mockups, and assets for a site or video.
---

# blender

`rules/media.md`, 3D section, applies. Tooling: `blender-mcp` (Blender running with the addon, server started in the sidebar). Poly Haven for HDRIs, textures and models; Hyper3D or Sketchfab if enabled.

## 1. Plan
Subject, purpose (still, turntable, web asset), target resolution and aspect, matching still bible if one exists. Camera focal length and height. Light plan: HDRI plus key, rim if needed. Materials list. Write it in the reply.

## 2. Scene
- Fresh file. Delete the default cube, light and camera. Set units to metric, scale 1.
- Build with scripts through `execute_blender_code`, in small steps, checking `get_scene_info` after each. Names on everything: `prod_bottle`, `mat_glass_green`, `cam_hero`, `light_key`.
- Real dimensions from the spec. A 330ml can is 66 by 115mm.
- Modifiers non-destructive until final. Apply only for export.

## 3. Materials and light
- Principled BSDF. Poly Haven textures for anything with a surface, 2k unless close-up.
- HDRI for ambient at a strength that reads true, rotated so the key direction matches the still bible. One key light with a size that gives the wanted softness. Rim only if the subject merges with the background.
- Colour management AgX (or Filmic on older builds). Never Standard.

## 4. Camera and render
- Camera at a real focal length. Depth of field on purpose, f-stop stated.
- EEVEE while iterating, screenshots via the MCP viewport capture. Cycles for the final: samples fixed, denoise on, resolution and aspect from the plan.
- Output PNG 16-bit for stills going to compositing, JPEG only for previews.

## 5. Export for the web
GLB, draco compressed, textures baked or packed at 2k, y-up, origin at the base. Check it in a viewer before delivering. File size stated.

## 6. Check
Compare the render with the plan and the still bible side by side. Palette, framing, light direction match or the difference is named. Paste render settings.

## Not this skill
- The look the render must match: `brand`, `imagegen`.
- Cutting renders into a piece: `videogen`.
