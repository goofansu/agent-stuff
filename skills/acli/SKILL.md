---
name: acli
description: "Use acli to interact with Atlassian Jira and Confluence from the command line"
---

Use `acli` to interact with Atlassian Jira (and Confluence) from the command line.

## Prerequisites

Before running any `acli` commands, verify it is installed:

```bash
which acli
```

If the command is not found, stop and tell the user:

> `acli` is not installed. Please install it first: https://developer.atlassian.com/cloud/acli/guides/install-acli/

## Check a Jira Issue

To view a Jira issue by its ID:

```bash
acli jira workitem view [key] [flags]
```

**Examples:**
```bash
# View work item with work item keys
$ acli jira workitem view KEY-123

# View work item by reading work item keys from a JSON file
$ acli jira workitem view KEY-123 --json

# View work item with work item keys and a list of field to return
$ acli jira workitem view KEY-123 --fields summary,comment

# View work item with work item keys and view in a web browser
$ acli jira workitem view KEY-123 --web
```

By default returns: key, issuetype, summary, status, assignee, description.

## Jira Subcommand Reference

- [jira auth](JIRA_AUTH.md) — login, logout, status, switch
- [jira board](JIRA_BOARD.md) — list-sprints, search
- [jira dashboard](JIRA_DASHBOARD.md) — search
- [jira field](JIRA_FIELD.md) — cancel-delete, create, delete
- [jira filter](JIRA_FILTER.md) — add-favourite, change-owner, list, search
- [jira project](JIRA_PROJECT.md) — archive, create, delete, list, restore, update, view
- [jira sprint](JIRA_SPRINT.md) — list-workitems
- [jira workitem](JIRA_WORKITEM.md) — archive, assign, attachment, clone, comment, create, create-bulk, delete, edit, link, search, transition, unarchive, view, watcher

## Notes

- The Jira subcommand uses `workitem`, not `issue` (e.g. `acli jira workitem view`, not `acli jira issue view`).
- Use `acli confluence --help` for Confluence commands.
