---
name: roe
description: What the user has authorized this session — committing, pushing, queueing pipelines, deploying, anything hard to undo or outward-facing. Read it before any such action without a go-ahead this turn, and after the context is summarized.
---

# Rules of engagement

The session's rules live in `~/.claude/roe/$CLAUDE_CODE_SESSION_ID.md`.

- `/roe` — show what is in force.
- `/roe <rule>` — merge it into the set, newer winning on conflict, then show the result.
  Keep the user's wording; ask instead of guessing when the merged set cannot be enforced.
- `/roe clear` — show what is in force, confirm, then delete the file.
  In the same `AskUserQuestion`, list the other files in `~/.claude/roe/` with their dates and delete the ones the user picks.

Only `/roe` changes them — a permission given in passing binds for the task at hand but does not go in the file.
