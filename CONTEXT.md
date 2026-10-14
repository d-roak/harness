# Context

## Installation Module

The installation module applies harness-managed setup to one or more install targets.

## Install Target

An install target is one named destination: `claude`, `codex`, `opencode`, or `mcp`. `all` runs the shared phase and every install target.

## Shared Phase

The shared phase installs shared skills and command-line tools. Individual install targets do not run it.

## Target Adapter

A target adapter applies managed setup for one tool without changing another target's files.

## Managed Content

Managed content is harness-owned configuration that the installer may replace on later runs.

## Ownership Marker

An ownership marker identifies managed content. Content without a marker remains user-owned.

## User-Owned Collision

A user-owned collision is an existing path or configuration entry that conflicts with harness content. The installer preserves it, except a conflicting non-symlink skill path stops installation.

## MCP Compatibility Wrapper

The MCP compatibility wrapper preserves direct MCP installation while delegating to the installation module.
