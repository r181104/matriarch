# ==============================
#   Package Manager Aliases
# ==============================
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
