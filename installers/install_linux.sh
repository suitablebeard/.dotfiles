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
ln -sfn ~/.dotfiles/bash/.bashrc ~/

# Vim
ln -sfn ~/.dotfiles/vim/.vimrc ~/

# Neovim
mkdir -p ~/src/nvim ~/.config/nvim/
curl -fsSL -O https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && {
  tar xzvf nvim-linux-x86_64.tar.gz -C ~/src/nvim --strip-components=1
  ln -sfn ~/src/nvim/bin/nvim ~/.local/bin/nvim
  ln -sfn ~/src/nvim/share/applications/nvim.desktop ~/.local/share/applications/
  ln -sfn ~/src/nvim/share/icons/hicolor ~/.local/share/icons/
  rm -rf ~/.config/nvim && ln -sfn ~/.dotfiles/nvim ~/.config/nvim
  ln -sfn ~/.dotfiles/.stylua.toml ~/
  rm nvim-linux-x86_64.tar.gz
}

# Remove Windows-specific config files
git update-index --skip-worktree "$DOTFILES/bash/windows-terminal-split-in-cwd.sh" && rm "$DOTFILES/bash/windows-terminal-split-in-cwd.sh"

