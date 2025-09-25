# Clear existing PATH
PATH=""
# Add your preferred paths manually
PATH="$HOME/.local/bin"
PATH="$HOME/.local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="/usr/bin:$PATH"
PATH="/usr/sbin:$PATH"
PATH="/bin:$PATH"
PATH="/sbin:$PATH"
# Export it so all child processes see it
export PATH

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'
alias n='nvim'
alias nv='neovide'
alias sn='sudo nvim'

export PS1='\[\e[0;36m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;35m\]\w\[\e[0m\] ✦ '
