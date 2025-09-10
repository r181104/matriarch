# ==============================
#   Custom Functions
# ==============================

# ----- Mirror Selection -----
function rank-mirrors
    if type -q reflector
        echo "Ranking mirrors with reflector..."
        sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
    else if type -q rate-mirrors
        echo "Ranking mirrors with rate-mirrors..."
        rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist
    else
        echo "No mirror ranking tool found (install reflector or rate-mirrors)"
    end
end

# ----- Git Helpers -----
function gprune
    git fetch --prune
    git remote prune origin
end

# ----- Nix Helpers -----
function nrb
    echo "Rebuilding NixOS configuration..."
    sudo nixos-rebuild switch --flake ~/NixOS/#default
end

# ----- TTY Transparency Fix -----
function fix-tty
    echo -ne "\e[0m"
end

# ----- Curl JSON Pretty Print -----
function curl
    command curl $argv | jq .
end

# ----- Python Virtual Environment -----
function venv
    if test -d venv
        source venv/bin/activate.fish
    else
        python -m venv venv && source venv/bin/activate.fish
    end
end

# ----- Archive Extraction -----
function extract
    if test (count $argv) -eq 0
        echo "Usage: extract <file>"
        return 1
    end
    switch $argv[1]
        case '*.tar.bz2'
            tar xjf $argv[1]
        case '*.tar.gz'
            tar xzf $argv[1]
        case '*.bz2'
            bunzip2 $argv[1]
        case '*.rar'
            unrar x $argv[1]
        case '*.gz'
            gunzip $argv[1]
        case '*.tar'
            tar xf $argv[1]
        case '*.tbz2'
            tar xjf $argv[1]
        case '*.tgz'
            tar xzf $argv[1]
        case '*.zip'
            unzip $argv[1]
        case '*.Z'
            uncompress $argv[1]
        case '*.7z'
            7z x $argv[1]
        case '*'
            echo "Unknown archive format: $argv[1]"
    end
end

# ----- Weather -----
function weather
    curl -s "wttr.in/$argv"
end

# ----- System Cleanup -----
function cleanup
    echo "Cleaning system..."
    sudo pacman -Rns (pacman -Qtdq)
    sudo pacman -Sc --noconfirm
end
