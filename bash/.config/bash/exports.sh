#!/usr/bin/env bash

# Default fallbacks (will be overridden by `~/.bashrc.local`)
export EDITOR=vim
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export SUDO_EDITOR="$EDITOR"

export DOTFILES="$HOME/.dotfiles"
export OBSIDIAN_VAULT="$HOME/obsidian"


ADD_TO_PATH=(
    "$HOME/.local/bin"
    "$HOME/.spicetify"
)

for p in "${ADD_TO_PATH[@]}"; do
    [[ ":$PATH:" != *":$p:"* ]] && export PATH="$PATH:$p"
done
