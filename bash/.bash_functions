# =============================================================================
# Navigation
# =============================================================================

cdf() {
    local dir
    dir=$($FIND --type d "$@" | fzf) || return
    cd "$dir"
}


# =============================================================================
# Vim
# =============================================================================

vimf() {
    local file
    file=$($FIND --type f --hidden --exclude build --exclude .git "$@" | fzf) || return
    vim "$file"
}

# =============================================================================
# Search
# =============================================================================

fdf() {
    ($FIND --type f "$@" | fzf) || return
}

# =============================================================================
# Build & Run
# =============================================================================

# Execute and save project-specific commands.
# Use 'run --help' for usage information.
RUN_HELP=$(cat <<'EOF'
Usage: run [OPTION] [COMMAND...]

Execute and save a project-specific command.

Commands are saved separately for each Git repository.
Outside Git repositories, the current directory is used.

Options:
  -h, --help     Show this help message
  --show         Show the saved command
  --clear        Remove the saved command
  -e, --edit     Edit or create the saved command
EOF
)

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

        -h|--help)
            printf '%s\n' "$RUN_HELP"
            return 0
            ;;

        -e|--edit)
            mkdir -p "$storage" || return 1

            vim "$file"
            local status=$?

            if [[ -f "$file" && ! -s "$file" ]]; then
                rm -- "$file" || return 1
            fi

            return "$status"
            ;;
    esac

    if (( $# > 0 )); then
        mkdir -p "$storage" || return 1

        if (( $# == 1 )); then
            printf '%s\n' "$1" > "$file" || return 1
        else
            {
                printf '%q ' "$@"
                printf '\n'
            } > "$file" || return 1
        fi

    elif [[ ! -s "$file" ]]; then
        echo "run: no saved command for $project" >&2
        return 1
    fi

    (
        cd "$project" || exit 1
        bash "$file"
    )
}
