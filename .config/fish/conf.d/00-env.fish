# ==============================
#   Environment Variables
# ==============================
set -gx LANG en_IN.UTF-8
set -gx BROWSER "brave"
set -gx TERM "alacritty"
set -gx EDITOR "zeditor"
set -gx COLORTERM "truecolor"
set -gx LS_COLORS "di=1;34:fi=0"
# set -gx LS_COLORS "di 1;3;34:fi=0"

# Java environment (auto-detect JDK)
set -Ux JAVA_HOME (archlinux-java get | string replace 'java-' '/usr/lib/jvm/java-')
set -Ux PATH $JAVA_HOME/bin $PATH
