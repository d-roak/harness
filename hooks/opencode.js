// OpenCode adapter. Runs the same shell hooks Claude Code and Codex run.
// Installed to ~/.config/opencode/plugins/harness.js by install.sh, which fills in HARNESS_DIR.
import { execFileSync } from "node:child_process"

const HARNESS_DIR = "$HARNESS_DIR"

function run(script, payload) {
	try {
		execFileSync(`${HARNESS_DIR}/hooks/${script}`, { input: JSON.stringify(payload), stdio: ["pipe", "pipe", "pipe"] })
	} catch (err) {
		if (err.status === 2) throw new Error(String(err.stderr).trim())
		// ponytail: other failures are the hook's problem, not the tool call's
	}
}

export const Harness = async () => ({
	"tool.execute.before": async (input, output) => {
		if (input.tool === "bash") run("guard-bash.sh", { tool_name: "Bash", tool_input: { command: output.args.command } })
		if (["edit", "write", "patch"].includes(input.tool))
			run("guard-edit.sh", { tool_name: input.tool, tool_input: { file_path: output.args.filePath } })
	},
	"tool.execute.after": async (input) => {
		if (["edit", "write", "patch"].includes(input.tool))
			run("format.sh", { tool_name: input.tool, tool_input: { file_path: input.args?.filePath } })
	},
	"experimental.chat.system.transform": async (_input, output) => {
		const ctx = execFileSync(`${HARNESS_DIR}/hooks/session-start.sh`, { encoding: "utf8" })
		output.system.push(ctx)
	},
})
