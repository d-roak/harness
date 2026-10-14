#!/usr/bin/env sh
# Blocks shell commands the rules forbid. Reads tool-call JSON on stdin.
set -eu

command="$(python3 -c '
import json, sys
payload = json.load(sys.stdin)
tool_input = payload.get("tool_input", payload)
value = tool_input.get("command", "")
if not isinstance(value, str):
    raise SystemExit("harness: command must be a string")
print(value)
')"
deny() { echo "harness: blocked. $1" >&2; exit 2; }

reason="$(COMMAND="$command" python3 - <<'PY'
import os, re, shlex

for part in re.split(r"(?:&&|\|\||;|\n)", os.environ["COMMAND"]):
    try:
        words = shlex.split(part)
    except ValueError:
        continue
    if not words:
        continue
    if words[:2] == ["git", "push"]:
        args = words[2:]
        if any(arg == "-f" or arg.startswith("-f") or arg == "--force" or arg.startswith("--force=") or arg.startswith("--force-with-lease") for arg in args):
            print("No force push. Rebase locally, push a new branch if you must.")
            raise SystemExit
    if words[:2] in (["git", "commit"], ["git", "push"]) and "--no-verify" in words[2:]:
        print("--no-verify skips the gate. Fix what the hook complains about.")
        raise SystemExit
    if words[:3] == ["git", "reset", "--hard"] or words[:2] == ["git", "clean"] and any("f" in arg.lstrip("-") for arg in words[2:] if arg.startswith("-")) or words[:3] == ["git", "checkout", "--"] or words[:3] == ["git", "restore", "."]:
        print("Destructive git on the working tree. Ask first.")
        raise SystemExit
    if words[0] == "rm":
        options = [arg for arg in words[1:] if arg.startswith("-")]
        short = "".join(arg[1:] for arg in options if not arg.startswith("--"))
        recursive = "r" in short or "--recursive" in options
        force = "f" in short or "--force" in options
        targets = [arg for arg in words[1:] if not arg.startswith("-") and arg != "--"]
        if recursive and force and any(target in {"/", "~", "$HOME"} or target.startswith(("~/", "$HOME/", "/Users/")) for target in targets):
            print("rm recursively on root or home. Ask first.")
            raise SystemExit
PY
)"
[ -z "$reason" ] || deny "$reason"

if [ -f pnpm-lock.yaml ]; then
	printf '%s\n' "$command" | grep -Eq '(^|[^a-z])(npm|yarn) +(i|install|add|remove|ci)([^a-z]|$)' && deny "This repo uses pnpm."
fi
exit 0
