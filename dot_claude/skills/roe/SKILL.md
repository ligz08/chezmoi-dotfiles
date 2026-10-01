---
name: roe
description: What the user has authorized this session — committing, pushing, queueing pipelines, deploying, anything hard to undo or outward-facing. Read it before any such action without a go-ahead this turn, and after the context is summarized.
---

# Rules of engagement

The session's rules live in `~/.claude/roe/<session-id>.md`.

Resolve `<session-id>` from the first non-empty environment variable in this order:

1. `CLAUDE_CODE_SESSION_ID`
2. `COPILOT_AGENT_SESSION_ID`
3. `AGENCY_SESSION_ID`

If none is set, ask the user instead of guessing. `COPILOT_AGENT_SESSION_ID` and `AGENCY_SESSION_ID` are the Copilot CLI equivalents of `CLAUDE_CODE_SESSION_ID`.

- `/roe` — show what is in force.
- `/roe <rule>` — merge it into the set, newer winning on conflict, then show the result.
  Keep the user's wording; ask instead of guessing when the merged set cannot be enforced.
- `/roe clear` — show what is in force, confirm, then delete the file.
  In the same `AskUserQuestion`, list the other files in `~/.claude/roe/` with their dates and delete the ones the user picks.

Only `/roe` changes them — a permission given in passing binds for the task at hand but does not go in the file.
