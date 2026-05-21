# Tell Windows Terminal the current working directory
WT_PROMPT_SET_CWD() {
    local pwd_uri
    # Convert standard paths to an format Windows Terminal understands
    pwd_uri=$(printf "%s" "$PWD" | sed -e 's/ /%20/g')
    printf '\e]9;9;"%s"\e\\' "$(cygpath -m "$PWD")"
}
PROMPT_COMMAND="WT_PROMPT_SET_CWD; $PROMPT_COMMAND"
