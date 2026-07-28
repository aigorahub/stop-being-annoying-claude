#!/bin/bash
# Stop hook: scans Claude's final message for mechanical writing violations
# and blocks with a reason so Claude rewrites before the turn ends.
# Guards against loops: lets the second attempt through even if still dirty.
#
# Scope note: this catches only the mechanically greppable subset of the
# working agreement (dashes, adverb filler, attribution). Mood-word uses of
# "honest"/"quiet" ("a quiet confidence") need context and are left to the
# prompt. Do not widen these greps; they will false-positive on literal uses.
#
# Requires jq. Run `bash style-check.sh --self-test` after editing.

# Byte-exact patterns so matching works in any locale (a C/POSIX locale
# makes bracket expressions like [—–] match individual UTF-8 bytes, which
# false-positives on curly quotes, bullets, and arrows).
EM=$(printf '\xe2\x80\x94')
EN=$(printf '\xe2\x80\x93')
ROBOT=$(printf '\xf0\x9f\xa4\x96')

command -v jq >/dev/null 2>&1 || { echo "style-check.sh: jq not found; hook inactive" >&2; exit 0; }

check() {
  local text="$1" violations=""
  printf '%s' "$text" | grep -qF -e "$EM" -e "$EN" && violations="$violations em-or-en-dash;"
  printf '%s' "$text" | grep -qiE '(^|[^a-zA-Z])(honestly|to be honest|quietly)([^a-zA-Z]|$)' \
    && violations="$violations filler-honest-or-quiet;"
  if printf '%s' "$text" | grep -qiE 'co-authored-by:|generated with claude' \
     || printf '%s' "$text" | grep -qF "$ROBOT"; then
    violations="$violations ai-attribution;"
  fi
  printf '%s' "$violations"
}

if [ "${1:-}" = "--self-test" ]; then
  fail=0
  v=$(check "Honestly, this is fine ${EM} quietly powerful.")
  case "$v" in *em-or-en-dash*filler-honest-or-quiet*) ;; *) echo "FAIL dirty case: '$v'"; fail=1 ;; esac
  v=$(check "Done. Changed Y because Z. Honest work builds honesty; the quiet hours setting is unchanged.")
  [ -z "$v" ] || { echo "FAIL clean case: '$v'"; fail=1; }
  v=$(check "Co-Authored-By: Claude <noreply@anthropic.com>")
  case "$v" in *ai-attribution*) ;; *) echo "FAIL attribution case: '$v'"; fail=1 ;; esac
  v=$(check "It's done, don't worry: step one, then two.")
  [ -z "$v" ] || { echo "FAIL punctuation case (locale bug?): '$v'"; fail=1; }
  [ "$fail" -eq 0 ] && echo "self-test: all checks pass"
  exit "$fail"
fi

input=$(cat)

if [ "$(printf '%s' "$input" | jq -r '.stop_hook_active // false')" = "true" ]; then
  exit 0
fi

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -f "$tp" ] || exit 0

# All text blocks of the last assistant message, joined, so a violation in
# an earlier block of the same message is not missed.
text=$(jq -rs '[.[] | select(.type=="assistant")] | last | [.message.content[]? | select(.type=="text") | .text] | join("\n")' "$tp" 2>/dev/null)
[ -n "$text" ] || exit 0

violations=$(check "$text")
if [ -n "$violations" ]; then
  jq -n --arg r "Final message violates the working agreement:${violations} Rewrite it without these before stopping. Literal uses inside quoted material are exempt; if that is the case, stop again unchanged." \
    '{decision: "block", reason: $r}'
fi

exit 0
