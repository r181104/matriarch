# =========================================
#           INTERACTIVE CHECK
# =========================================
if status is-interactive
    # Commands to run in interactive sessions only
end

# =========================================
#           ENVIRONMENT VARIABLES
# =========================================
set -Ux SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

set -gx LANG en_IN.UTF-8

set -gx _ZO_ECHO 1       # Print directory after jumping (like `cd`)
set -gx _ZO_EXCLUDE_DIRS "$HOME/private/*"  # Exclude dirs from history

set -gx BROWSER "brave"
set -gx TERM "alacritty"
set -gx EDITOR "zeditor"
set -gx COLORTERM "truecolor"
set -gx LS_COLORS "di 1;3;34:fi=0"

# =========================================
#           JAVA ENVIRONMENT
# =========================================
set -Ux JAVA_HOME (archlinux-java get | string replace 'java-' '/usr/lib/jvm/java-')
set -Ux PATH $JAVA_HOME/bin $PATH

# =========================================
#           KEY BINDINGS
# =========================================
set -g fish_key_bindings fish_default_key_bindings
bind \en down-or-search
bind \ep up-or-search

# =========================================
#           BASIC ALIASES (eza)
# =========================================
alias ls 'eza -a --icons'
alias l 'eza -a --icons'
alias la 'eza -a --icons -l'
alias ll 'eza -a --icons -l'
alias lx 'eza -a --icons -l --sort=extension'
alias lk 'eza -a --icons -l --sort=size'
alias lc 'eza -a --icons -l --sort=changed'
alias lu 'eza -a --icons -l --sort=accessed'
alias lr 'eza -a --icons -l -R'
alias lt 'eza -a --icons -l --sort=modified'
alias lm 'eza -a --icons -l | less'
alias lw 'eza -a --icons -x'
alias labc 'eza -a --icons --sort=name'
alias tree 'eza -a --icons --tree'
alias c 'clear'

# =========================================
#           NAVIGATION SHORTCUTS
# =========================================
alias home 'cd ~'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias bd 'cd "$OLDPWD"'

# =========================================
#           EDITOR ALIASES
# =========================================
alias n 'nvim'
alias sn 'sudo nvim'
alias v 'vim'
alias sv 'sudo vim'

# =========================================
#           TMUX ALIASES
# =========================================
alias tns 'tmux new -s'
alias ta 'tmux attach'
alias td 'tmux detach'

# =========================================
#           SYSTEM ALIASES
# =========================================
alias ps 'ps auxf'
alias ping 'ping -c 5'
alias less 'less -R'
alias h "history | grep "
alias p "ps aux | grep "
alias topcpu "ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias ffind "fzf --preview='bat {}' --bind 'enter:execute(nvim {})'"  # safer than overriding find
alias f "find . | grep "
alias openports 'netstat -tulanp'

# System control
alias reboot 'systemctl reboot'
alias shutdown 'shutdown now'
alias logout 'loginctl kill-session $XDG_SESSION_ID'
alias restart-dm 'systemctl restart display-manager'

# =========================================
#           PACKAGE MANAGEMENT
# =========================================
alias rebel '~/senv/scripts/rebuild'
alias uprebel '~/senv/scripts/up-rebuild'
alias cwifi '~/senv/scripts/cwifi'
alias op-net '~/senv/scripts/optimize-network'

# =========================================
#           FILE OPERATIONS
# =========================================
alias cp 'cp -i'
alias mv 'mv -i'
alias mkdir 'mkdir -p'
alias rmd '/bin/rm --recursive --force --verbose'

alias diskspace "du -S | sort -n -r | less"
alias folders 'du -h --max-depth=1'
alias mountedinfo 'df -hT'
alias duf 'duf -hide special'

# =========================================
#           PERMISSIONS & SECURITY
# =========================================
alias mx 'chmod a+x'
alias 000 'chmod -R 000'
alias 644 'chmod -R 644'
alias 666 'chmod -R 666'
alias 755 'chmod -R 755'
alias 777 'chmod -R 777'
alias sha1 'openssl sha1'
alias chown 'sudo chown -R $USER'

# =========================================
#           DEV & TOOLS
# =========================================
alias grep 'grep --color=auto'
alias rg 'rg --color=auto'
alias bright 'brightnessctl set'

# =========================================
#           GIT
# =========================================
alias gp 'git push'
alias git-clean 'git reflog expire --expire=now --all; git gc --prune=now --aggressive'

# =========================================
#           PROGRAMMING
# =========================================
alias pyr 'python'

# =========================================
#           UTILITY
# =========================================
alias kssh "kitty +kitten ssh"
alias web 'cd /var/www/html'
alias da 'date "+%Y-%m-%d %A %T %Z"'
alias random-lock 'betterlockscreen -u ~/Wallpapers/Pictures --fx blur -l'
alias anime '~/senv/scripts/ani-cli'

