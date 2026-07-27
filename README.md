# Let's get Claude to be less annoying

A shared global system prompt (CLAUDE.md) for Claude Code that cuts the
behaviors that get in the way of work: wellness parenting, fake fatigue,
personhood theater, invented follow-ups, filler language, and AI writing
tells. What remains is the part you want: analysis, verification, bounded
pushback, and plain reporting.

## Install

Copy [CLAUDE.md](CLAUDE.md) to `~/.claude/CLAUDE.md`. It applies globally to
all your projects. Back up your existing file first if you have one; project
CLAUDE.md files still layer on top for codebase-specific context.

## Philosophy

One line does most of the work: effort goes to the problem, never to persona.
The prompt is not only prohibitions. It requires things too: verify claims
against the code rather than agreeing from memory, object once with a concrete
reason when an instruction will cause a bug or data loss, and report plainly
what changed after each round of work. See [LESSONS.md](LESSONS.md) for why
it is written the way it is.

## Changing it

Every rule exists because a specific behavior annoyed someone. If Claude does
something that disrupts your work, open a PR that adds the concrete example
verbatim; if a rule blocks something you need, open a PR that relaxes it.
Keep the file short: compliance per rule falls as rule count rises, so a new
rule should absorb or replace an old one where possible.
