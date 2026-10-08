#!/usr/bin/env bash

# ======================
# == System Specific ==
# ======================

# Create necessary directories
mkdir -p ~/src
mkdir -p ~/.local/bin ~/.local/share/applications ~/.local/share/icons

# ======================
# == Program Specific ==
# ======================

# Bash
ln -s "$HOME/.dotfiles/bash/.bashrc" "$HOME/"

# Vim
ln -s "$HOME/.dotfiles/vim/.vimrc" "$HOME/"

# Neovim
mkdir -p "$HOME/.config/nvim/" && ln -s "$HOME/.dotfiles/nvim/*" "$HOME/.config/nvim/"
ln -s "$HOME/.dotfiles/.stylua.toml" "$HOME/"

# Remove Windows-specific config files
git update-index --skip-worktree "$DOTFILES/bash/windows-terminal-split-in-cwd.sh" && rm "$DOTFILES/bash/windows-terminal-split-in-cwd.sh"

