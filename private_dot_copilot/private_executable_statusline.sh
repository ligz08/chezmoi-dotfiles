#!/usr/bin/env bash
# Copilot CLI status line matching ~/.claude/hooks/statusline.sh.

# Colors
CYAN='\033[36m'
YELLOW='\033[38;2;223;142;29m'   # Catppuccin Latte Yellow #df8e1d
ORANGE='\033[38;2;224;122;58m'
MAUVE='\033[38;2;170;140;190m'    # Gentle purple #aa8cbe
RESET='\033[0m'

input=$(cat)

jq_first() {
    local expr="$1"
    if [ -z "$input" ]; then
        return 0
    fi
    jq -r "$expr" <<<"$input" 2>/dev/null
}

to_int() {
    local value="${1:-0}"
    value="${value%%.*}"
    case "$value" in
        ''|*[!0-9]*) echo 0 ;;
        *) echo "$value" ;;
    esac
}

MODEL=$(jq_first '[.model.id?, .model?, .modelId?, .currentModel.id?, .session.model?] | map(select(type == "string" and length > 0))[0] // empty')
[ -z "$MODEL" ] && MODEL=$(jq -r '.model // "?"' ~/.copilot/settings.json 2>/dev/null)
[ -z "$MODEL" ] && MODEL="?"

SESSION_ID=$(jq_first '[.session_id?, .sessionId?, .session.id?, .id?] | map(select(type == "string" and length > 0))[0] // empty')

RAW_DIR=$(jq_first '[.workspace.current_dir?, .workspace.currentDir?, .workspace.cwd?, .cwd?, .current_dir?, .directory?] | map(select(type == "string" and length > 0))[0] // empty')
[ -z "$RAW_DIR" ] && RAW_DIR="$PWD"
DIR="${RAW_DIR//\\//}"

PCT=$(to_int "$(jq_first '[.context_window.current_context_used_percentage?, .context_window.used_percentage?, .contextWindow.usedPercentage?] | map(select(type == "number" or type == "string"))[0] // 0')")
USED_TOKENS=$(to_int "$(jq_first '[.context_window.current_context_tokens?, .contextWindow.currentContextTokens?] | map(select(type == "number" or type == "string"))[0] // 0')")
MAX_TOKENS=$(to_int "$(jq_first '[.context_window.displayed_context_limit?, .context_window.context_window_size?, .contextWindow.contextWindowSize?, .contextWindow.maxTokens?] | map(select(type == "number" or type == "string"))[0] // 0')")

if [ "$PCT" -eq 0 ] && [ "$MAX_TOKENS" -gt 0 ]; then
    PCT=$(( USED_TOKENS * 100 / MAX_TOKENS ))
fi
[ "$PCT" -gt 100 ] && PCT=100

USED_K=$(( USED_TOKENS / 1000 ))
MAX_K=$(( MAX_TOKENS / 1000 ))

# Shorten home directory to ~.
HOME_WIN="${USERPROFILE:-$HOME}"
HOME_WIN="${HOME_WIN//\\//}"
DIR="${DIR/#$HOME_WIN/\~}"
DIR="${DIR/#$HOME/\~}"

# Git branch. Prefer the reported workspace dir if it is a local path.
BRANCH=""
GIT_DIR="${RAW_DIR//\\//}"
if [ -d "$GIT_DIR" ] && git -C "$GIT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
    BRANCH=$(git -C "$GIT_DIR" branch --show-current 2>/dev/null)
elif git rev-parse --git-dir >/dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
fi

# Context usage colour — Catppuccin Frappé palette
TEAL='\033[38;2;129;200;190m'
PEACH='\033[38;2;239;159;118m'
MAROON='\033[38;2;234;153;156m'
if [ "$PCT" -ge 90 ]; then CTX_COLOR="$MAROON"
elif [ "$PCT" -ge 70 ]; then CTX_COLOR="$PEACH"
else CTX_COLOR="$TEAL"; fi

# Pie-chart icon: 8 glyphs stepping every ~14 %.
PIE_ICONS=('󰪞' '󰪟' '󰪠' '󰪡' '󰪢' '󰪣' '󰪤' '󰪥')
PIE_IDX=$(( PCT * 7 / 100 ))
[ "$PIE_IDX" -gt 7 ] && PIE_IDX=7
PIE_ICON="${PIE_ICONS[$PIE_IDX]}"

LINE="${ORANGE}${MODEL}${RESET}"
LINE="${LINE} in ${CYAN}${DIR}${RESET}"
if [ -n "$BRANCH" ]; then
    LINE="${LINE} on ${YELLOW}󰊢 ${BRANCH}${RESET}"
fi
[ -n "$SESSION_ID" ] && LINE="${LINE} amid ${MAUVE}${SESSION_ID}${RESET}"
LINE="${LINE} using ${CTX_COLOR}${PIE_ICON} ${PCT}% (${USED_K}k/${MAX_K}k)${RESET} context"

printf '%b\n' "$LINE"
