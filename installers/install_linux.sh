#!/usr/bin/env bash

set -euo pipefail

REAL_USER="${SUDO_USER:-$USER}"
USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
DOTFILES_DIR="$USER_HOME/.dotfiles"

if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo."
  exit 1
fi

create_dir() {
    sudo -u "$REAL_USER" mkdir -p "$@"
}

create_link() {
    local target="$1"
    local destiny="$2"
    sudo -u "$REAL_USER" ln -sfn "$target" "$destiny"
}

download_file() {
    local file_url="$1"
    sudo -u "$REAL_USER" curl -fsSL -O "$file_url"
}

delete_item() {
    sudo -u "$REAL_USER" rm -rf "$@" 
}

extract_archive() {
    local archive="$1"
    local dest="$2"

    case "$archive" in
      *.tar.gz|*.tgz)
        sudo -u "$REAL_USER" tar xzvf "$archive" -C "$dest" --strip-components=1
        ;;
      *.zip)
        sudo -u "$REAL_USER" unzip "$archive" -d "$dest"
        ;;
#     *.gz)
#       sudo -u "$REAL_USER" gzip -dc "$archive" > "$dest/${archive%.gz}"
#       ;;
      *)
        echo "Unsupported archive format: $archive" >&2
        return 1
        ;;
    esac
}

remove_repo_file_locally() {
    local file="$1"
    git update-index --skip-worktree "$file" && delete_item "$file"
}

apt-get update

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
create_dir "$USER_HOME/src"
create_dir "$USER_HOME/.local/bin" "$USER_HOME/.local/share/applications" "$USER_HOME/.local/share/icons"

# ======================
# == Program Specific ==
# ======================

# Bash
create_link "$DOTFILES_DIR/bash/.bashrc" "$USER_HOME/"

# Git
create_link "$DOTFILES_DIR/.gitconfig" "$USER_HOME/"

# Vim
create_link "$DOTFILES_DIR/vim/.vimrc" "$USER_HOME/"

# Neovim
{
    create_dir "$USER_HOME/src/nvim" "$USER_HOME/.config/nvim/"
    download_file https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && {
        extract_archive nvim-linux-x86_64.tar.gz "$USER_HOME/src/nvim"
        create_link "$USER_HOME/src/nvim/bin/nvim" "$USER_HOME/.local/bin/nvim"
        create_link "$USER_HOME/src/nvim/share/applications/nvim.desktop" "$USER_HOME/.local/share/applications/"
        create_link "$USER_HOME/src/nvim/share/icons/hicolor" "$USER_HOME/.local/share/icons/"
        delete_item "$USER_HOME/.config/nvim" && create_link "$DOTFILES_DIR/nvim" "$USER_HOME/.config/nvim"
        create_link "$DOTFILES_DIR/.stylua.toml" "$USER_HOME/"
        delete_item nvim-linux-x86_64.tar.gz
    } && {
        # install neovim plugin dependencies
        apt-get install -y fd-find ripgrep
        download_file https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-x64.zip && {
            create_dir "$USER_HOME/src/tree-sitter-cli/"
            extract_archive tree-sitter-cli-linux-x64.zip "$USER_HOME/src/tree-sitter-cli/"
            delete_item tree-sitter-cli-linux-x64.zip
        }

        create_link $(which fdfind) "$USER_HOME/.local/bin/fd"
        create_link "$USER_HOME/src/tree-sitter-cli/tree-sitter" "$USER_HOME/.local/bin/tree-sitter"
    }
}

# Remove Windows-specific config files
remove_repo_file_locally "$DOTFILES_DIR/bash/windows-terminal-split-in-cwd.sh"

