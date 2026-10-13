# =============================================================================
# Navigation
# =============================================================================


# =============================================================================
# Vim
# =============================================================================

vimf() {
    local file
    file=$($FIND --type f --hidden --exclude build --exclude .git "$@" | fzf) || return
    vim "$file"
}

# =============================================================================
# Git
# =============================================================================


# =============================================================================
# Search
# ============================================================================

fdf() {
    ($FIND --type f "$@" | fzf) || return
}

cdf() {
    local dir
    dir=$($FIND --type d "$@" | fzf) || return
    cd "$dir"
}


# Run and save a command separately for each project.
#
# Projects are identified by their Git root directory.
# Outside Git repositories, the current directory is used.
# Commands are stored in ~/.local/state/run/.
#
# Usage:
#   run <command>       Execute and save a project-specific command.
#   run                 Execute the previously saved command.
#   run --show          Display the saved command.
#   run --clear         Delete the saved command.
#
# Examples (Note: chained commands must use bash -c with quotes):
#   run cmake --build build
#   run bash -c 'cmake --build build && ./build/TermRush.exe'
#   run --show
#   run --clear
#   run

run() {
    local project file id
    local storage="$HOME/.local/state/run"

    project=$(git rev-parse --show-toplevel 2>/dev/null) || project="$PWD"

    id=$(printf '%s' "$project" | sha256sum)
    id=${id%% *}

    file="$storage/$id"

    case "$1" in
        --show)
            if [[ ! -s "$file" ]]; then
                echo "run: no saved command for $project" >&2
                return 1
            fi

            cat "$file"
            return
            ;;

        --clear)
            if [[ ! -f "$file" ]]; then
                echo "run: no saved command for $project" >&2
                return 1
            fi

            rm -- "$file"
            return
            ;;
    esac

    if (( $# > 0 )); then
        mkdir -p "$storage" || return 1
        {
            printf '%q ' "$@"
            printf '\n'
        } > "$file" || return 1
    elif [[ ! -s "$file" ]]; then
        echo "run: no saved command for $project" >&2
        return 1
    fi

    (
        cd "$project" || exit 1
        bash "$file"
    )
}
