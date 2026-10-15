#!/usr/bin/env bash

set -euo pipefail

if ((EUID == 0)); then
    printf '\033[0;91m%s\033[0m\n' '[ERROR] Run this script as your regular user, without sudo.' >&2
    exit 1
fi

if [[ -z "${DOTFILES:-}" ]]; then
    printf '\033[0;91m%s\033[0m\n' '[ERROR] Environment variable $DOTFILES must be set to run this script.' >&2
    exit 1
fi

# Request authentication upfront and cache sudo credentials
sudo -v

DOTFILES_DIR="$DOTFILES"
SRC_DIR="$HOME/src"
LOCAL_BIN_DIR="$HOME/.local/bin"

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
    ttf-mscorefonts-installer
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
    mkdir -p "$@"
}

create_link() {
    local target="$1"
    local destiny="$2"
    ln -sfn "$target" "$destiny"
}

delete_item() {
    rm -rf "$@" 
}

extract_archive() {
    local archive="$1"
    local dest="$2"

    case "$archive" in
      *.tar.gz|*.tgz)
        tar xzf "$archive" -C "$dest" --strip-components=1
        ;;
      *.zip)
        unzip -oq "$archive" -d "$dest"
        ;;
#     *.gz)
#       gzip -dc "$archive" > "$dest/${archive%.gz}"
#       ;;
      *)
        error_log "Unsupported archive format: $archive" >&2
        return 1
        ;;
    esac
}

download_file() {
    local url="$1"
    local name="$2"
    local dest="$3"

    create_dir "$dest"

    case "$name" in
        *.tar.gz|*.tgz|*.gz|*.zip)
            curl -fsSL -o "$name" "$url"
            extract_archive "$name" "$dest"
            delete_item "$name" 
            ;;
        *)
            curl -fsSL --create-dirs -o "$dest/$name" "$url"
            ;;
    esac
}

