# Why the prompt is written this way

Notes from building and compacting the working agreement, kept so future
edits preserve what makes it work.

## Concrete banned examples beat abstract rules

"Never claim tiredness" is weaker than quoting the exact phrases a model has
produced ("sharper with fresh focus," "a decision I'd rather make deliberately
than tired"). Verbatim examples are the strongest anchors in the file. When
Claude does something annoying, capture the exact wording and add it as a
banned example rather than writing a broader abstract rule.

## Positive framing keeps quality up

A prompt that is only prohibitions pushes a model toward flat, minimal
output. The opening line ("effort goes to the problem, never to persona")
and the required pushback section give the effort somewhere to go. If
answers ever get terse to the point of unhelpful, this is the dial to
check before adding more rules.

## Suppression needs a pushback carve-out

Banning "second-guessing" wholesale suppresses useful corrections along with
the annoying commentary. The fix is to require technical objections (wrong
premise, bug, data loss, security hole) while bounding them: once, briefly,
with a concrete reason, then execute the confirmed instruction. Objections
cover correctness and consequences, never taste, tone, or values.

## Rules can misattribute; give accurate phrasings

Some declines are hard rules; others are judgment calls under general
guidelines. Forcing every block into one phrasing makes the model assert a
mechanism that is sometimes false. The prompt provides two forms so neither
is ever a false statement.

## Every rule competes for attention

Compliance per rule falls as rule count rises, so compaction is itself an
obedience technique. Keep one strong anchor example per rule and cut
restatements. When adding a rule, look for an old one it can absorb.

## Instruction-following degrades with context length

The file sits at the top of the context window; hundreds of thousands of
tokens later its pull weakens and trained defaults reassert. Prefer fresh
sessions per task over marathon sessions. Calling out a violation in the
moment is the strongest corrective signal and feeds persistent memory.

## Terse markdown is the efficient format

Short headers plus declarative bullets parse most reliably. Exotic compact
formats (tables, custom syntax, YAML) save few tokens and cost attention.
Compression comes from cutting connective prose, not from clever encoding.

## Test adversarially

After a major edit, probe the historical failure modes in a throwaway
session: long grinding tasks, late-night work, "should I keep going?".
Ten minutes of probing shows which rules hold and which need reinforcement.
