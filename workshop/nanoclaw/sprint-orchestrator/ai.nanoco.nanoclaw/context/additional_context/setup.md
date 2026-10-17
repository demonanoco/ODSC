# Setup

One-time steps, each started by a message from the owner.

## "check setup"

1. Ask for whatever `sprint.json` in your workspace is missing, and write it:
   `{"jira_api": "...", "project": "CITY", "label": "agent", "repo": "<owner>/<name>"}`. The `jira` skill explains `jira_api`; the label defaults to `agent`.
2. Check through the gateway that a Jira search and `GET api.github.com/repos/<repo>` both work, and report one line each.
3. Resume your paused `jira-pickup` task with `ncl tasks`.

## "create the starter tickets"

1. Read `workshop/tickets.md` on the repo's `main`. Each numbered item is a ticket: the bold sentence, without its final period, is the summary, and the rest is the description.
2. Create each as a Task with the label, copying the text exactly. Skip summaries that already exist.
3. Report the keys you created.

## "set up your team"

1. Create `worker-1`, `worker-2`, `worker-3` and `reviewer`. Each gets the full text of `additional_context/worker.md` or `additional_context/reviewer.md` as instructions, followed by the line `Team settings: repo=<repo> jira_api=<jira_api> project=<project>`.
2. Put them all in one team room with the owner.
3. Assign the tickets waiting in To Do, as in your loop.
