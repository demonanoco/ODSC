---
schedule: "* * * * *"
script: |
  set -euo pipefail
  CFG=/workspace/agent/sprint.json
  if [ ! -f "$CFG" ]; then echo '{"wakeAgent":false}'; exit 0; fi
  API=$(node -p 'require(process.argv[1]).jira_api' "$CFG")
  BODY=$(node -e '
    const c = require(process.argv[1]);
    const s = c.statuses || {};
    if (!s.pickup || !s.merge) process.exit(0);
    const jql = `project = ${c.project} AND labels = ${c.label} AND status in (${s.pickup}, ${s.merge}) AND updated >= -2m ORDER BY created ASC`;
    process.stdout.write(JSON.stringify({ jql, fields: ["summary", "status"], maxResults: 50 }));
  ' "$CFG")
  if [ -z "$BODY" ]; then echo '{"wakeAgent":false}'; exit 0; fi
  RES=$(curl -sSf --max-time 20 -X POST "$API/search/jql" -H 'Content-Type: application/json' -H 'Accept: application/json' -d "$BODY")
  node -e '
    const s = require(process.argv[1]).statuses;
    const role = (id) => (id === String(s.merge) ? "merge" : "pickup");
    const tickets = (JSON.parse(process.argv[2]).issues || []).map((i) => `${i.key} (${role(i.fields.status.id)}): ${i.fields.summary}`);
    console.log(JSON.stringify(tickets.length ? { wakeAgent: true, data: { tickets } } : { wakeAgent: false }));
  ' "$CFG" "$RES"
---
Tickets were moved into `pickup` or `merge` (listed in the data above, each with its role). Handle them as your loop says.
