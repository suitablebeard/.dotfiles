shopt -s nullglob # makes the code run only if  matches are found

CONFIG_DIR="$HOME/.config/bash"

for file in "$CONFIG_DIR"/*.sh; do
    [[ -f "$file" ]] && source "$file"
done

shopt -u nullglob # unsets option

# Device-specific overrides
if [ -f "$HOME/.bashrc.local" ]; then
    . "$HOME/.bashrc.local"
fi
