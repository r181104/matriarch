# ==============================
#   File Listing Aliases
# ==============================
if type -q eza
    alias ls    'eza -a --icons'
    alias l     'eza -a --icons'
    alias la    'eza -a --icons -l'
    alias ll    'eza -a --icons -l'
    alias lx    'eza -a --icons -l --sort=extension'
    alias lk    'eza -a --icons -l --sort=size'
    alias lc    'eza -a --icons -l --sort=changed'
    alias lu    'eza -a --icons -l --sort=accessed'
    alias lr    'eza -a --icons -l -R'
    alias lt    'eza -a --icons -l --sort=modified'
    alias lm    'eza -a --icons -l | less'
    alias lw    'eza -a --icons -x'
    alias labc  'eza -a --icons --sort=name'
    alias tree  'eza -a --icons --tree'
else
    alias ls    'ls -A --color=auto'
    alias l     'ls -A --color=auto'
    alias la    'ls -lhA --color=auto'
    alias ll    'ls -lhA --color=auto'
    alias lx    'ls -lhA --color=auto'
    alias lk    'ls -lhAS --color=auto'
    alias lc    'ls -lhAt --color=auto'
    alias lu    'ls -lhAu --color=auto'
    alias lr    'ls -lhAR --color=auto'
    alias lt    'ls -lhAt --color=auto'
    alias lm    'ls -lhA --color=auto | less'
    alias lw    'ls -xA --color=auto'
    alias labc  'ls -lhA --color=auto'
    alias tree  'ls -R --color=auto'
end
