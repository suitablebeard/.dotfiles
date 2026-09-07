#!/bin/bash

if [ "$EDITOR" = "nvim" ]; then
    filename="$*"
    if [ -n "$filename" ]; then
        if [[ "$filename" != *.md ]]; then
            filename="${filename}.md"
        fi
        cd "$OBSIDIAN_VAULT" && nvim "./+/$filename"
    else
        echo "Error: note name must be provided." >&2
        exit 1
    fi
elif [ "$EDITOR" = "vim" ]; then
    if [ $# -eq 0 ]; then
        cd "$OBSIDIAN_VAULT" && vim . -c "call feedkeys(':ObsidianNewNote ', 'n')"
    else
        cd "$OBSIDIAN_VAULT" && vim . -c "ObsidianNewNote $*"
    fi
else
    echo "Error: \$EDITOR is set to '$EDITOR'. Expected 'vim' or 'nvim'." >&2
    exit 1
fi

