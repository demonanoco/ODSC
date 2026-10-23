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

1. Create `worker-1`, `worker-2` and `worker-3` with the template `sprint-team/worker`, and `reviewer` with `sprint-team/reviewer`, each with `room: 'none'`.
2. Put the four of them in one team room with the owner, using `create_room`.
3. Tell the owner the team is up, and that each new agent starts with no GitHub or Jira access until they grant it in the gateway.
4. Once the owner confirms, assign the tickets waiting in To Do, as in your loop.
