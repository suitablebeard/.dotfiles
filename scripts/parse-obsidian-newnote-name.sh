#!/bin/bash

if [ -z "$*" ]; then
    echo "Error: note name must be provided." >&2
    exit 1
fi

filename="${*%.md}.md"

cd "$OBSIDIAN_VAULT" && $EDITOR "$OBSIDIAN_VAULT/+/$filename"

