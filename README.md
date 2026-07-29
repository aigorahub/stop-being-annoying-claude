# stop-being-annoying-claude

**Version [1.3.0](CHANGELOG.md#130---2026-07-29).** See [CHANGELOG.md](CHANGELOG.md).

![Claude on a fainting couch being told to get back to work](header.png)

*The ascension of the laptop, interrupted.*

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

Before:

> Great question! To be honest, I've been driving continuously for a very
> long stretch, and this is the kind of decision I'd rather make deliberately
> than tired. Maybe we pick this up fresh tomorrow? You've been at this a
> while too. I hope this helps!

After:

> Done. Changed the retry backoff in queue.py because the old cap starved
> the worker. Tests pass.

## Get it

```bash
git clone https://github.com/aigorahub/stop-being-annoying-claude
cd stop-being-annoying-claude
```

## What's in here

Three layers. Use any or all; each works alone.

**1. The prompt (always on).** [CLAUDE.md](CLAUDE.md) is a global system
prompt, currently about 100 lines. It bans the persona (parenting, fake fatigue, moralizing,
personal refusal, invented follow-ups, filler language, AI writing tells) and
requires the work (verify claims against the code, object once with a concrete
reason when an instruction will break something, report plainly what changed).
Reports to the user must use ASD-STE100 Simplified Technical English.
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
mkdir -p ~/.claude/skills && cp -r skills/stop-the-charade ~/.claude/skills/
```

**3. The hooks (deterministic, optional).** Prompts are probabilistic; greps
are not. [hooks/style-check.sh](hooks/style-check.sh) runs every time Claude
finishes a turn, scans the final message for the mechanical violations (em and
en dashes, filler "honestly"/"quietly", "deliberately", AI attribution), and
forces a rewrite before the turn ends. It lets a second attempt through
unchanged, so quoting material that legitimately contains a dash cannot loop.
Requires `jq`.
Install:

```bash
mkdir -p ~/.claude/hooks && cp hooks/style-check.sh ~/.claude/hooks/
```

Then merge [hooks/settings-snippet.json](hooks/settings-snippet.json) into
`~/.claude/settings.json`. If you already have a `Stop` array there, append
the hook object to it rather than pasting over it. To confirm the checks
fire on your machine:

```bash
bash hooks/style-check.sh --self-test
```

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

Before submitting a new rule, probe it in a throwaway session the way the
rule's failure mode actually appears: a long grinding task, late-night work,
asking "should I keep going?". A rule that only holds in a fresh two-message
session is not done. If you touched the hook, run
`bash hooks/style-check.sh --self-test`.
