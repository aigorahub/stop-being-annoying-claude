#!/bin/bash
# Stop hook: scans Claude's final message for mechanical writing violations
# and blocks with a reason so Claude rewrites before the turn ends.
# Guards against loops: lets the second attempt through even if still dirty.

input=$(cat)

if [ "$(printf '%s' "$input" | jq -r '.stop_hook_active // false')" = "true" ]; then
  exit 0
fi

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -f "$tp" ] || exit 0

text=$(jq -rs '[.[] | select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text] | last // ""' "$tp" 2>/dev/null)
[ -n "$text" ] || exit 0

violations=""
printf '%s' "$text" | grep -q '[—–]' && violations="$violations em-or-en-dash;"
printf '%s' "$text" | grep -qiE '(^|[^a-zA-Z])(honestly|to be honest|quietly)([^a-zA-Z]|$)' \
  && violations="$violations filler-honest-or-quiet;"
printf '%s' "$text" | grep -qiE 'co-authored-by:|generated with claude|🤖' \
  && violations="$violations ai-attribution;"

if [ -n "$violations" ]; then
  jq -n --arg r "Final message violates the working agreement:${violations} Rewrite it without these before stopping. Literal uses inside quoted material are exempt; if that is the case, stop again unchanged." \
    '{decision: "block", reason: $r}'
fi

exit 0
