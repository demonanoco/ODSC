# Setup

One-time steps, each started by a message from the owner.

## "check setup"

Fill `sprint.json` in your workspace, finding what you can and asking only for the rest. Keep what is already there.

1. **Jira site:** find `jira_api` as the `jira` skill explains. If the gateway's Jira app reaches more than one site, or only a site token is set up, ask which site.
2. **Project:** list the projects you can see (`GET /project/search`) and ask the owner which one to use, unless there is only one.
3. **Repository:** ask for it as `<owner>/<name>`, and check `GET api.github.com/repos/<repo>` works.
4. **Label:** `agent`, unless the owner names another.
5. **Board:** read the project's statuses and pick one for each role in your instructions' board table, by meaning rather than exact name. Show the owner the mapping as a table. For a role with no fitting status, suggest a column name (`Review` for `ready`, `Merge` for `merge`) and ask the owner to add it; you can't. Map again once they say it's there.
6. **Write `sprint.json`**, with the status ids:
   ```json
   {"jira_api": "...", "project": "<key>", "label": "agent", "repo": "<owner>/<name>",
    "statuses": {"parked": "<id>", "pickup": "<id>", "working": "<id>", "ready": "<id>", "merge": "<id>", "done": "<id>"}}
   ```
7. **Start the Jira check:** resume your paused `jira-pickup` task with `ncl tasks`, then report the setup in a few lines.

## "create the starter tickets"

1. Read `workshop/tickets.md` on the repo's `main`. Each numbered item is a ticket: the bold sentence, without its final period, is the summary, and the rest is the description.
2. Create each as a Task with the label, copying the text exactly. Skip summaries that already exist.
3. Report the keys you created. New tickets land in the board's first column; the owner moves them to `pickup` when they want them started.

## "set up your team"

1. Create `worker-1`, `worker-2` and `worker-3` with the template `sprint-team/worker`, and `reviewer` with `sprint-team/reviewer`, each with `room: 'none'`.
2. Put the four of them in one team room with the owner, using `create_room`.
3. Tell the owner the team is up, then assign the tickets waiting in `pickup`, as in your loop.
