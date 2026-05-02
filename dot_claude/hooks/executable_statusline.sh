#!/usr/bin/env bash
# Claude Code status line
# Docs: https://code.claude.com/docs/en/statusline
# Format: <model>@<effort>(orange) in <dir>(cyan) on 󰊢 <branch>(yellow) amid <id>(mauve) using <pie> <pct>% context

# Colors
GREEN='\033[32m'
CYAN='\033[36m'
YELLOW='\033[38;2;223;142;29m'   # Catppuccin Latte Yellow #df8e1d
RED='\033[31m'
ORANGE='\033[38;2;224;122;58m'
MAUVE='\033[38;2;170;140;190m'      # Gentle purple #aa8cbe
RESET='\033[0m'

# Read JSON session data from stdin
input=$(cat)

# Extract fields via jq
MODEL=$(echo "$input" | jq -r '.model.id // "?"')
SESSION_ID=$(echo "$input" | jq -r '.session_id // empty')
EFFORT=$(echo "$input" | jq -r '.effort.level // empty')
[ -z "$EFFORT" ] && EFFORT=$(jq -r '.effortLevel // empty' ~/.claude/settings.json 2>/dev/null)
DIR=$(echo "$input" | jq -r '.workspace.current_dir // empty')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# Convert Windows backslashes to forward slashes so printf %b doesn't
# interpret sequences like \b (backspace), \a, \t, etc. in the path.
# Also avoids backslash-as-escape issues in the prefix substitution below.
DIR="${DIR//'\'//}"
# Shorten home directory to ~. DIR arrives as a Windows path (C:\Users\...)
# while $HOME under Git Bash is /c/Users/... — derive a forward-slash home
# from USERPROFILE so the prefix matches.
HOME_WIN="${USERPROFILE:-$HOME}"
HOME_WIN="${HOME_WIN//'\'//}"
DIR="${DIR/#$HOME_WIN/\~}"
DIR="${DIR/#$HOME/\~}"

# Git branch
BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
fi

# Context usage colour — Catppuccin Frappé palette
# Teal #81C8BE -> Peach #EF9F76 -> Maroon #EA999C
TEAL='\033[38;2;129;200;190m'
PEACH='\033[38;2;239;159;118m'
MAROON='\033[38;2;234;153;156m'
if [ "$PCT" -ge 90 ]; then CTX_COLOR="$MAROON"
elif [ "$PCT" -ge 70 ]; then CTX_COLOR="$PEACH"
else CTX_COLOR="$TEAL"; fi

# Pie-chart icon: 8 glyphs stepping every ~14 % (Nerd Fonts md-chart_pie series U+F0A9E–U+F0AA5)
# 󰪞 󰪟 󰪠 󰪡 󰪢 󰪣 󰪤 󰪥
PIE_ICONS=('󰪞' '󰪟' '󰪠' '󰪡' '󰪢' '󰪣' '󰪤' '󰪥')
PIE_IDX=$(( PCT * 7 / 100 ))          # maps 0–100 → 0–7
[ "$PIE_IDX" -gt 7 ] && PIE_IDX=7
PIE_ICON="${PIE_ICONS[$PIE_IDX]}"

# Assemble: <model>@effort(orange) in <dir>(cyan) on 󰊢 <branch>(yellow) amid <id> using <pie> <pct>% context
LINE="${ORANGE}${MODEL}"
[ -n "$EFFORT" ] && LINE="${LINE}@${EFFORT}"
LINE="${LINE}${RESET}"
LINE="${LINE} in ${CYAN}${DIR}${RESET}"
if [ -n "$BRANCH" ]; then
    LINE="${LINE} on ${YELLOW}󰊢 ${BRANCH}${RESET}"
fi
[ -n "$SESSION_ID" ] && LINE="${LINE} amid ${MAUVE}${SESSION_ID}${RESET}"
LINE="${LINE} using ${CTX_COLOR}${PIE_ICON} ${PCT}%${RESET} context"

printf '%b\n' "$LINE"