remove_repo_files_locally() {
    [[ $# -eq 0 ]] && return

    status_log "Removing unnecessary files from local repo..."

    for file in "$@"; do
        if [[ -f "$file" ]]; then
            git update-index --skip-worktree "$file" && delete_item "$file"
        fi
    done
}

set_text_color() {
    local text="$1"
    local color="$2"
    printf '%s%s%s\n' "$color" "$text" "$COL_RESET"
}

status_log() {
    local message="$1"
    set_text_color "[STATUS] $message" "$COL_STATUS"
}

notice_log() {
    local message="$1"
    set_text_color "[NOTICE] $message" "$COL_NOTICE"
}

warning_log() {
    local message="$1"
    set_text_color "[WARNING] $message" "$COL_WARNING" >&2
}

error_log() {
    local message="$1"
    set_text_color "[ERROR] $message" "$COL_ERROR" >&2
}

debub_log() {
    local message="$1"
    printf '\n%s%s%s\n\n' "$COL_ERROR" "⛔ [DEBUG] ⛔ $message" "$COL_RESET"
}


# ======================
# == Install Packages ==
# ======================

sudo apt-get update

status_log "(apt) Installing the following packages: ${UBUNTU_PACKAGES[*]}"

sudo apt-get install -y "${UBUNTU_PACKAGES[@]}"


# ======================
# == System Specific ==
# ======================

# GNOME
if [[ -n "${XDG_CURRENT_DESKTOP-}" ]] && [[ "${XDG_CURRENT_DESKTOP,,}" == *gnome* ]]; then
    status_log "Customizing the GNOME Desktop"

    # Workspaces
    gsettings set org.gnome.mutter dynamic-workspaces false
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

    for i in {1..10}; do
        k=$((i % 10))
        gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
        gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$k']"
        gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$k']"
    done

    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Super><Shift>6', '<Super><Shift>#15']"
else
    notice_log 'Desktop Environment is not GNOME. Skipping GNOME customization.'
fi


# Locally remove files in dotfiles repo (e.g. windows-specific files)
remove_locally=()

remove_repo_files_locally "${remove_locally[@]}"


# Create necessary directories
create_dir "$SRC_DIR"
create_dir "$LOCAL_BIN_DIR" "$HOME/.local/share/applications" "$HOME/.local/share/icons"


# ======================
# == Program Specific ==
# ======================

# Vim
# TODO:
# - create the '.vim/spell' directory with mkdir -p ~/.vim/spell otherwise the
# spellfiles form Vim will be saved in '.vim/plugged/catppuccin/spell' which is
# weird; then it should open a .md file and run ':set spelllang=en,pt,es,fr' to
# download the spellfiles
# - Open Vim with the +PlugInstallargument (should also ignore any errors and then close it)

error_log "Vim install instructions are missing!"


{
    # ===== Neovim =====
    if ! command -v 'nvim' &> /dev/null; then
        status_log "Installing Neovim..."
        NVIM_DOWNLOAD_LINK='https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz'
        download_file "$NVIM_DOWNLOAD_LINK" 'nvim-linux-x86_64.tar.gz' "$SRC_DIR/nvim" && {
            # setup and expose to desktop
            create_link "$SRC_DIR/nvim/bin/nvim" "$LOCAL_BIN_DIR/nvim"
            create_link "$SRC_DIR/nvim/share/applications/nvim.desktop" "$HOME/.local/share/applications/"
            create_link "$SRC_DIR/nvim/share/icons/hicolor" "$HOME/.local/share/icons/"
        }
    else
        notice_log 'neovim already installed, skipping its installation.'
    fi

    if ! command -v 'tree-sitter' &> /dev/null; then
        status_log "Installing Neovim dependency: tree-sitter"
        TREESITTER_DOWNLOAD_LINK='https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-x64.zip'
        download_file "$TREESITTER_DOWNLOAD_LINK" 'tree-sitter-cli-linux-x64.zip' "$SRC_DIR/tree-sitter-cli/" &&
        create_link "$SRC_DIR/tree-sitter-cli/tree-sitter" "$LOCAL_BIN_DIR/tree-sitter"
    else
        notice_log 'tre-sitter already installed, skipping its installation.'
    fi

    if command -v 'fdfind' &> /dev/null; then
        ! command -v 'fd' &> /dev/null && create_link "$(which fdfind)" "$LOCAL_BIN_DIR/fd"
    else
        error_log 'No binaries for fd-find (fd) were found. You might have to install it manually.'
        error_log 'After installing fd-find, create a symlink in your $PATH and name it "fd".'
    fi
}

# ==== Command-line Tools ====
# yt-dlp
if ! command -v 'yt-dlp' &> /dev/null; then
    status_log "Installing yt-dlp..."
    YTDLP_DOWNLOAD_LINK='https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp'
    download_file "$YTDLP_DOWNLOAD_LINK" "yt-dlp" "$SRC_DIR/yt-dlp"
    create_link "$SRC_DIR/yt-dlp/yt-dlp" "$LOCAL_BIN_DIR/yt-dlp"
    chmod a+x "$LOCAL_BIN_DIR/yt-dlp"
else
    notice_log 'yt-dlp already installed, skipping its installation.'
fi


# =================================
# == Create Symlinks w/ GNU Stow ==
# =================================

STOW_PACKAGES=($(basename -a "$DOTFILES_DIR"/*/))
IGNORED_STOW_PKGS=( installers scripts )
DISPLAY_STOW_PKGS=$(sed -E "s/\b($(IFS='|'; echo "${IGNORED_STOW_PKGS[*]}"))\b//g" <<< "${STOW_PACKAGES[*]}" | tr -s ' ')

status_log "Running GNU Stow to symlink these packages: $DISPLAY_STOW_PKGS"

stash_result=$(git stash push -m "sync-dotfiles: Before syncing dotfiles")
stash_needs_pop=1
if [ "$stash_result" = "No local changes to save" ]; then
    stash_needs_pop=0
fi

stow -v --dir="$DOTFILES_DIR" --target="$HOME" --adopt -R "${STOW_PACKAGES[@]}"

STOW_MODIFIED_FILES=$(git status --porcelain | grep '^ M' | cut -c4- || :)

if [[ -n $STOW_MODIFIED_FILES ]]; then
    warning_log "Stow adopted existing local files for some of your packages because conflicting files were found in the target directory:"
    awk -v notice="$COL_WARNING" -v reset="$COL_RESET" 'NF > 0 {print "  " notice "- " $0 reset}' <<< "$STOW_MODIFIED_FILES"
    cat <<-EOF
		${COL_WARNING}Your repository files were overwritten with their local version.
		  • To review changes: git diff
		  • To discard local changes: git checkout -- <file>
		  • To keep them: git add <file> && git commit -m <commit-message>${COL_RESET}
	EOF
fi

[[ "$stash_needs_pop" -eq 1 ]] && git stash pop --quiet


# =================================
# ==== Post Installation Guide ====
# =================================

# TODO:
# - warn about all binaries that are missing in the machine;
# - it shoul warn about what environment variables should be declared in bash (e.g. $EDITOR, $OBSIDIAN_VAULT)
# - create ~/.gitconfig.local and add username and email
# - setup git with ssh