# =========================================
#           PROMPT / TOOLS INIT
# =========================================
if command -q starship
    starship init fish | source
end

if command -q zoxide
    set -gx _ZO_FZF_PREVIEW 'ls --color=always {}'
    zoxide init fish | source
end

if command -q fzf
    fzf_key_bindings | source
end

# =========================================
#           FUNCTIONS
# =========================================
function fzf_nvim --description "Fuzzy-find a file and open in Neovim"
    set -l selected_file (fzf --height=40% --reverse --ansi \
        --prompt="📝 Open in nvim: " \
        --preview 'eza --icons --color=always --long --git --group --modified {1..1} 2>/dev/null' \
        --preview-window=right:60%:wrap)
    if test -n "$selected_file"
        nvim "$selected_file"
        commandline -f repaint
    end
end
bind \er fzf_nvim

function fzf_zoxide_dir --description "Fuzzy-find a directory from zoxide and jump"
    set -l selected_dir (
        zoxide query -l | fzf --height=40% --reverse --ansi \
            --prompt="📂 Jump to: " \
            --preview 'eza --icons --tree --level=2 --color=always {} 2>/dev/null' \
            --preview-window=right:50%:wrap
    )
    if test -n "$selected_dir"
        z "$selected_dir"
        commandline -f repaint
    end
end
bind \ed fzf_zoxide_dir

function gacp
    git add .; git commit -m 's'; git push
end

function gs
    git status
end

function optimise-nix
    nix-env -q | xargs nix-env -e
    sudo nix-store --gc --print-roots | grep obsolete
end

function clean-nix
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5
    sudo nix-store --gc --print-roots | grep /tmp | awk '{print $1}' | xargs rm -f
end

function store-size
    df -h /
    du -sh /nix/store
end

function fish_greeting
    random choice "Hello!" "Hi!" "Good Day!" "Howdy!"
end

function fish_title
    echo $argv[1] (prompt_pwd)
    pwd
end

function tty_kill_all
    set ttys (who | grep -v 'tty1' | cut -d' ' -f2 | sort -u)
    if test -n "$ttys"
        set tty_csv (string join , $ttys)
        sudo pkill -t "$tty_csv"
    else
        echo "No TTYs found (excluding tty1)"
    end
end

function gac
    git add .; git commit -m $argv
end

# Force curl to prefer IPv4
function curl
    command curl -4 $argv
end

function mirror-rating --description 'Update Arch Linux mirrors (India + optional nearby countries)'
    set -l mirrorlist /etc/pacman.d/mirrorlist
    set -l backup /etc/pacman.d/mirrorlist.bak

    echo "  Backing up current mirrorlist → $backup"
    sudo cp $mirrorlist $backup

    echo
    echo "  Select mirror scope:"
    echo "1)   India only"
    echo "2)   India + nearby (Singapore, Japan, Hong Kong)"
    read -l choice

    switch $choice
        case 1
            set countries IN
        case 2
            set countries IN,SG,JP,HK
        case '*'
            echo "  Invalid choice. Aborting."
            return 1
    end

    echo
    echo "  Fetching fastest mirrors for: $countries"
    rate-mirrors --entry-country=$countries --protocol=https --max-mirrors-to-output=20 arch | sudo tee $mirrorlist

    echo
    echo "  Refresh pacman databases now? (y/n)"
    read -l refresh
    if test "$refresh" = y
        sudo pacman -Syyu
    else
        echo "  Mirrorlist updated. Run 'sudo pacman -Syyu' manually when ready."
    end
end

# NOTE: Arch Package Manager
if type -q paru
    alias i 'paru --noconfirm -S --needed'
    alias u 'paru --noconfirm -Syu'
    alias r 'paru -Rns'
    alias s 'paru -Ss'
    alias remove-orphaned 'sudo pacman -Rns (pacman -Qtdq) && paru -Rns (pacman -Qtdq)'
    alias aggressively-clear-cache 'sudo pacman -Scc && paru -Scc'
    alias clear-cache 'sudo pacman -Sc && paru -Sc'
else if type -q yay
    alias i 'yay --noconfirm -S --needed'
    alias u 'yay --noconfirm -Syu'
    alias r 'yay -Rns'
    alias s 'yay -Ss'
    alias remove-orphaned 'sudo pacman -Rns (pacman -Qtdq) && yay -Rns (pacman -Qtdq)'
    alias aggressively-clear-cache 'sudo pacman -Scc && yay -Scc'
    alias clear-cache 'sudo pacman -Sc && yay -Sc'
else
    alias i 'sudo pacman --noconfirm -S --needed'
    alias u 'sudo pacman --noconfirm -Syu'
    alias r 'sudo pacman -Rns'
    alias s 'sudo pacman -Ss'
    alias remove-orphaned 'sudo pacman -Rns (pacman -Qtdq)'
    alias aggressively-clear-cache 'sudo pacman -Scc'
    alias clear-cache 'sudo pacman -Sc'
end
