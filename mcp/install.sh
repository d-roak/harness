#!/usr/bin/env sh
# Registers mcp/servers.json with each tool, user scope. Called by ../install.sh; safe on its own.
#   Claude Code  ~/.claude.json            mcpServers (merged, harness entries replaced)
#   Codex        ~/.codex/config.toml      [mcp_servers.*] inside a managed comment block
#   OpenCode     ~/.config/opencode/opencode.json   mcp (merged)
set -eu
HARNESS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export HARNESS_DIR

python3 - <<'PY'
import json, os, pathlib, re
hd = os.environ["HARNESS_DIR"]; home = pathlib.Path.home()
servers = json.load(open(f"{hd}/mcp/servers.json"))
MARK = "__harness__"

def load(p):
    p = pathlib.Path(p)
    try: return json.loads(p.read_text()) if p.exists() and p.read_text().strip() else {}
    except json.JSONDecodeError: raise SystemExit(f"{p} is not valid JSON, fix it by hand first")
def save(p, d):
    p = pathlib.Path(p); p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(d, indent=2) + "\n")
def claude_entry(s):
    if "command" in s: entry = {"command": s["command"][0], "args": s["command"][1:]}
    else:
        entry = {"type": "http", "url": s["url"]}
        if "bearer_env" in s: entry["headers"] = {"Authorization": "Bearer ${%s}" % s["bearer_env"]}
    entry[MARK] = True
    return entry
def opencode_entry(s):
    if "command" in s: entry = {"type": "local", "command": s["command"], "enabled": True}
    else:
        entry = {"type": "remote", "url": s["url"], "enabled": True}
        if "bearer_env" in s: entry["headers"] = {"Authorization": "Bearer {env:%s}" % s["bearer_env"]}
        if s.get("auth") == "oauth": entry["oauth"] = {}
    entry[MARK] = True
    return entry
def merge(cfg, key, entry):
    entries = cfg.setdefault(key, {})
    for name in [name for name, value in entries.items() if isinstance(value, dict) and value.get(MARK)]:
        del entries[name]
    for name, server in servers.items():
        if name not in entries:
            entries[name] = entry(server)

# Claude Code
p = home / ".claude.json"; cfg = load(p); merge(cfg, "mcpServers", claude_entry); save(p, cfg); print("mcp    -> ~/.claude.json")

# OpenCode
p = home / ".config/opencode/opencode.json"; cfg = load(p)
cfg.setdefault("$schema", "https://opencode.ai/config.json"); merge(cfg, "mcp", opencode_entry); save(p, cfg); print(f"mcp    -> {p}")

# Codex: TOML has no stdlib writer. Do not redeclare user-defined tables.
p = home / ".codex/config.toml"; p.parent.mkdir(parents=True, exist_ok=True)
old = p.read_text() if p.exists() else ""
user = re.sub(r"# harness:start.*?# harness:end\n?", "", old, flags=re.S).rstrip("\n")
owned = set(re.findall(r"^\[mcp_servers\.([^]]+)\]", user, flags=re.M))
lines = ["# harness:start (managed by harness/mcp/install.sh)"]
for name, s in servers.items():
    if name in owned:
        print(f"mcp: preserving user-owned Codex server: {name}")
        continue
    lines.append(f"[mcp_servers.{name}]")
    if "command" in s:
        lines.append(f'command = "{s["command"][0]}"'); lines.append("args = " + json.dumps(s["command"][1:]))
    else:
        lines.append(f'url = "{s["url"]}"')
        if "bearer_env" in s: lines.append(f'bearer_token_env_var = "{s["bearer_env"]}"')
    lines.append("enabled = true"); lines.append("")
lines.append("# harness:end")
p.write_text((user + "\n\n" if user else "") + "\n".join(lines) + "\n"); print(f"mcp    -> {p}")
PY
echo "mcp: higgsfield needs a one-time login (codex mcp login higgsfield / first use in Claude). fal needs FAL_KEY exported."
