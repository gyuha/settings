#!/usr/bin/env bash

__powerline() {

    # Unicode symbols
    readonly PS_SYMBOL_LINUX='$'
    readonly PS_SYMBOL_OTHER='%'
	readonly PS_SEPARATOR="⮁"
	readonly PS_SEPARATOR_BOLD="⮀"

    readonly GIT_BRANCH_SYMBOL='⭠'
    readonly GIT_BRANCH_CHANGED_SYMBOL='+'
    readonly GIT_NEED_PUSH_SYMBOL='⇡'
    readonly GIT_NEED_PULL_SYMBOL='⇣'

    # Solarized colorscheme
    readonly FG_BLACK="\[$(tput setaf 0)\]"
    readonly FG_BLUE="\[$(tput setaf 4)\]"
    readonly FG_CYAN="\[$(tput setaf 6)\]"
    readonly FG_GREEN="\[$(tput setaf 2)\]"
    readonly FG_MAGENTA="\[$(tput setaf 5)\]"
    readonly FG_ORANGE="\[$(tput setaf 9)\]"
    readonly FG_RED="\[$(tput setaf 1)\]"
    readonly FG_VIOLET="\[$(tput setaf 13)\]"
    readonly FG_YELLOW="\[$(tput setaf 3)\]"
    readonly FG_WHITE="\[$(tput setaf 7)\]"

    readonly BG_BLACK="\[$(tput setab 0)\]"
    readonly BG_BLUE="\[$(tput setab 4)\]"
    readonly BG_CYAN="\[$(tput setab 6)\]"
    readonly BG_GREEN="\[$(tput setab 2)\]"
    readonly BG_MAGENTA="\[$(tput setab 5)\]"
    readonly BG_ORANGE="\[$(tput setab 9)\]"
    readonly BG_RED="\[$(tput setab 1)\]"
    readonly BG_VIOLET="\[$(tput setab 13)\]"
    readonly BG_YELLOW="\[$(tput setab 3)\]"
    readonly BG_WHITE="\[$(tput setab 7)\]"

    readonly DIM="\[$(tput dim)\]"
    readonly REVERSE="\[$(tput rev)\]"
    readonly RESET="\[$(tput sgr0)\]"
    readonly BOLD="\[$(tput bold)\]"

    __git_info() {
        [ -x "$(which git)" ] || return    # git not found

        local git_eng="env LANG=C git"   # force git output in English to make our work easier
        # get current branch name or short SHA1 hash for detached head
        local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

        local marks

        # branch is modified?
        [ -n "$($git_eng status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

        # how many commits local branch is ahead/behind of remote?
        local stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        local behindN="$(echo $stat | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

        # print the git branch segment without a trailing newline
        printf " $GIT_BRANCH_SYMBOL$branch$marks "
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly.
        if [ $? -eq 0 ]; then
            local BG_EXIT="$BG_GREEN"
        else
            local BG_EXIT="$BG_RED"
        fi

		PS1="$BG_YELLOW$FG_BLACK \u@\h $RESET"
		PS1+="$BG_ORANGE$FG_YELLOW$PS_SEPARATOR_BOLD"
        PS1+="$BG_ORANGE$FG_WHITE$(__git_info)"
		PS1+="$BG_BLUE$FG_ORANGE$PS_SEPARATOR_BOLD"
		PS1+="$BG_BLUE$FG_WHITE"
		PS1+=" \w $RESET$FG_BLUE$PS_SEPARATOR_BOLD"
        PS1+="$RESET "
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline
