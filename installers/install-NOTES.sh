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


stow --dir=/path/to/dotfiles --target=/path/to/destination --adopt -R "<PACKAGES>"

YELLOW=$'\033[0;93m'
BOLD=$'\033[1m'
RESET=$'\033[0m'

STOW_MODIFIED_FILES=$(git status --porcelain | grep '^ M' | cut -c4-)

if [[ -n $STOW_MODIFIED_FILES ]]; then
   cat <<EOF
${YELLOW}[NOTICE] Stow might have adopted existing local files for some of your packages:${RESET}
$(echo "$STOW_MODIFIED_FILES" | sed "s/^/  ${YELLOW}- /;s/$/${RESET}/")

Your repository files might have been overwritten with their local version.
  • To review changes: ${BOLD}git diff${RESET}
  • To discard local changes: ${BOLD}git checkout -- <file>${RESET}
  • To keep them: ${BOLD}git add <file> && git commit -m 'Adopt local changes'${RESET}
EOF
else
    echo -e "\n\033[1;32m[SUCCESS] Stow completed with no conflicts or adoptions.\033[0m"
fi
