# NOTE: Run only in interactive shell
if status is-interactive
end

# NOTE: Load Starship prompt if available
if command -q starship
    starship init fish | source
end

# NOTE: GPG agent as SSH auth socket
set -Ux SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# NOTE: System locale
set -gx LANG en_IN.UTF-8

# NOTE: Zoxide settings
set -gx _ZO_ECHO 1
set -gx _ZO_EXCLUDE_DIRS "$HOME/private/*"

# NOTE: Default applications
set -gx BROWSER "brave"
set -gx TERM "alacritty"
set -gx EDITOR "zeditor"
set -gx COLORTERM "truecolor"
set -gx LS_COLORS "di=1;34:fi=0"
# set -gx LS_COLORS "di 1;3;34:fi=0"

# NOTE: Java environment (auto-detect JDK)
set -Ux JAVA_HOME (archlinux-java get | string replace 'java-' '/usr/lib/jvm/java-')
set -Ux PATH $JAVA_HOME/bin $PATH

# NOTE: Default Fish key bindings
set -g fish_key_bindings fish_default_key_bindings
bind \en down-or-search    # NOTE: Next search with ↑
bind \ep up-or-search      # NOTE: Previous search with ↓

# NOTE: Navigation shortcuts
alias home 'cd ~'             # go home
alias .. 'cd ..'              # up one dir
alias ... 'cd ../..'          # up two dirs
alias .... 'cd ../../..'      # up three dirs
alias ..... 'cd ../../../..'  # up four dirs
alias bd 'cd "$OLDPWD"'       # back to previous dir
alias c 'clear'               # clear terminal

# NOTE: Editors
alias n 'nvim'        # Neovim
alias sn 'sudo nvim'  # Neovim as root
alias v 'vim'         # Vim
alias sv 'sudo vim'   # Vim as root

# NOTE: Tmux shortcuts
alias tns 'tmux new -s'   # new session
alias ta 'tmux attach'    # attach session
alias td 'tmux detach'    # detach session

# NOTE: System helpers
alias ps 'ps auxf'                               # process tree
alias ping 'ping -c 5'                           # ping 5 packets
alias less 'less -R'                             # keep colors in less
alias h "history | grep "                        # search history
alias p "ps aux | grep "                         # search processes
alias topcpu "ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10" # top CPU usage
alias ffind "fzf --preview='bat {}' --bind 'enter:execute(nvim {})'" # fuzzy file finder
alias f "find . | grep "                         # grep inside find
alias openports 'netstat -tulanp'                # list open ports

# NOTE: System control
alias reboot 'systemctl reboot'
alias shutdown 'shutdown now'
alias logout 'loginctl kill-session $XDG_SESSION_ID'
alias restart-dm 'sudo systemctl restart display-manager'

# NOTE: Custom scripts (no extra notes needed)
alias rebel '~/senv/scripts/rebuild'
alias uprebel '~/senv/scripts/up-rebuild'
alias cwifi '~/senv/scripts/cwifi'
alias op-net '~/senv/scripts/optimize-network'

# NOTE: File operations
alias cp 'cp -i'                  # safe copy
alias mv 'mv -i'                  # safe move
alias mkdir 'mkdir -p'            # make parent dirs if needed
alias rmd '/bin/rm -rfv'          # force delete with verbose

# NOTE: Disk usage
alias diskspace "du -S | sort -n -r | less"  # sorted disk space
alias folders 'du -h --max-depth=1'          # folder sizes
alias mountedinfo 'df -hT'                   # mounted info
alias duf 'duf -hide special'                # nicer df output

# NOTE: Permissions & security
alias mx 'chmod a+x'             # make executable
alias 000 'chmod -R 000'         # remove all perms
alias 644 'chmod -R 644'         # owner read/write, others read
alias 666 'chmod -R 666'         # everyone read/write
alias 755 'chmod -R 755'         # owner rwx, others rx
alias 777 'chmod -R 777'         # everyone rwx
alias sha1 'openssl sha1'        # sha1 checksum
alias chown 'sudo chown -R $USER' # take ownership

# NOTE: Dev & tools
alias grep 'grep --color=auto'   # grep with color
alias rg 'rg --color=auto'       # ripgrep with color
alias bright 'brightnessctl set' # adjust brightness

# NOTE: Git helpers
alias gp 'git push'
alias git-clean 'git reflog expire --expire=now --all; git gc --prune=now --aggressive'

# NOTE: Programming helpers
alias pyr 'python'  # python shortcut

# NOTE: Utilities
alias kssh "kitty +kitten ssh"    # kitty ssh
alias web 'cd /var/www/html'      # go to web root
alias da 'date "+%Y-%m-%d %A %T %Z"' # pretty date
alias random-lock 'betterlockscreen -u ~/Wallpapers/Pictures --fx blur -l' # lockscreen
alias anime '~/senv/scripts/ani-cli' # anime cli

# NOTE: LLMS aliases
alias llama-chat "llama-simple-chat -m ~/LLMS/qwen2.5-0.5b-instruct-q4_k_m.gguf -ngl 12"
alias llama-server "llama-server -m ~/LLMS/qwen2.5-0.5b-instruct-q4_k_m.gguf -ngl 12"

# WARN: FUNCITON ARE FROM HERE
# NOTE: Update Arch mirrors interactively
function mirror-rating
    set -l mirrorlist /etc/pacman.d/mirrorlist
    set -l backup /etc/pacman.d/mirrorlist.bak

    echo "  Backing up current mirrorlist → $backup"
    sudo cp $mirrorlist $backup

    echo
    echo "  Select mirror scope:"
    echo "1) India only"
    echo "2) India + nearby (Singapore, Japan, Hong Kong)"
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

