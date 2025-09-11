![Logo](png/logo.png)
# My Arch Linux & Hyprland Dotfiles

This repository contains my personal dotfiles for my Arch Linux setup, featuring the Hyprland Wayland compositor. This setup is designed to be both aesthetically pleasing and highly functional, with a focus on keyboard-driven workflows.

## Features

- **Window Manager**: [Hyprland](https://hyprland.org/) - A dynamic tiling Wayland compositor with smooth animations and extensive customization options.
- **Bar**: [Waybar](https://github.com/Alexays/Waybar) - A highly customizable Wayland bar for displaying system information, workspaces, and more.
- **Launcher**: [Rofi](https://github.com/davatorium/rofi) - A versatile application launcher and window switcher.
- **Terminal**: [Alacritty](https://github.com/alacritty/alacritty) - A fast, GPU-accelerated terminal emulator.
- **Shell**: [Fish](https://fishshell.com/) with [Starship](https://starship.rs/) - A modern, user-friendly shell with a powerful and customizable prompt.
- **Text Editors**: [Neovim](https://neovim.io/) and [Vim](https://www.vim.org/) - The classic, powerful text editors, with custom configurations for a better experience.
- **Theming**: Dynamic theming with [Matugen](https://github.com/InioX/matugen), which generates a color palette from the current wallpaper and applies it to various applications.
- **Scripts**: A collection of helper scripts to automate system setup and management.

## Installation

These dotfiles are managed with `stow`. To install them, clone this repository and use `stow` to create the necessary symlinks:

```bash
git clone https://github.com/your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```

## Configuration Details

### Hyprland

The Hyprland configuration is located in `~/.config/hypr/hyprland.conf`. It is modular, with different aspects of the configuration split into separate files in `~/.config/hypr/conf/`.

- `monitors.conf`: Monitor and display settings.
- `enviromentalvars.conf`: Environment variables.
- `settings.conf`: General settings and input configuration.
- `keybinds.conf`: Keyboard shortcuts.
- `startup.conf`: Autostart applications.
- `decorations.conf`: Window decorations and styling.
- `windowrules.conf`: Window rules.
- `snappy-animations.conf`: Animation settings.

### Waybar

The Waybar configuration is in `~/.config/waybar/config.jsonc`, and the styling is in `~/.config/waybar/style.css`. The bar is configured to show:

- Workspaces
- Current window title
- System tray
- Notifications
- Clock
- Network, CPU, memory, and disk usage
- Audio volume
- Battery status
- A lock button

### Rofi

The Rofi configuration is at `~/.config/rofi/config.rasi`. It provides a clean and simple application launcher.

### Alacritty

The Alacritty configuration is at `~/.config/alacritty/alacritty.toml`. It uses the "MesloLGS Nerd Font" and has a transparent background.

### Vim

The Vim configuration is at `~/.vimrc`. It includes a variety of settings for a better Vim experience, such as:

- Sensible defaults
- Custom keybindings for easier navigation and window management
- A custom statusline
- A function to toggle comments

## Scripts

The `~/scripts` directory contains several useful scripts:

- `arch-pkgs`: Installs a predefined set of packages for a new Arch Linux installation.
- `aur-installer`: Installs an AUR helper (yay or paru).
- `black-installer`: Sets up the BlackArch repository.
- `chaotic-aur`: Sets up the Chaotic-AUR repository.
- `firewall`: Configures UFW with sensible defaults.
- `intel-undervolt`: Undervolts Intel CPUs to reduce heat and improve battery life.
- `llms`: Downloads and sets up a local large language model.
- `optimize-network`: Optimizes network settings by changing DNS and disabling Wi-Fi power saving.
- `pacman-conf`: Applies a custom `pacman.conf` with parallel downloads and other tweaks.
- `power`: Sets up TLP for power management.
- `sddm-setup`: Sets up the SDDM display manager with a custom theme.
- `setup-git`: Helps configure Git and SSH for a new machine.
- `tty-setup`: Customizes the TTY with a new font and color scheme.
- `wset` & `wset-backend`: A script to set a wallpaper and apply a new color scheme to the entire system using `matugen`.
- `ani-cli`: A script to watch anime from the command line.

## Theming

This setup uses `matugen` to generate a color scheme from the current wallpaper. The `wset` script automates this process. When you run `wset`, it will:

1.  Prompt you to select a wallpaper from your `~/Wallpapers` directory.
2.  Set the selected image as your wallpaper using `swww`.
3.  Generate a new color scheme with `matugen`.
4.  Reload Hyprland, Waybar, and SwayNC to apply the new theme.

## Keybindings

The main keybindings are defined in `~/.config/hypr/conf/keybinds.conf`. Here are some of the most important ones:

- `Super + Enter`: Open Alacritty
- `Super + Q`: Close the active window
- `Super + D`: Open Rofi
- `Super + [1-9]`: Switch to workspace 1-9
- `Super + Shift + [1-9]`: Move the active window to workspace 1-9
- `Super + H/J/K/L`: Move focus between windows

For a full list of keybindings, please refer to the `keybinds.conf` file.
