#!/usr/bin/env bash

USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)

if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo."
  exit 1
fi

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
mkdir -p "$USER_HOME/src"
mkdir -p "$USER_HOME/.local/bin" "$USER_HOME/.local/share/applications" "$USER_HOME/.local/share/icons"

# ======================
# == Program Specific ==
# ======================

# Bash
ln -sfn "$USER_HOME/.dotfiles/bash/.bashrc" "$USER_HOME/"

# Vim
ln -sfn "$USER_HOME/.dotfiles/vim/.vimrc" "$USER_HOME/"

# Neovim
mkdir -p "$USER_HOME/src/nvim" "$USER_HOME/.config/nvim/"
curl -fsSL -O https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && {
  tar xzvf nvim-linux-x86_64.tar.gz -C "$USER_HOME/src/nvim" --strip-components=1
  ln -sfn "$USER_HOME/src/nvim/bin/nvim" "$USER_HOME/.local/bin/nvim"
  ln -sfn "$USER_HOME/src/nvim/share/applications/nvim.desktop" "$USER_HOME/.local/share/applications/"
  ln -sfn "$USER_HOME/src/nvim/share/icons/hicolor" "$USER_HOME/.local/share/icons/"
  rm -rf "$USER_HOME/.config/nvim" && ln -sfn "$USER_HOME/.dotfiles/nvim" "$USER_HOME/.config/nvim"
  ln -sfn "$USER_HOME/.dotfiles/.stylua.toml" "$USER_HOME/"
  rm nvim-linux-x86_64.tar.gz
}

# Remove Windows-specific config files
git update-index --skip-worktree "$USER_HOME/.dotfiles/bash/windows-terminal-split-in-cwd.sh" &&
  rm "$USER_HOME/.dotfiles/bash/windows-terminal-split-in-cwd.sh"

