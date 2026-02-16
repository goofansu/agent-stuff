# agent-stuff

This repository stores customizations for coding agents. Files are copied or symlinked into agent directories. For example, `~/.pi/agent/extensions` a symlink to the `pi/extensions` directory in this repository.

## pi extensions

The following are my custom extensions for [pi coding agent](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/):

* [`snippets.ts`](pi/extensions/snippets.ts) - Quickly view, copy, or ask for an explanation of code snippets from the last assistant message.
* [`librarian.ts`](pi/extensions/librarian.ts) - Cross-repository code research subagent. Spawns an isolated `pi` process to search and read code across GitHub repositories using `gh` CLI. Invokable as a tool by the agent or directly via `/librarian`.
