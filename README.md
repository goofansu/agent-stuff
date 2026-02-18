# pi-stuff

This repository stores customizations for the [pi coding agent](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/).

Files and directories are symlinked into `~/.pi/agent/`:

- [`extensions`](extensions) → `~/.pi/agent/extensions/`
- [`skills`](skills) → `~/.pi/agent/skills/`
- [`keybindings.json`](keybindings.json) → `~/.pi/agent/keybindings.json`

## Extensions

All extension files are in the [`extensions`](extensions) directory:

- [`snippets.ts`](extensions/snippets.ts) - Code snippet viewer for the last assistant message. Lists markdown code blocks and lets you copy them to clipboard or ask for an explanation with custom instructions.
- [`librarian.ts`](extensions/librarian.ts) - Cross-repository code research subagent. Spawns an isolated `pi` process with kimi-coding/k2p5 (cost-efficient default) to search and read code across GitHub repositories using `gh` CLI.
- [`oracle.ts`](extensions/oracle.ts) - Second opinion reasoning subagent. Spawns an isolated `pi` process with openai-codex/gpt-5.2 for complex analysis, debugging, and review tasks.

## Skills

All skill files are in the [`skills`](skills) directory:

- [`commit`](skills/commit) - For creating git commits with concise Conventional Commits-style subjects. ([via](https://github.com/mitsuhiko/agent-stuff/tree/main/skills/commit))
- [`gh-issue-sync`](skills/gh-issue-sync) - For using `gh-issue-sync` command to manage GitHub issues. ([via](https://github.com/mitsuhiko/gh-issue-sync/blob/main/skill/SKILL.md))
- [`mlwcli`](skills/mlwcli) - For using `mlwcli` command to manage Miniflux, Linkding, and Wallabag. ([via](https://github.com/goofansu/mlwcli/blob/main/skill/SKILL.md))
- [`web-browser`](skills/web-browser) - For browsing the web by controlling Chrome/Chromium via CDP actions. ([via](https://github.com/mitsuhiko/agent-stuff/tree/main/skills/web-browser))
