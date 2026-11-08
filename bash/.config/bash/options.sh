#!/usr/bin/env bash

# Default fallbacks (can be overridden by `~/.bashrc.local`)
export EDITOR=vim
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export SUDO_EDITOR="$EDITOR"
export DOTFILES="$HOME/.dotfiles"
export OBSIDIAN_VAULT="$HOME/obsidian"

# Ensure binaries in ~/.local/bin are in the PATH and prioritized
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Add directories to $PATH
ADD_TO_PATH=(
    "$HOME/.spicetify"
)

for p in "${ADD_TO_PATH[@]}"; do
    [[ ":$PATH:" != *":$p:"* ]] && export PATH="$PATH:$p"
done
