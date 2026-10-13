#!/usr/bin/env bash

set -euo pipefail

if [ "$EUID" -ne 0 ]; then
    printf '\033[0;91m%s\033[0m\n' "[Error] Please run this script with sudo."
    exit 1
fi

REAL_USER="${SUDO_USER:-$USER}"
USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
DOTFILES_DIR="${DOTFILES:-$USER_HOME/.dotfiles}"
SRC_DIR="$USER_HOME/src"
LOCAL_BIN_DIR="$USER_HOME/.local/bin"

COL_STATUS=$'\033[0;32m' # green
COL_NOTICE=$'\033[0;94m' # blue
COL_WARNING=$'\033[0;93m' # yellow
COL_ERROR=$'\033[0;91m' # red
COL_BOLD=$'\033[1m'
COL_RESET=$'\033[0m'

# Ubuntu APT Packages
UBUNTU_CORE_PKGS=( git curl stow tar unzip gzip )
UBUNTU_DEV_PKGS=( build-essential npm fd-find ripgrep fonts-jetbrains-mono )
UBUNTU_OPTIONAL_PKGS=(
    ffmpeg
    wmctrl
    wl-clipboard
    gnome-tweaks
    gnome-shell-extension-manager
)
# TEST_TOOLS=( vim )

UBUNTU_PACKAGES=(
    "${UBUNTU_CORE_PKGS[@]}"
    "${UBUNTU_DEV_PKGS[@]}"
    "${UBUNTU_OPTIONAL_PKGS[@]}"
    # "${TEST_TOOLS[@]}"
)


create_dir() {
    sudo -u "$REAL_USER" mkdir -p "$@"
}

create_link() {
    local target="$1"
    local destiny="$2"
    sudo -u "$REAL_USER" ln -sfn "$target" "$destiny"
}

download_file() {
    local url="$1"
    local name="$2"
    sudo -u "$REAL_USER" curl -fsSL --create-dirs -o "$name" "$url"
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
        sudo -u "$REAL_USER" unzip -oq "$archive" -d "$dest"
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
    local color="$2"
    printf '%s%s%s\n' "$color" "$text" "$COL_RESET"
}

status_msg() {
    local message="$1"
    set_text_color "[STATUS] $message" "$COL_STATUS"
}

notice_msg() {
    local message="$1"
    set_text_color "[NOTICE] $message" "$COL_NOTICE"
}

warning_msg() {
    local message="$1"
    set_text_color "[WARNING] $message" "$COL_WARNING"
}

error_msg() {
    local message="$1"
    set_text_color "[ERROR] $message" "$COL_ERROR"
}


# ======================
# == Install Packages ==
# ======================

apt-get update

status_msg "(apt) Installing the following packages: ${UBUNTU_PACKAGES[*]}"

apt-get install -y "${UBUNTU_PACKAGES[@]}"


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
create_dir "$SRC_DIR"
create_dir "$LOCAL_BIN_DIR" "$USER_HOME/.local/share/applications" "$USER_HOME/.local/share/icons"

# ======================
# == Program Specific ==
# ======================

# Vim
error_msg "Vim install instructions are missing!"


{
    # ===== Neovim =====
    status_msg "Downloading Neovim..."

    NVIM_DOWNLOAD_LINK='https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz'
    TREESITTER_DOWNLOAD_LINK='https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-x64.zip'

    create_dir "$SRC_DIR/nvim"
    download_file "$NVIM_DOWNLOAD_LINK" 'nvim-linux-x86_64.tar.gz'  && {
        extract_archive nvim-linux-x86_64.tar.gz "$SRC_DIR/nvim"
        delete_item nvim-linux-x86_64.tar.gz

        # setup and expose to desktop
        create_link "$SRC_DIR/nvim/bin/nvim" "$LOCAL_BIN_DIR/nvim"
        create_link "$SRC_DIR/nvim/share/applications/nvim.desktop" "$USER_HOME/.local/share/applications/"
        create_link "$SRC_DIR/nvim/share/icons/hicolor" "$USER_HOME/.local/share/icons/"
    }

    download_file "$TREESITTER_DOWNLOAD_LINK" 'tree-sitter-cli-linux-x64.zip' && {
        create_dir "$SRC_DIR/tree-sitter-cli/"
        extract_archive tree-sitter-cli-linux-x64.zip "$SRC_DIR/tree-sitter-cli/"
        delete_item tree-sitter-cli-linux-x64.zip
        create_link "$SRC_DIR/tree-sitter-cli/tree-sitter" "$LOCAL_BIN_DIR/tree-sitter"
    }

    if command -v fdfind &> /dev/null; then
        create_link "$(which fdfind)" "$LOCAL_BIN_DIR/fd"
    else
        error_msg 'No binaries for fd-find (fd) were found. You might have to install it manually.'
        error_msg 'After installing fd-find, create a symlink in your $PATH and name it "fd".'
    fi
}

# ==== Command-line Tools ====
# yt-dlp
YTDLP_DOWNLOAD_LINK='https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp'
download_file "$YTDLP_DOWNLOAD_LINK" "$SRC_DIR/yt-dlp"
create_link "$SRC_DIR/yt-dlp" "$LOCAL_BIN_DIR/yt-dlp"
chmod a+x "$LOCAL_BIN_DIR/yt-dlp"

# Remove Windows-specific config files
status_msg "Removing unnecessary files from local repo..."
remove_repo_file_locally "$DOTFILES_DIR/bash/windows-terminal-split-in-cwd.sh"


# =================================
# == Create Symlinks w/ GNU Stow ==
# =================================

STOW_PACKAGES=($(basename -a "$DOTFILES_DIR"/*/))
IGNORED_STOW_PKGS=( installers scripts )
DISPLAY_STOW_PKGS=$(sed -E "s/\b($(IFS='|'; echo "${IGNORED_STOW_PKGS[*]}"))\b//g" <<< "${STOW_PACKAGES[*]}" | tr -s ' ')

status_msg "Running GNU Stow to symlink these packages: $DISPLAY_STOW_PKGS"

stash_result=$(git stash push -m "sync-dotfiles: Before syncing dotfiles")
stash_needs_pop=1
if [ "$stash_result" = "No local changes to save" ]; then
    stash_needs_pop=0
fi

stow -v --dir="$DOTFILES_DIR" --target="$USER_HOME" --adopt -R "${STOW_PACKAGES[@]}"

STOW_MODIFIED_FILES=$(git status --porcelain | grep '^ M' | cut -c4-)

if [[ -n $STOW_MODIFIED_FILES ]]; then
    warning_msg "Stow adopted existing local files for some of your packages because conflicting files were found in the target directory:"
    awk -v notice="$COL_WARNING" -v reset="$COL_RESET" 'NF > 0 {print "  " notice "- " $0 reset}' <<< "$STOW_MODIFIED_FILES"
    cat <<-EOF
		${COL_WARNING}Your repository files were overwritten with their local version.
		  • To review changes: git diff
		  • To discard local changes: git checkout -- <file>
		  • To keep them: git add <file> && git commit -m <commit-message>${COL_RESET}
	EOF
fi

if [[ $stash_needs_pop -eq 1 ]]; then
    git stash pop --quiet
fi

