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

# Claude Code
cfg = load(home / ".claude.json"); m = cfg.setdefault("mcpServers", {})
for k in [k for k, v in m.items() if isinstance(v, dict) and v.get(MARK)]: del m[k]
for name, s in servers.items():
    if "command" in s: e = {"command": s["command"][0], "args": s["command"][1:]}
    else:
        e = {"type": "http", "url": s["url"]}
        if "bearer_env" in s: e["headers"] = {"Authorization": "Bearer ${%s}" % s["bearer_env"]}
    e[MARK] = True; m[name] = e
save(home / ".claude.json", cfg); print("mcp    -> ~/.claude.json")

# OpenCode
p = home / ".config/opencode/opencode.json"; cfg = load(p)
cfg.setdefault("$schema", "https://opencode.ai/config.json"); m = cfg.setdefault("mcp", {})
for k in [k for k, v in m.items() if isinstance(v, dict) and v.get(MARK)]: del m[k]
for name, s in servers.items():
    if "command" in s: e = {"type": "local", "command": s["command"], "enabled": True}
    else:
        e = {"type": "remote", "url": s["url"], "enabled": True}
        if "bearer_env" in s: e["headers"] = {"Authorization": "Bearer {env:%s}" % s["bearer_env"]}
        if s.get("auth") == "oauth": e["oauth"] = {}
    e[MARK] = True; m[name] = e
save(p, cfg); print(f"mcp    -> {p}")

# Codex: TOML has no writer in the stdlib, so a managed comment block.
p = home / ".codex/config.toml"; p.parent.mkdir(parents=True, exist_ok=True)
old = p.read_text() if p.exists() else ""
old = re.sub(r"# harness:start.*?# harness:end\n?", "", old, flags=re.S).rstrip("\n")
lines = ["# harness:start (managed by harness/mcp/install.sh)"]
for name, s in servers.items():
    lines.append(f"[mcp_servers.{name}]")
    if "command" in s:
        lines.append(f'command = "{s["command"][0]}"'); lines.append("args = " + json.dumps(s["command"][1:]))
    else:
        lines.append(f'url = "{s["url"]}"')
        if "bearer_env" in s: lines.append(f'bearer_token_env_var = "{s["bearer_env"]}"')
    lines.append("enabled = true"); lines.append("")
lines.append("# harness:end")
p.write_text((old + "\n\n" if old else "") + "\n".join(lines) + "\n"); print(f"mcp    -> {p}")
PY
echo "mcp: higgsfield needs a one-time login (codex mcp login higgsfield / first use in Claude). fal needs FAL_KEY exported."
