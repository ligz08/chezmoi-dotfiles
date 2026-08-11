# No terminfo entry here carries the RGB capability and neither Windows Terminal
# nor WSL exports COLORTERM, so TUIs (helix, bat, delta, ...) fall back to 16 colors.
set -gx COLORTERM truecolor
