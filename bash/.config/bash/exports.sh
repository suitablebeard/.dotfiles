#!/usr/bin/env bash

# Default fallbacks (will be overridden by `~/.bashrc.local`)
export EDITOR=vim
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export SUDO_EDITOR="$EDITOR"

export DOTFILES="$HOME/.dotfiles"
export OBSIDIAN_VAULT="$HOME/obsidian"


ADD_TO_PATH=(
    "$HOME/.spicetify"
)

# Ensure binaries in ~/.local/bin are prioritized
# if it's not already in the $PATH
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"

# Add other directories to $PATH
for p in "${ADD_TO_PATH[@]}"; do
    [[ ":$PATH:" != *":$p:"* ]] && export PATH="$PATH:$p"
done
