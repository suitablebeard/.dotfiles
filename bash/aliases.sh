#!/bin/bash

# =====================
# ====  Utilities  ====
# =====================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias files='explorer'

alias ls='ls --color=auto'
alias ll='ls --color=auto -la'
alias cls='clear'
alias grep='grep --color=auto'
alias so='source ~/.bashrc'

alias dot='cd ~/.dotfiles && $EDITOR .'
alias cdcode='cd ~/myFiles/Programming'

alias battery='sudo ~/.dotfiles/bash/scripts/battery-health-charging.sh'

# ======================
# ==== VIM Aliases ====
# ======================

alias v.='$EDITOR .'
alias v='$EDITOR'
alias vi='$EDITOR'
alias nv='nvim'

vg() {
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

on() {
    # Creates new note in $OBSIDIAN_VAULT
    ~/.dotfiles/bash/scripts/parse-obsidian-newnote-name.sh "$*"
}

# =====================
# ==== Git Aliases ====
# =====================

alias ga='git add'
alias gap='git add -p'
alias gp='git push && git push --tags'
alias gtt='git status -s'
alias gttt='git status'
alias ggt='gtt'
alias gll='git log --color=always --graph --pretty=format:"%C(auto)%h %C(reset)%s %C(auto)%d" --date=short | less -R'
alias glp='git log --color=always --graph --pretty=format:"%C(auto)%h %C(blue)%ad %C(reset)%s %C(brightblack)(%an)%C(auto)%d" --date=short | less -R'
alias gck='git checkout'
alias gch='git switch'
alias gsh='git stash'
alias gpp='git stash pop'
alias gff='git diff'
alias gffs='git diff --staged'
alias gres='git restore --stage'

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
