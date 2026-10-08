#!/usr/bin/env bash

# ======================
# == System Specific ==
# ======================

# Set workspaces in GNOME 
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

for i in {1..10}; do
  k=$((i % 10))
  gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$k']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$k']"
done

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Super><Shift>6', '<Super><Shift>#15']"

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

