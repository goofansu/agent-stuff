---
name: mlwcli
description: Unified command-line interface for managing feeds (Miniflux), links (Linkding), and pages (Wallabag). Use for authentication, managing feeds, managing links, and managing pages.
---

# mlwcli

A unified command-line interface for managing feeds (via Miniflux), links (via Linkding), and pages (via Wallabag).

## Instructions

When using this CLI tool, follow these guidelines:

### Command Structure

Available commands:
```bash
# Authentication (interactive TUI)
mlwcli auth login        # Login to linkding, miniflux, or wallabag (interactive)
mlwcli auth logout       # Logout from a service (interactive)

# Linkding (Links)
mlwcli link add <url>    # Add link
mlwcli link list         # List links

# Miniflux (Feeds)
mlwcli feed add <url>    # Add feed
mlwcli feed list         # List feeds
mlwcli entry list        # List feed entries
mlwcli entry save <id>   # Save entry to third-party service

# Wallabag (Pages)
mlwcli page add <url>    # Add page
mlwcli page list         # List pages
```

Use `--help` on any command for options.

### Critical Guidelines

1. **Authentication is Interactive**:
   - `auth login` and `auth logout` use an interactive TUI (no service name argument)
   - The TUI presents a menu to select the service
   - Already signed-in services show a ✓ check mark
   - Login prompts for endpoint URL and credentials with validation
   - Logout only shows currently signed-in services

2. **Pagination**: All `list` commands return `{total, items}` structure:
   - `link list`, `entry list`: Use `--limit` and `--offset` for pagination (default: limit=10, offset=0)
   - `page list`: Use `--page` and `--per-page` for pagination (default: page=1, per-page=10)
   - `feed list`: Returns all feeds (no pagination parameters)

3. **Output Filtering**:
   - Use `--jq=expression` for inline filtering with jq expressions (automatically enables JSON output)
   - Use `--json=field1,field2` to select specific fields (comma-separated, no spaces)
   - Without `--json` or `--jq`, output is in human-readable table format
   - All list commands return structured JSON when using these flags

4. **Search and Filtering**:
   - `link list`: `--search`, `--limit`, `--offset`
   - `entry list`: `--search`, `--status` (read/unread/removed, default: unread), `--starred`, `--feed-id`, `--limit`, `--offset`
   - `page list`: `--archive`, `--starred`, `--tags`, `--domain`, `--page`, `--per-page`

5. **Quote Handling**:
   - For values with double quotes, wrap in single quotes: `--notes 'Title: "Example"'`
   - Tags are space-separated within a quoted string: `--tags "tag1 tag2"`

6. **Configuration**:
   - Config is stored at `~/.config/mlwcli/auth.toml`
   - Credentials are saved securely upon successful login

### Workflow Steps

1. **Before processing results**: Always check if you have all results by comparing `total` vs. returned items count
2. **When paginating**: Use appropriate pagination flags for the command type
3. **For targeted queries**: Use `--jq` to filter and transform output inline
4. **When adding content**: Include relevant metadata (notes, tags) for better organization

## Examples

### Authentication

Login and logout are fully interactive (no command-line arguments needed):

```bash
# Login - interactive TUI will prompt for service selection and credentials
mlwcli auth login

# Logout - interactive TUI will show only signed-in services
mlwcli auth logout
```

The TUI will:
- Show a menu to select service (Linkding, Miniflux, Wallabag)
- Mark already signed-in services with ✓
- Prompt for endpoint URL and credentials
- Validate input and normalize URLs (remove trailing slashes)

### Check total results before processing

Before processing results, verify you have all of them:

```bash
mlwcli entry list --status=unread --jq='{total: .total, returned: (.items | length)}'
```

If `total > returned`, either increase the limit or paginate with offset:

```bash
# Increase limit to get all results
mlwcli entry list --status=unread --limit=100

# Or paginate through results
mlwcli entry list --status=unread --limit=10 --offset=0
mlwcli entry list --status=unread --limit=10 --offset=10
mlwcli entry list --status=unread --limit=10 --offset=20
```

### List unread entries

Get unread entries with feed context:

```bash
mlwcli entry list --status=unread --jq='.items[] | { id, url, title, published_at, status, feed_id: .feed.id, feed_title: .feed.title }'
```

Output fields:
- `id`: Entry ID (use for marking read/starred or saving)
- `url`: Original article URL
- `feed_id`, `feed_title`: Source feed info for grouping/filtering

### List entries by feed

First, find the feed ID:

```bash
mlwcli feed list --jq='.items[] | { id, title, site_url }'
```

Then fetch entries from that feed:

```bash
mlwcli entry list --feed-id=42 --limit=20 --jq='.items[] | { id, url, title, published_at }'
```

### Find starred/read entries by date

Use `changed_at` to filter by when entries were starred or marked read:

```bash
mlwcli entry list --starred --status=read --limit=100 --json=id,url,title,changed_at,starred | jq '.items[] | select(.changed_at >= "2025-12-26")'
```

Note: `changed_at` reflects when the entry was last modified (starred, read status changed), not publication date.

### Save an entry to third-party services

First, find the entry you want to save by listing entries:

```bash
mlwcli entry list --status=unread --jq='.items[] | { id, url, title }'
```

Then save it using the entry ID:

```bash
mlwcli entry save 42
```

This saves the entry to Miniflux's third-party integration (e.g., Wallabag, Pocket, etc.), which must be configured in Miniflux settings.

### Add a Feed

```bash
mlwcli feed add <url>
```

The URL must point to a valid RSS/Atom feed.

### Add a feed to a category

First, find the category ID by listing feeds with category information:

```bash
mlwcli feed list --jq='.items[] | { id, title, site_url, category_id: .category.id, category_title: .category.title }'
```

Then add the feed with the category:

```bash
mlwcli feed add <url> --category-id=<category_id>
```

The `--category-id` parameter defaults to 1 (All category) if not specified.

### Add a link

Basic:
```bash
mlwcli link add <url>
```

With metadata:
```bash
mlwcli link add <url> --notes='Title: "Some Title"' --tags="tag1 tag2"
```

Tags are space-separated within the quoted string.

### Add a page

Basic:
```bash
mlwcli page add <url>
```

With metadata:
```bash
mlwcli page add <url> --tags="tag1 tag2" --archive
```

### List pages

Get pages with filtering:
```bash
mlwcli page list --starred --per-page=20 --jq='.items[] | { id, url, title, domain_name }'
```

Filter by domain or tags:
```bash
mlwcli page list --domain=example.com
mlwcli page list --tags="tech news"
```

Tags are space-separated within the quoted string.
