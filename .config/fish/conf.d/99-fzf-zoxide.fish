# ==============================
#   FZF + Zoxide Integration
# ==============================

# ----- Zoxide -----
if type -q zoxide
    zoxide init fish | source
    alias j 'z'   # quick jump
end

# ----- FZF Keybindings -----
if type -q fzf
    # File search with preview
    function fzf_files
        set file (fzf --preview 'bat --style=numbers --color=always {} | head -500')
        if test -n "$file"
            nvim "$file"
        end
    end

    # Directory search
    function fzf_cd
        set dir (find . -type d | fzf)
        if test -n "$dir"
            cd "$dir"
        end
    end

    # Git file browser
    function fzf_git
        set file (git ls-files | fzf --preview 'bat --style=numbers --color=always {} | head -500')
        if test -n "$file"
            nvim "$file"
        end
    end
end

# ----- FZF Default Options -----
set -Ux FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'
set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -Ux FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude .git'
