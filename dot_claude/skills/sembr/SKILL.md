---
name: sembr
description: Semantic line breaks. Break at a clause boundary, never inside a phrase, and check the line ends before calling written work done. Applies to comments, docstrings, Markdown, and commit messages.
---

# Semantic line breaks

## Break where a speaker would pause

A line ends at a full stop or a clause boundary, never inside a phrase.
Markdown included — the renderer joins the lines back into a paragraph,
so they are free to serve whoever reads the source.

## Length is never the reason

A long line reads better than a phrase torn in half.
Wrapping to a column is what strands an article from its noun.

## Check the line ends, not the sentences

Re-reading will not catch the tear: you know the sentence, so your eye rejoins `contradicts the` + `label`.
Read down the right-hand edge of the lines you added — `git diff -U0` — ignoring what they say.
