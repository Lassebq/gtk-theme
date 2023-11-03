contains() {
    while read -r line
    do
        if [ "$line" = "$1" ]; then
            return 0
        fi
    done
    return 1
}

array() {
    for element in "$@"; do
        echo "$element"
    done
}

exclude="$(array "default" "hicolor" "locolor")"

is_valid_theme() {
    if echo "$exclude" | contains "${1##*/}"; then
        return 1
    fi
    [ -d "$1" ] && [ -f "$1/index.theme" ]
}

list_themes() {
    for theme in $(find /usr/share/themes ~/.themes "$XDG_DATA_HOME"/themes -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
    do
        if is_valid_theme "$theme"; then
            basename "$theme"
        fi
    done | sort -u
}

is_valid_icon_theme() {
    if echo "$exclude" | contains "${1##*/}"; then
        return 1
    fi
    [ -d "$1" ] && [ -f "$1/index.theme" ] && grep -q "^Directories=" "$1/index.theme"
}

list_icons() {
    for theme in $(find /usr/share/icons ~/.icons "$XDG_DATA_HOME"/icons -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
    do
        if is_valid_icon_theme "$theme"; then
            basename "$theme"
        fi
    done | sort -u
}

is_valid_cursor_theme() {
    if echo "$exclude" | contains "${1##*/}"; then
        return 1
    fi
    [ -d "$1" ] && [ -d "$1/cursors" ]
}

list_cursors() {
    for theme in $(find /usr/share/icons ~/.icons "$XDG_DATA_HOME"/icons -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
    do
        if is_valid_cursor_theme "$theme"; then
            basename "$theme"
        fi
    done | sort -u
}

_gtk-theme() {
    local i cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="-l -d -f -t -c -i -h -m --help"

    case "${prev}" in
        -m)
            COMPREPLY=( $(compgen -f "${cur}") )
            return 0
            ;;
        -f)
            COMPREPLY=( $(compgen -f "${cur}") )
            return 0
            ;;
        -t)
            COMPREPLY=( $(compgen -W "$(list_themes)" -- "${cur}") )
            return 0
            ;;
        -i)
            COMPREPLY=( $(compgen -W "$(list_icons)" -- "${cur}") )
            return 0
            ;;
        -c)
            COMPREPLY=( $(compgen -W "$(list_cursors)" -- "${cur}") )
            return 0
            ;;
    esac

    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
}

complete -F _gtk-theme -o bashdefault -o default gtk-theme