# NOTE: Opencode
function opencode
    export LOCAL_ENDPOINT="http://localhost:1235/v1"
    opencode
end

# NOTE: Fuzzy-find file and open in nvim
function fzf_nvim
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

# NOTE: Fuzzy-jump with zoxide
function fzf_zoxide_dir
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

# NOTE: Git add, commit, push (quick)
function gacp
    git add .; git commit -m 's'; git push
end

# NOTE: Git status shortcut
function gs
    git status
end

# NOTE: Git add + custom commit message
function gac
    git add .; git commit -m $argv
end

# NOTE: Optimize Nix store
function optimise-nix
    nix-env -q | xargs nix-env -e
    sudo nix-store --gc --print-roots | grep obsolete
end

# NOTE: Clean Nix store
function clean-nix
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5
    sudo nix-store --gc --print-roots | grep /tmp | awk '{print $1}' | xargs rm -f
end

# NOTE: Show Nix store size
function store-size
    df -h /
    du -sh /nix/store
end

# NOTE: Fun greetings
function fish_greeting
    random choice "Hello!" "Hi!" "Good Day!" "Howdy!"
end

# NOTE: Custom terminal title
function fish_title
    echo $argv[1] (prompt_pwd)
    pwd
end

# NOTE: Kill all TTYs except tty1
function tty_kill_all
    # current tty name (basename of /dev/...)
    set -l curtty (basename (tty))

    # get only ttyN or pts/N entries from `who`, exclude current tty, uniq and sort
    set -l ttys (who | awk '{print $2}' | grep -E '^(tty[0-9]+|pts/[0-9]+)$' | grep -v "^$curtty\$" | sort -u)

    if test (count $ttys) -gt 0
        set -l tty_csv (string join , $ttys)
        echo "Targets: $tty_csv"
        echo "Processes that would be signalled:"
        # preview what we'd kill
        pgrep -a -t "$tty_csv" || echo "(no matching processes shown)"

        read -P "Proceed and send SIGTERM to these processes? (y/N) " answer
        if test "$answer" = "y"
            # soft terminate first
            sudo pkill -t "$tty_csv"
            sleep 1
            # if anything still attached, force kill
            if pgrep -a -t "$tty_csv" >/dev/null
                echo "Some processes remain; sending SIGKILL..."
                sudo pkill -9 -t "$tty_csv"
            end
            echo "Done."
        else
            echo "Aborted."
        end
    else
        echo "No other TTYs found (excluding current: $curtty)."
    end
end

# NOTE: Force curl to IPv4
function curl
    command curl -4 $argv
end

# NOTE: Listing Aliases
if type -q eza
    # eza-based aliases
    alias ls    'eza -a --icons'                      # list all with icons
    alias l     'eza -a --icons'                      # shorthand for ls
    alias la    'eza -a --icons -l'                   # detailed list
    alias ll    'eza -a --icons -l'                   # same as la
    alias lx    'eza -a --icons -l --sort=extension'  # sort by extension
    alias lk    'eza -a --icons -l --sort=size'       # sort by size
    alias lc    'eza -a --icons -l --sort=changed'    # sort by change time
    alias lu    'eza -a --icons -l --sort=accessed'   # sort by access time
    alias lr    'eza -a --icons -l -R'                # recursive
    alias lt    'eza -a --icons -l --sort=modified'   # sort by modified time
    alias lm    'eza -a --icons -l | less'            # list with pager
    alias lw    'eza -a --icons -x'                   # wide view
    alias labc  'eza -a --icons --sort=name'          # sort alphabetically
    alias tree  'eza -a --icons --tree'               # tree view
else
    # coreutils ls-based fallbacks
    alias ls    'ls -A --color=auto'        # list all with color
    alias l     'ls -A --color=auto'        # shorthand for ls
    alias la    'ls -lhA --color=auto'      # detailed list
    alias ll    'ls -lhA --color=auto'      # same as la
    alias lx    'ls -lhA --color=auto'      # no sort by extension in ls
    alias lk    'ls -lhAS --color=auto'     # sort by size
    alias lc    'ls -lhAt --color=auto'     # sort by change time (ctime not always portable)
    alias lu    'ls -lhAu --color=auto'     # sort by access time
    alias lr    'ls -lhAR --color=auto'     # recursive
    alias lt    'ls -lhAt --color=auto'     # sort by modified time
    alias lm    'ls -lhA --color=auto | less' # list with pager
    alias lw    'ls -xA --color=auto'       # wide view
    alias labc  'ls -lhA --color=auto'      # ls already sorts alphabetically by default
    alias tree  'ls -R --color=auto'        # pseudo-tree
end

# NOTE: Package manager aliases (detect paru/yay/pacman)
if type -q paru
    alias i 'paru --noconfirm -S --needed'    # install
    alias u 'paru --noconfirm -Syu'          # update
    alias r 'paru -Rns'                      # remove
    alias s 'paru -Ss'                       # search
    alias remove-orphaned 'sudo pacman -Rns (pacman -Qtdq) && paru -Rns (pacman -Qtdq)' # remove unused
    alias aggressively-clear-cache 'sudo pacman -Scc && paru -Scc' # clear all cache
    alias clear-cache 'sudo pacman -Sc && paru -Sc'                # clear partial cache
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

# NOTE: Init zoxide if installed
if command -q zoxide
    set -gx _ZO_FZF_PREVIEW 'ls --color=always {}'
    zoxide init fish | source
end

# NOTE: Init fzf if installed
if command -q fzf
    fzf_key_bindings | source
end
