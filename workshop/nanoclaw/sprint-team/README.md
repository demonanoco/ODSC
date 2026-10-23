# Sprint Team

Three NanoClaw templates that run a small team of coding agents on one GitHub repository. You drive it from your Jira board: drag a ticket to start it, drag it again to merge it. The orchestrator gives each ticket to a worker, has the reviewer check every pull request, and merges only what you approved.

| Template | Agent | Does |
|---|---|---|
| `sprint-team/orchestrator` | Orchestrator | Watches your board, assigns tickets, routes reviews, merges what you approve |
| `sprint-team/worker` | `worker-1` … `worker-3` | One ticket at a time: a worktree from the latest `main`, the change, tests, a pull request |
| `sprint-team/reviewer` | `reviewer` | Checks each pull request against its ticket and the repo's `AGENTS.md`, and runs the tests |

You install the orchestrator. It creates the workers and the reviewer itself, from their templates, when you say "set up your team".

## Install

1. Copy this `sprint-team` folder into your NanoClaw install's `templates/` folder.
2. Run the installer and, at "How should we create your first agent?", choose **From local templates**, then **orchestrator** (`sprint-team/orchestrator`).

## Your board

"check setup" maps your board's columns to these roles and asks you to add any that are missing:

| Role | Typical column | Who moves cards there |
|---|---|---|
| Parked | Backlog | You |
| Start | To Do | You |
| Working | In Progress | Orchestrator |
| Ready for you | Review | Orchestrator, once reviewed and CI passed |
| Merge | Merge | You |
| Done | Done | Orchestrator |

## Gateway

The agents hold no credentials. On OneCLI 1.44 and later, a new agent gets only its model credential: grant GitHub and Jira to each agent in the connection's **Agent access** dialog, the orchestrator after install and the other four after "set up your team".

| Agent | GitHub | Jira |
|---|---|---|
| Orchestrator | Read repository, list pull requests, GraphQL queries: allow. GraphQL mutations: **ask** (this is the merge). Everything else: block | Full |
| Workers | Clone, push, create pull request, comment, read: allow. GraphQL mutations, delete branch: block | Full |
| Reviewer | Clone, read, comment: allow. Everything else: block | Full |

A merge through GitHub's REST endpoint has no action of its own, so a limited grant blocks it. The orchestrator merges through GraphQL, which waits for your approval in Slack.

The gateway can't tell branches apart on a push. Protect `main` on GitHub so a pushed branch can only land through a pull request.

## Talk to it

| Say | It does |
|---|---|
| `check setup` | Finds your Jira site, asks for the project and repository, maps your board, and starts watching it |
| `create the starter tickets` | Creates the tickets in the repo's `workshop/tickets.md`, word for word |
| `set up your team` | Creates the three workers and the reviewer, and a team room |
