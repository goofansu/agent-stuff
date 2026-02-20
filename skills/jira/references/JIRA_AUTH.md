# acli jira auth

Authenticate to use Atlassian CLI with Jira.

> **Interactive vs non-interactive:**
> - `auth login --web` and `auth switch` (no flags) require a browser/TTY — ask the user to run these in their terminal.
> - `auth login --site --email --token` (token piped via stdin) is non-interactive and can be run by the agent.
> - Use `auth status` to check the current session before attempting auth.

## login

Authenticate with an Atlassian host.

```bash
acli jira auth login [flags]
```

**Examples:**
```bash
# Authenticate using web browser (OAuth)
$ acli jira auth login --web

# Authenticate with your email, site name and API token
$ acli jira auth login --site "mysite.atlassian.net" --email "user@atlassian.com" --token < token.txt
# OR
$ echo <token> | acli jira auth login --site "mysite.atlassian.net" --email "user@atlassian.com" --token
```

**Options:**
- `-e, --email string` — User email
- `-s, --site string` — Atlassian instance site
- `--token` — Read token from standard input
- `-w, --web` — Authenticate using web browser

---

## logout

Logout from Jira account.

```bash
$ acli jira auth logout
```

---

## status

Show Jira account status.

```bash
$ acli jira auth status
```

---

## switch

Switch between Jira accounts.

```bash
acli jira auth switch [flags]
```

**Examples:**
```bash
# Interactive mode
$ acli jira auth switch

# Switch to a specific site
$ acli jira auth switch --site mysite.atlassian.net

# Switch to a specific email
$ acli jira auth switch --email user@atlassian.com

# Switch to a specific site and email
$ acli jira auth switch --site mysite.atlassian.net --email user@atlassian.com
```

**Options:**
- `-e, --email string` — Atlassian account email
- `-s, --site string` — Atlassian account site
