CURRENT_DIR := $(abspath $(CURDIR))

install:
	pi install $(CURRENT_DIR)

add-skills:
	npx skills add anthropics/skills -s skill-creator -g -a codex -y
	npx skills add mitsuhiko/gh-issue-sync -g -a codex -y
	npx skills add mitsuhiko/agent-stuff -s commit -s web-browser -g -a codex -y

update-skills:
	npx skills update
