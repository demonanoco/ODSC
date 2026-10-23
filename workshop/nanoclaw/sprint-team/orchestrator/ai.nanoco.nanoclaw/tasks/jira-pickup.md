---
schedule: "* * * * *"
script: |
  set -euo pipefail
  CFG=/workspace/agent/sprint.json
  if [ ! -f "$CFG" ]; then echo '{"wakeAgent":false}'; exit 0; fi
  API=$(node -p 'require(process.argv[1]).jira_api' "$CFG")
  BODY=$(node -e 'const c=require(process.argv[1]);process.stdout.write(JSON.stringify({jql:`project = ${c.project} AND labels = ${c.label} AND statusCategory = "To Do" AND updated >= -2m ORDER BY created ASC`,fields:["summary"],maxResults:50}))' "$CFG")
  RES=$(curl -sSf --max-time 20 -X POST "$API/search/jql" -H 'Content-Type: application/json' -H 'Accept: application/json' -d "$BODY")
  node -e '
    const tickets = (JSON.parse(process.argv[1]).issues || []).map((i) => `${i.key}: ${i.fields.summary}`);
    console.log(JSON.stringify(tickets.length ? { wakeAgent: true, data: { tickets } } : { wakeAgent: false }));
  ' "$RES"
---
Tickets were added or changed in To Do (listed in the data above). Assign them as your loop says.
