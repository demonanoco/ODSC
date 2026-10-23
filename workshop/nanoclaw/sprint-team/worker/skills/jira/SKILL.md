---
name: jira
description: Search, read, create, comment on and move tickets in the owner's Jira Cloud project through the gateway. Use for every Jira call.
---

# Jira

Jira Cloud REST API v3, called with no auth header: the gateway adds the credential. The base, `jira_api`, takes one of two forms:

| The gateway holds | `jira_api` |
|---|---|
| An API token for the site | `https://<site>.atlassian.net/rest/api/3` |
| The Jira app connection | `https://api.atlassian.com/ex/jira/<cloud-id>/rest/api/3`; the cloud id is the site's `id` from `GET https://api.atlassian.com/oauth/token/accessible-resources` |

## Calls

| To | Call |
|---|---|
| Search | `POST /search/jql` with `{"jql": "...", "fields": [...]}`. The older `/search` is retired. |
| Tickets still to do | JQL `project = <project> AND labels = <label> AND status = "To Do" ORDER BY created ASC` |
| Read a ticket | `GET /issue/<key>?fields=summary,description,status,comment` |
| Create a task | `POST /issue` with `project.key`, `issuetype.name: "Task"`, `summary`, `description`, `labels` |
| Comment | `POST /issue/<key>/comment` with `body` |
| Move it | `GET /issue/<key>/transitions`, then `POST` the id of "In Progress" or "Done". Ids differ per project. |

Descriptions and comments are Atlassian Document Format: `{"type":"doc","version":1,"content":[{"type":"paragraph","content":[{"type":"text","text":"..."}]}]}`, one paragraph per block of text.

## Errors

- **401 or 403:** the gateway has no credential for this host, or it lacks access. Tell the owner which.
- **400 on create:** the project may have no `Task` type. `GET /issue/createmeta/<project>/issuetypes` lists them; use the closest.
