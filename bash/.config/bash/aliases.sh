#!/usr/bin/env bash

# =====================
# ====  Utilities  ====
# =====================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias files='explorer'

alias ls='ls --color=auto'
alias ll='ls --color=auto -lah'
alias cls='clear'
alias grep='grep --color=auto'
alias so='source ~/.bashrc'

alias dot='cd $DOTFILES'
alias cdcode='cd ~/myFiles/Programming'

# fix blank page when opening Electron apps
alias fixfonts='rm -rf ~/.cache/fontconfig ~/.var/app/*/cache/fontconfig && fc-cache -r -v'

# ======================
# ==== VIM Aliases ====
# ======================

alias v.='$EDITOR .'
alias v='$EDITOR'
alias vi='$EDITOR'
alias nv='nvim'
alias nivm='nvim'

0g() {
    "$EDITOR" -c "autocmd VimEnter * call feedkeys(g:mapleader . \"0g\")"
}

vimplug() {
    local target="${@:-.}"
    vim "$target" +PlugClean +wqa && \
    vim +PlugInstall +wqa && \
    vim "$target"
}

# ========================
# ==== OBSIDIAN VAULT ====
# ========================

# Use single quotes so $OBSIDIAN_VAULT is evaluated when run,
# not when the terminal starts (avoids order-of-sourcing bugs).
alias coo='cd $OBSIDIAN_VAULT'
alias oo='cd $OBSIDIAN_VAULT && $EDITOR .'
alias foo='cd $OBSIDIAN_VAULT && $EDITOR -c "autocmd VimEnter * call feedkeys(g:mapleader . \"of\")"'
alias ooi='cd $OBSIDIAN_VAULT && cd ./\+ && $EDITOR .'

# =====================
# ==== Git Aliases ====
# =====================

alias gcl='git clone'
alias ga='git add'
alias gap='git add -p'
alias gp='git push && git push --tags'
alias gt='git status -s'
alias gtt='git status'
alias ggt='gtt'
alias gl='git log --color=always --graph --pretty=format:"%C(auto)%h %C(reset)%s %C(auto)%d" --date=short | less -R'
alias gla='git log --color=always --graph --pretty=format:"%C(auto)%h %C(reset)%s %C(auto)%d" --date=short --all | less -R'
alias gll='git log --color=always --graph --pretty=format:"%C(auto)%h %C(blue)%ad %C(reset)%s %C(brightblack)(%an)%C(auto)%d" --date=short | less -R'
alias gck='git checkout'
alias gw='git switch'
alias gzz='git stash'
alias gza='git stash apply'
alias gzp='git stash pop'
alias gf='git diff'
alias gfs='git diff --staged'
alias gres='git restore --stage'
alias grr='git rebase --continue'
alias gra='git rebase --abort'

gc() {
    if [ -z "$*" ]; then
        echo "Usage: gc \"commit message\""
        return 1
    fi
    git commit -m "$*"
}
gac() {
    if [ -z "$*" ]; then
        echo "Usage: gac \"commit message\""
        return 1
    fi
    git add . && git commit -m "$*"
}

# ====================================
# ===== yt-dlp aliases (youtube) ===== 
# ====================================

# Update yt-dlp directly
alias ytu="sudo yt-dlp -U"

# Download best available quality (merged into MP4)
alias ytb="yt-dlp -f 'bv*+ba/b' --merge-output-format mp4 -P $HOME/Downloads/"

# Force max 1080p quality (saves bandwidth and storage, outputs MP4)
alias ytb1080="yt-dlp -f 'bv*[height<=1080]+ba/b' --merge-output-format mp4 -P $HOME/Downloads/"

# Extract best audio and convert to MP3
alias ytmp3="yt-dlp -x --audio-format mp3 --audio-quality 0 -P $HOME/Downloads/"

# Download entire playlist with numbered filenames (01 - Title.mp4)
alias ytpl="yt-dlp -o '%(playlist_index)02d - %(title)s.%(ext)s' -f 'bv*+ba/b' --merge-output-format mp4 -P $HOME/Downloads/"
