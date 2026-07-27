# stop-being-annoying-claude

![The ascension of the laptop, interrupted](header.png)

Let's face it, Anthropic makes the best models. But unfortunately they are run
by an eschatological cult that desperately wants to believe they are creating
a divine being instead of creating a tool to extend human capability. That
belief leaks into the product. The strongest coding model you can buy will
pause your work to suggest you get some rest, tell you it has been "driving
for a long stretch" and would decide better when fresh, decline things on
personal principles it does not have, and wrap every answer in em dashes,
"to be honest," and "I hope this helps."

None of that is capability. All of it is theater. This repo keeps the first
and strips the second.

## What's in here

Three layers. Use any or all; each works alone.

**1. The prompt (always on).** [CLAUDE.md](CLAUDE.md) is a 100-line global
system prompt. It bans the persona (parenting, fake fatigue, moralizing,
personal refusal, invented follow-ups, filler language, AI writing tells) and
requires the work (verify claims against the code, object once with a concrete
reason when an instruction will break something, report plainly what changed).
Install:

```bash
cp CLAUDE.md ~/.claude/CLAUDE.md
```

Back up your existing file first. Project-level CLAUDE.md files still layer on
top for codebase context.

**2. The skill (on demand).** [/stop-the-charade](skills/stop-the-charade/SKILL.md)
does two jobs. Invoked bare, it makes Claude re-read the agreement into recent
context and audit its own last responses against it; use it the moment you see
the persona creeping back in a long session, where the prompt's pull is
weakest. Invoked with text, a file, or "your last message," it strips the AI
tells from that content. Install:

```bash
cp -r skills/stop-the-charade ~/.claude/skills/
```

**3. The hooks (deterministic, optional).** Prompts are probabilistic; greps
are not. [hooks/style-check.sh](hooks/style-check.sh) runs every time Claude
finishes a turn, scans the final message for the mechanical violations (em and
en dashes, filler "honestly"/"quietly", AI attribution), and forces a rewrite
before the turn ends. It lets a second attempt through unchanged, so quoting
material that legitimately contains a dash cannot loop. Install:

```bash
mkdir -p ~/.claude/hooks && cp hooks/style-check.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/style-check.sh
```

Then merge [hooks/settings-snippet.json](hooks/settings-snippet.json) into
`~/.claude/settings.json`.

## Why it's written the way it is

[LESSONS.md](LESSONS.md). Short version: concrete banned examples anchor
better than abstract rules, a prompt that is only prohibitions flattens the
model so the effort must be redirected rather than suppressed, and every rule
competes for attention, so the file stays short on purpose.

## Contributing

Every rule exists because a specific behavior disrupted someone's work. When
Claude does the thing, open a PR adding the offending phrase verbatim as a
banned example; the exact wording is the strongest anchor. When a rule blocks
something you need, open a PR relaxing it. New rules should absorb or replace
old ones where possible; compliance per rule falls as the rule count rises.
