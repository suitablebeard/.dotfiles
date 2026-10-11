#!/usr/bin/env bash

# ===== Symbolic links I've created so far =====

ln -s ./bash/.bashrc              ~/
ln -s ./bash/.bashrc.local        ~/
ln -s ./vim/.vimrc                ~/
ln -s ./nvim/*                    ~/.config/nvim/
ln -s ./.stylua.toml              ~/

# ===== Useful commands I've had to use =====

# make git ignore specific files wihtout removing them from the remote repo
# this is for file that are causing issues
# (e.g files for windows don't work on linux)
# git update-index --skip-worktree <FILE> && rm <FILE>
git update-index --skip-worktree bash/windows-terminal-split-in-cwd.sh && rm bash/windows-terminal-split-in-cwd.sh

# ==== Stow ====
# Useful for seeing if there were conflicts when `stow` was run, which were
# solved by adopting (overwriting) the repo files with the local versions.


