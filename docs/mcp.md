# MCP servers

`mcp/servers.json` is the single list. `mcp/install.sh` (run by `install.sh`) registers it with every tool at user scope. Harness entries are tagged and replaced on re-run; your own entries are left alone.

| Server | Kind | For | Setup |
|---|---|---|---|
| `blender` | local, `uvx blender-mcp` | `blender` skill: scene scripting, Poly Haven, Sketchfab, Hyper3D | `uvx blender-mcp install-addon`, enable it in Blender, start the server from the N panel |
| `playwright` | local, `npx @playwright/mcp` | browser checks in `design` and `verify`: accessibility tree, screenshots, console | none |
| `chrome-devtools` | local, `npx chrome-devtools-mcp` | performance traces and Core Web Vitals for the design pre-flight | Chrome installed |
| `higgsfield` | remote, OAuth | `imagegen`, `videogen`: image, video, audio, 3D generation | first use triggers login; Codex: `codex mcp login higgsfield` |
| `fal` | remote, API key | any fal model as a second image/video backend | `export FAL_KEY=...` |

Where they land:

| Tool | File | Shape |
|---|---|---|
| Claude Code | `~/.claude.json` | `mcpServers`, `${FAL_KEY}` expanded by Claude |
| Codex | `~/.codex/config.toml` | `[mcp_servers.*]` inside a `# harness:start` / `# harness:end` block |
| OpenCode | `~/.config/opencode/opencode.json` | `mcp`, `{env:FAL_KEY}` expanded by OpenCode |

Not included, on purpose: Figma (no Figma in the repos), Replicate (fal covers it), third-party OpenAI image wrappers (unmaintained). Add a server by adding one object to `servers.json` and re-running the installer.

Caveat: the Higgsfield endpoint answers with OAuth metadata and a 401 without a token, which is what both tools' login flows expect, but the flow was not exercised end to end when this was written. If login fails, the Higgsfield CLI is the documented fallback.
