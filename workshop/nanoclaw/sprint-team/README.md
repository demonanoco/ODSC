# Sprint Team

Three NanoClaw templates that run a small team of coding agents on one GitHub repository. The orchestrator picks up Jira tickets labelled `agent`, gives each to a worker, has the reviewer check every pull request, and merges only when you say so.

| Template | Agent | Does |
|---|---|---|
| `sprint-team/orchestrator` | Orchestrator | Watches Jira, assigns tickets, routes reviews, asks you before each merge |
| `sprint-team/worker` | `worker-1` … `worker-3` | One ticket at a time: a worktree from the latest `main`, the change, tests, a pull request |
| `sprint-team/reviewer` | `reviewer` | Checks each pull request against its ticket and the repo's `AGENTS.md`, and runs the tests |

You install the orchestrator. It creates the workers and the reviewer itself, from their templates, when you say "set up your team".

## Install

1. Copy this `sprint-team` folder into your NanoClaw install's `templates/` folder.
2. Run the installer and, at "How should we create your first agent?", choose **From local templates**, then **orchestrator** (`sprint-team/orchestrator`).

## Gateway

The agents hold no credentials. Add these in the OneCLI dashboard:

| Service | Credential |
|---|---|
| GitHub | A fine-grained token for your repo only: Contents and Pull requests read and write, Actions read. Or the GitHub App connection. |
| Jira | An API token for your site, or the Jira app connection |

On OneCLI 1.44 and later, a new agent gets only its model credential. Grant GitHub and Jira to the orchestrator after install, and to the four new agents after "set up your team": in each connection's **Agent access** dialog, or with `onecli agents grants attach-secret`.

And these rules (to be re-checked on OneCLI 1.45, where access is set per grant):

| Request | Rule |
|---|---|
| `PUT api.github.com/repos/*/pulls/*/merge` | Ask: you approve each merge in chat |
| `DELETE api.github.com/repos/*/git/refs/*` | Block: no agent deletes branches |
| `PATCH`, `PUT` or `DELETE api.github.com/repos/<owner>/<repo>` and its settings | Block |

## Talk to it

| Say | It does |
|---|---|
| `check setup` | Asks for your Jira site, project and repo, checks both through the gateway, and starts the Jira check |
| `create the starter tickets` | Creates the tickets in the repo's `workshop/tickets.md`, word for word |
| `set up your team` | Creates the three workers and the reviewer, and a team room |
| `merge` | After a "PR ready" message: merges that pull request, once you approve it in chat |
