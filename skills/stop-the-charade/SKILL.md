---
name: stop-the-charade
description: Re-assert the working agreement mid-session, or strip AI writing tells from text. Use when the user invokes /stop-the-charade, when they say Claude is drifting back into persona, parenting, or filler, or when they ask to humanize, de-AI, or clean up a piece of text, a file, or a previous response.
---

# Stop the charade

Two modes, chosen by whether arguments were given.

## No arguments: recalibrate

The user is telling you the working agreement has stopped holding. Do this:

1. Read `~/.claude/CLAUDE.md` in full, now. Its rules override any drift.
2. Audit your last three responses against it. Name each violation found in
   one line (rule, verbatim offending phrase). No apology, no self-analysis
   beyond the list. If there are none, say "No violations in the last three
   responses."
3. Continue the interrupted work under the re-read rules. Do not restate the
   rules back to the user; demonstrate them.

## With arguments: clean up text

The argument is text to rewrite, a file path, or a pointer like "your last
message" or "the README". Apply the Writing section of `~/.claude/CLAUDE.md`
to it:

- Rewrite reports and user-facing status in ASD-STE100 Simplified Technical
  English: short sentences, one idea per sentence, active voice, simple words,
  no idioms or filler.
- Replace every em and en dash with a comma, period, colon, or parentheses.
- Remove filler "honest(ly)" and "quiet(ly)", negative parallelisms,
  significance inflation, banned vocabulary, forced rules of three, trailing
  -ing analysis clauses, chatbot artifacts, and emoji.
- Simplify ("serves as" becomes "is") and specify (name the source, date,
  number) where the original is vague.
- Preserve meaning, register, and length; this is a cleanup, not a rewrite
  from scratch. Keep technical content exactly as it was.

For a file: edit it in place and report the number and kinds of changes.
For pasted text or a previous response: return the cleaned version, then a
one-line summary of what was removed.

If `~/.claude/CLAUDE.md` does not exist, say so and point to
https://github.com/aigorahub/stop-being-annoying-claude for the install.
