CURRENT_DIR := $(abspath $(CURDIR))

install:
	pi install $(CURRENT_DIR)

add-skills:
	npx skills add https://github.com/anthropics/skills -s skill-creator -g -a codex -y
	npx skills add https://github.com/mitsuhiko/gh-issue-sync -s gh-issue-sync -g -a codex -y

update-skills:
	npx skills update
