#!/usr/bin/env bash

bashrc="$HOME/.bashrc"

touch "$bashrc"

add_block() {
    local comment="$1"
    local line="$2"

    if ! grep -Fxq -- "$line" "$bashrc"; then
        printf '\n# %s\n%s\n' "$comment" "$line" >> "$bashrc"
        echo "Added: $comment"
    fi
}

add_block "Load user exports" \
    '[ -f ~/.bash_exports ] && source ~/.bash_exports'

add_block "Load user functions" \
    '[ -f ~/.bash_functions ] && source ~/.bash_functions'

add_block "Load plugins" \
    '[ -f ~/.bash_plugins ] && source ~/.bash_plugins'

# WSL integration
if grep -qi microsoft /proc/sys/kernel/osrelease 2>/dev/null; then
    add_block "WSL integration" \
        'PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'\''printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'\'''
fi
