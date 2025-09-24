[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'
alias n='nvim'
alias nv='neovide'
alias sn='sudo nvim'

git_prompt() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    local status=""

    local changes=$(git status --porcelain 2>/dev/null)
    [[ $changes =~ M ]] && status+="+"    # modified
    [[ $changes =~ A ]] && status+="󱈸"    # added
    [[ $changes =~ D ]] && status+="󰳭"    # deleted
    [[ $changes =~ \?\? ]] && status+="󰤔" # untracked
    [[ $changes =~ U ]] && status+="󱐌"    # unmerged

    echo "[$branch$status]"
  fi
}

export PS1='\[\e[0;36m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;35m\]\w\[\e[0m\]$(git_prompt)\$ '
