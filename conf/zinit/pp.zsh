# Powerline-style prompt for Zsh, inspired by the provided image.
# This version uses a robust left/right prompt.

# Enable color support
autoload -U colors && colors

# --- Functions to get prompt data ---

# Get an icon based on the operating system
get_platform_icon() {
    case "$OSTYPE" in
        linux*)
            if [[ -f /proc/version ]] && grep -q -i Microsoft /proc/version; then
                echo "" # Windows icon for WSL
            else
                echo "🐧" # Linux
            fi
            ;;
        darwin*)
            echo "" # macOS
            ;;
        msys*|cygwin*)
            echo "" # Windows
            ;;
        *)
            echo "💻" # Generic
            ;;
    esac
}

# Get Git branch and status information
get_git_info() {
    if ! command git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        return
    fi

    local branch
    branch=$(command git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ -z "$branch" ]]; then return; fi

    local git_status
    git_status=$(command git status --porcelain=v1 2> /dev/null)
    local staged_count
    staged_count=$(echo "$git_status" | grep -c -E '^[MARCD]')
    local untracked_count
    untracked_count=$(echo "$git_status" | grep -c '^??')

    local status_str=""
    if [[ "$staged_count" -ne 0 ]]; then
        status_str+=" !${staged_count}"
    fi
    if [[ "$untracked_count" -ne 0 ]]; then
        status_str+=" ?${untracked_count}"
    fi

    echo "  ${branch}${status_str}"
}

# --- Prompt Setup ---

# This function is executed before each prompt
precmd() {
    # --- Colors (darker shades) ---
    local C_BG_BLUE='%K{25}'       # Darker Blue
    local C_BG_YELLOW='%K{178}'    # Darker Yellow/Gold
    local C_FG_WHITE='%F{white}'
    local C_FG_BLACK='%F{black}'
    local C_FG_BLUE='%F{25}'
    local C_FG_YELLOW='%F{178}'
    local C_RESET='%k%f'

    # --- Powerline Separators (requires a Nerd Font or Powerline font) ---
    local SEP_R=''

    # --- Left Prompt (PROMPT) ---
    local platform_icon=$(get_platform_icon)
    local current_path='%~'
    local git_info=$(get_git_info)

    local prompt_left=""
    prompt_left+="${C_BG_BLUE}${C_FG_WHITE} ${platform_icon} ${current_path} ${C_RESET}"

    if [[ -n "$git_info" ]]; then
        prompt_left+="${C_FG_BLUE}${C_BG_YELLOW}${SEP_R}${C_RESET}"
        prompt_left+="${C_BG_YELLOW}${C_FG_BLACK} ${git_info} ${C_RESET}"
        prompt_left+="${C_FG_YELLOW}${SEP_R}${C_RESET}"
    else
        prompt_left+="${C_FG_BLUE}${SEP_R}${C_RESET}"
    fi

    # --- Final Assembly ---
    PROMPT="${prompt_left} "
    RPROMPT="" # Right prompt is disabled
    
    PROMPT+=$'
%F{green}❯%f '
}