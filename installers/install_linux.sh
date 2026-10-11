#!/usr/bin/env bash

set -euo pipefail

REAL_USER="${SUDO_USER:-$USER}"
USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
DOTFILES_DIR="$USER_HOME/.dotfiles"

COL_YELLOW=$'\033[0;93m'
COL_BOLD=$'\033[1m'
COL_RESET=$'\033[0m'


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
        sudo -u "$REAL_USER" tar xzf "$archive" -C "$dest" --strip-components=1
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

set_text_color() {
    local text="$1"
    local color="${2:-$COL_YELLOW}"
    printf '%s%s%s' "$color" "$text" "$COL_RESET"
}


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



# Vim
echo -e $(set_text_color '[NOTICE] Vim install instructions are missing!')


{
    # ===== Neovim =====

    NVIM_DOWNLOAD_LINK='https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz'
    TREESITTER_DOWNLOAD_LINK='https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-x64.zip'

    create_dir "$USER_HOME/src/nvim"
    download_file "$NVIM_DOWNLOAD_LINK" && {
        extract_archive nvim-linux-x86_64.tar.gz "$USER_HOME/src/nvim"
        delete_item nvim-linux-x86_64.tar.gz

        # setup and expose to desktop
        create_link "$USER_HOME/src/nvim/bin/nvim" "$USER_HOME/.local/bin/nvim"
        create_link "$USER_HOME/src/nvim/share/applications/nvim.desktop" "$USER_HOME/.local/share/applications/"
        create_link "$USER_HOME/src/nvim/share/icons/hicolor" "$USER_HOME/.local/share/icons/"
    }

    download_file "$TREESITTER_DOWNLOAD_LINK" && {
        create_dir "$USER_HOME/src/tree-sitter-cli/"
        extract_archive tree-sitter-cli-linux-x64.zip "$USER_HOME/src/tree-sitter-cli/"
        delete_item tree-sitter-cli-linux-x64.zip
        create_link "$USER_HOME/src/tree-sitter-cli/tree-sitter" "$USER_HOME/.local/bin/tree-sitter"
    }

    if command -v fdfind &> /dev/null; then
        create_link "$(which fdfind)" "$USER_HOME/.local/bin/fd"
    else
        echo -e "\n\033[1;33m[NOTICE] Stow adopted existing local files for '$PACKAGE':\033[0m"
    fi
}

# Remove Windows-specific config files
remove_repo_file_locally "$DOTFILES_DIR/bash/windows-terminal-split-in-cwd.sh"


# =================================
# == Create Symlinks w/ GNU Stow ==
# =================================

STOW_PACKAGES=($(basename -a "$DOTFILES_DIR"/*/))
stow --dir="$DOTFILES_DIR" --target="$USER_HOME" --adopt -R "${STOW_PACKAGES[@]}"

STOW_MODIFIED_FILES=$(git status --porcelain | grep '^ M' | cut -c4-)

if [[ -n $STOW_MODIFIED_FILES ]]; then
   cat <<EOF
${COL_YELLOW}[NOTICE] Stow might have adopted existing local files for some of your packages:${COL_RESET}
$(echo "$STOW_MODIFIED_FILES" | sed "s/^/  ${COL_YELLOW}- /;s/$/${COL_RESET}/")

Your repository files might have been overwritten with their local version.
  • To review changes: ${COL_BOLD}git diff${COL_RESET}
  • To discard local changes: ${COL_BOLD}git checkout -- <file>${COL_RESET}
  • To keep them: ${COL_BOLD}git add <file> && git commit -m 'Adopt local changes'${COL_RESET}
EOF
else
    echo -e "\n\033[1;32m[SUCCESS] Stow completed with no conflicts or adoptions.\033[0m"
fi

