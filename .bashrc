# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

source ~/.local/share/omarchy/default/bash/rc

# fnm
FNM_PATH="/home/moorhouse/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
export PATH="$HOME/flutter/bin:$PATH"

# pnpm
export PNPM_HOME="/home/moorhouse/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Ahrefs API
export AHREFS_API_KEY="bv-g8GBAppKAI46yG-skn5KeKZjeU5b0WMSdS45p"
