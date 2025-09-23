import os
import subprocess

from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# --- MODIFIERS AND TERMINAL ---
mod = "mod4"
mmod = "mod1"
mmodd = "control"
menu = "bemenu-run --fn 'MesloLGS Nerd Font 20' -l 8"
terminal = "alacritty"
term = guess_terminal()
filemanager = "pcmanfm"
theme = os.path.expanduser("~/snix/scripts/wset-qtile")
browser = "firefox-developer-edition"

# --- NORD COLOR PALETTE ---
nord = {
    "nord0": "#2E3440",
    "nord1": "#3B4252",
    "nord2": "#434C5E",
    "nord3": "#4C566A",
    "nord4": "#D8DEE9",
    "nord5": "#E5E9F0",
    "nord6": "#ECEFF4",
    "nord7": "#8FBCBB",
    "nord8": "#88C0D0",
    "nord9": "#81A1C1",
    "nord10": "#5E81AC",
    "nord11": "#BF616A",
    "nord12": "#D08770",
    "nord13": "#EBCB8B",
    "nord14": "#A3BE8C",
    "nord15": "#B48EAD",
}

colors = [
    nord["nord0"],  # background
    nord["nord11"],  # red
    nord["nord14"],  # green
    nord["nord13"],  # yellow
    nord["nord9"],  # blue
    nord["nord10"],  # blue-alt
    nord["nord8"],  # cyan
    nord["nord4"],  # fg-light
    nord["nord3"],  # gray
    nord["nord6"],  # fg
]

# --- KEYBINDINGS ---
keys = [
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([mmodd], "space", lazy.spawn(theme), desc="Launch theme changer"),
    Key([mod], "e", lazy.spawn(filemanager), desc="Launch file manager"),
    Key([mod], "j", lazy.screen.prev_group()),
    Key([mod], "k", lazy.screen.next_group()),
    Key([mod, "shift"], "f", lazy.window.toggle_maximize()),
    Key([mod], "h", lazy.window.toggle_minimize()),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
    Key([], "XF86AudioMedia", lazy.spawn("pavucontrol")),
    Key([mod, "shift"], "Return", lazy.spawn(term), desc="Launch terminal"),
    Key([mmod], "h", lazy.layout.left()),
    Key([mmod], "j", lazy.layout.down()),
    Key([mmod], "k", lazy.layout.up()),
    Key([mmod], "l", lazy.layout.right()),
    Key([mod, "shift"], "space", lazy.layout.next()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod, "control"], "Return", lazy.layout.toggle_split()),
    Key([mod, "shift"], "Return", lazy.spawn(guess_terminal())),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "t", lazy.window.toggle_floating()),
    Key([mod], "r", lazy.reload_config()),
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mmod, "control"], "q", lazy.shutdown()),
    Key([mod], "space", lazy.spawn(menu)),
]

for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

# --- GROUPS ---
groups = [
    Group("1", label=""),
    Group("2", label=""),
    Group("3", label=""),
    Group("4", label=""),
    Group("5", label=""),
    Group("6", label=""),
    Group("7", label=""),
    Group("8", label=""),
    Group("9", label=""),
    Group("0", label=""),
]

for i in groups:
    keys.extend(
        [
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
        ]
    )

# --- LAYOUTS ---
layout_common = {
    "border_focus": colors[5],
    "border_normal": colors[8],
    "border_width": 2,
    "margin": 0,
}

layouts = [
    layout.Columns(**layout_common),
    layout.Tile(**layout_common),
]

# --- WIDGET DEFAULTS ---
widget_defaults = {
    "font": "MesloLGS Nerd Font",
    "fontsize": 15,
    "padding": 10,
    "foreground": colors[7],
    "background": colors[0],
}
extension_defaults = widget_defaults.copy()


# --- BAR CONFIGURATION ---
def create_bar_widgets():
    return [
        widget.CurrentLayout(foreground=colors[3], padding=12),
        widget.Spacer(length=12),
        widget.GroupBox(
            highlight_method="block",
            block_highlight_text_color=colors[7],
            inactive=colors[8],
            active=colors[7],
            this_current_screen_border=colors[5],
            urgent_text=colors[1],
            rounded=True,
            padding=12,
            margin_x=6,
            font="MesloLGS Nerd Font",
        ),
        widget.Spacer(length=12),
        widget.Prompt(padding=12),
        widget.Spacer(),
        widget.WindowName(max_chars=60, foreground=colors[6], padding=12),
        widget.Spacer(),
        widget.Systray(icon_size=20, padding=12),
        widget.Spacer(length=12),
        widget.CheckUpdates(
            distro="Arch_checkupdates",
            display_format=" {updates}",
            no_update_string=" 0",
            update_interval=1800,
            foreground=colors[2],
            padding=10,
        ),
        widget.Spacer(length=12),
        widget.CPU(format=" {load_percent}%", foreground=colors[3], padding=10),
        widget.Spacer(length=12),
        widget.Memory(format=" {MemPercent}%", foreground=colors[5], padding=10),
        widget.Spacer(length=12),
        widget.Net(
            format=" {down} ↓↑ {up}",
            foreground=colors[4],
            use_bits=True,
            prefix="M",
            padding=10,
        ),
        widget.Spacer(length=12),
        widget.Clock(format=" %H:%M", foreground=colors[6], padding=10),
        widget.Spacer(length=12),
        widget.Clock(format=" %a %d", foreground=colors[2], padding=10),
        widget.Spacer(length=12),
        widget.Battery(
            battery="BAT0",
            format="{char} {percent:2.0%}",
            full_char="",
            charge_char="",
            discharge_char="",
            empty_char="",
            low_percentage=0.15,
            low_foreground=colors[1],
            foreground=colors[9],
            padding=10,
            font="MesloLGS Nerd Font",
            fontsize=16,
            show_short_text=False,
            update_interval=10,
        ),
        widget.Spacer(length=12),
        widget.QuickExit(default_text="", foreground=colors[1], padding=12),
        widget.Spacer(length=12),
    ]


screens = [
    Screen(
        bottom=bar.Bar(
            create_bar_widgets(),
            36,
            margin=[8, 12, 4, 12],
            background=colors[0],
            opacity=0.95,
        ),
    ),
]

# --- MOUSE CONFIGURATION ---
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# --- OTHER SETTINGS ---
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ]
)


# --- AUTOSTART HOOK ---
@hook.subscribe.startup_once
def autostart():
    subprocess.Popen([os.path.expanduser("~/.config/qtile/autostart")])
