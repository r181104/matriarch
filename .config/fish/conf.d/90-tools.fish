# ==============================
#   Tool Overrides & Tweaks
# ==============================

# Override curl to pretty-print JSON if jq is installed
if type -q jq
    function curl
        command curl $argv | jq .
    end
end

# Use bat instead of cat if available
if type -q bat
    alias cat 'bat --style=plain --paging=never'
end

# Use fd instead of find if available
if type -q fd
    alias find 'fd'
end
