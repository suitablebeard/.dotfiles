#!/bin/bash

# Default fallbacks (will be overridden by `~/.bashrc.local`)
export EDITOR=vim
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export SUDO_EDITOR="$EDITOR"

export DOTFILES="$HOME/.dotfiles"
export OBSIDIAN_VAULT="$HOME/obsidian"


if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
