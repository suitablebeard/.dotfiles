shopt -s nullglob # makes the code run only if  matches are found

for file in ~/.dotfiles/bash/*.sh; do
    [[ -f "$file" ]] && source "$file" # makes sure it only matches files and not folders
done

shopt -u nullglob # unsets option

# Device-specific overrides
if [ -f "$HOME/.bashrc.local" ]; then
    . "$HOME/.bashrc.local"
fi
