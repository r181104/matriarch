# ==============================
#   General Aliases
# ==============================

# Navigation
alias home 'cd ~'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias bd 'cd "$OLDPWD"'
alias c 'clear'

# Editors
alias n 'nvim'
alias sn 'sudo nvim'
alias v 'vim'
alias sv 'sudo vim'

# Tmux
alias tns 'tmux new -s'
alias ta 'tmux attach'
alias td 'tmux detach'

# System helpers
alias ps 'ps auxf'
alias ping 'ping -c 5'
alias less 'less -R'
alias h "history | grep "
alias p "ps aux | grep "
alias topcpu "ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias ffind "fzf --preview='bat {}' --bind 'enter:execute(nvim {})'"
alias f "find . | grep "
alias openports 'netstat -tulanp'

# System control
alias reboot 'systemctl reboot'
alias shutdown 'shutdown now'
alias logout 'loginctl kill-session $XDG_SESSION_ID'
alias restart-dm 'sudo systemctl restart display-manager'

# Custom scripts
alias rebel '~/senv/scripts/rebuild'
alias uprebel '~/senv/scripts/up-rebuild'
alias cwifi '~/senv/scripts/cwifi'
alias op-net '~/senv/scripts/optimize-network'

# File operations
alias cp 'cp -i'
alias mv 'mv -i'
alias mkdir 'mkdir -p'
alias rmd '/bin/rm -rfv'

# Disk usage
alias diskspace "du -S | sort -n -r | less"
alias folders 'du -h --max-depth=1'
alias mountedinfo 'df -hT'
alias duf 'duf -hide special'

# Permissions & security
alias mx 'chmod a+x'
alias 000 'chmod -R 000'
alias 644 'chmod -R 644'
alias 666 'chmod -R 666'
alias 755 'chmod -R 755'
alias 777 'chmod -R 777'
alias sha1 'openssl sha1'
alias chown 'sudo chown -R $USER'

# Dev & tools
alias grep 'grep --color=auto'
alias rg 'rg --color=auto'
alias bright 'brightnessctl set'

# Git helpers
alias gp 'git push'
alias git-clean 'git reflog expire --expire=now --all; git gc --prune=now --aggressive'

# Programming helpers
alias pyr 'python'

# Utilities
alias kssh "kitty +kitten ssh"
alias web 'cd /var/www/html'
alias da 'date "+%Y-%m-%d %A %T %Z"'
alias random-lock 'betterlockscreen -u ~/Wallpapers/Pictures --fx blur -l'
alias anime '~/senv/scripts/ani-cli'

# LLMS
alias llama-chat "llama-simple-chat -m ~/LLMS/qwen2.5-0.5b-instruct-q4_k_m.gguf -ngl 12"
alias llama-server "llama-server -m ~/LLMS/qwen2.5-0.5b-instruct-q4_k_m.gguf -ngl 12"
