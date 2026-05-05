<div align="center">
  <img src="logo.png" alt="Minty-I3 Logo" width="200">
  <h1>Minty-I3</h1>
  <p>Linux Mint Dark Theme i3 Window Manager</p>
  
  ![Linux Mint](https://img.shields.io/badge/Linux%20Mint-20%2F21%2F22-green?logo=linux-mint)
  ![i3wm](https://img.shields.io/badge/i3wm-tiling-blue)
  ![License](https://img.shields.io/badge/license-MIT-blue)
</div>

**One-line installation:**
```bash
curl -sSL https://raw.githubusercontent.com/GrangeDevGroup/minty-i3-desktop/main/install.sh | sudo bash
```

<!-- Add screenshot here: ![Minty-I3 Screenshot](screenshot.png) -->

## Features

- Linux Mint Dark Theme colors (green accent #87cf3e)
- i3 tiling window manager
- Manjaro Sway-style keyboard shortcuts
- **Left-side shortcuts display** (press Super+Shift+? or Super+F1)
- Windows logo (⊞) instead of Manjaro logo
- Easy installation - works alongside or replaces Cinnamon
- Complete desktop setup with notifications, compositor, and applets

## Requirements

- Linux Mint 20.x, 21.x, or 22.x (Cinnamon, MATE, or Xfce editions)
- sudo/root access for installation
- Internet connection to download packages

## Installation

### Method 1: One-Line Install (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/GrangeDevGroup/minty-i3-desktop/main/install.sh | sudo bash
```

Then **reboot** and select "Minty-I3" from the login screen.

### Method 2: Clone and Install

```bash
git clone https://github.com/GrangeDevGroup/minty-i3-desktop.git
cd Minty-I3
sudo ./scripts/install.sh
```

Then **reboot** and select "Minty-I3" from the login screen.

## Manual Installation Steps

If you prefer to install manually:

### 1. Install i3 and dependencies

```bash
sudo apt update
sudo apt install -y i3 i3-wm i3status i3lock i3blocks suckless-tools \
    rofi picom dunst nitrogen feh scrot xsel xfce4-terminal \
    fonts-noto lxappearance arandr blueman network-manager-gnome \
    volumeicon-alsa clipit yad zenity playerctl brightnessctl \
    pulseaudio-utils xdotool
```

### 2. Copy configuration files

```bash
mkdir -p ~/.config/i3 ~/.config/rofi ~/Screenshots

cp config/i3/config ~/.config/i3/
cp config/i3/Xresources ~/.Xresources
cp config/i3/i3status.conf ~/.config/i3status.conf
cp config/rofi/windows10.rasi ~/.config/rofi/
cp config/picom.conf ~/.config/picom.conf
cp config/dunstrc ~/.config/dunstrc
cp scripts/show-shortcuts.sh ~/.config/i3/
chmod +x ~/.config/i3/show-shortcuts.sh
```

### 3. Apply settings

```bash
xrdb -merge ~/.Xresources
```

### 4. Reboot and select Minty-I3

Log out and select "Minty-I3" from the login screen session menu.

## Keybindings

Minty-I3 uses Manjaro Sway-style keybindings with Windows logo (⊞):

| Keybinding | Action |
|------------|--------|
| `⊞+Shift+?` or `⊞+F1` | Show shortcuts help (left side panel) |
| `⊞+Return` | Open terminal |
| `⊞+d` | Application launcher |
| `⊞+Shift+q` | Close window |
| `⊞+1-0` | Switch workspaces |
| `⊞+f` | Fullscreen |
| `⊞+Shift+e` | Exit i3 |
| `⊞+h/j/k/l` | Vim-style navigation |
| Media keys | Volume, brightness, playback |

**Note:** ⊞ = Windows/Super key

See [docs/KEYBINDINGS.md](docs/KEYBINDINGS.md) for complete list.

## Shortcuts Panel

Press `Super+Shift+?` or `Super+F1` to display the keyboard shortcuts panel on the **left side** of the screen, similar to Manjaro Sway. The panel features:

- Windows logo (⊞) instead of Manjaro logo
- Linux Mint green accent colors
- Organized by category (System, Windows, Navigation, Layout, etc.)
- Auto-closes after 30 seconds or click to close

## Session Types

Minty-I3 provides **two session options** at the login screen:

### 1. Minty-I3 (Pure i3)
- Standalone i3 window manager
- Minimal resource usage
- Maximum performance
- Best for: Power users, developers, minimalists

### 2. Minty-I3 (Cinnamon Compatible)
- i3 with Cinnamon's backend services
- Retains Linux Mint's system integration
- Cinnamon settings management (display, keyboard, etc.)
- Best for: Users wanting Mint's system tools with tiling WM

**To switch sessions:** Log out → Click session icon (⚙️) → Select desired session → Log in

## Multi-Monitor Support

Minty-I3 includes **workspace autonomy** per monitor:

| Keybinding | Action |
|------------|--------|
| `⊞+Shift+>` | Move workspace to monitor on right |
| `⊞+Shift+<` | Move workspace to monitor on left |
| `⊞+comma` | Focus monitor on left |
| `⊞+period` | Focus monitor on right |

**Configure monitor layout:**
```bash
arandr  # Graphical monitor configuration tool
```

Workspaces are automatically bound to monitors. You can customize this in `~/.config/i3/config`:
```bash
# Example: Bind workspaces to specific outputs
workspace $ws1 output HDMI-1
workspace $ws2 output DP-1
```

## Tech Stack

Core components that make Minty-I3 work:

| Component | Purpose |
|-----------|---------|
| **i3-wm** | Tiling window manager engine |
| **Rofi** | Application launcher |
| **Picom** | Compositor (transparency, effects) |
| **i3status** | Status bar |
| **Dunst** | Notification daemon |
| **Nitrogen** | Wallpaper manager |
| **Xresources** | Color/font theming |
| **Cinnamon-session** | Optional Cinnamon backend |

## Config Files

| File | Purpose |
|------|---------|
| `~/.config/i3/config` | Main i3 configuration |
| `~/.config/i3/autostart.sh` | Startup applications script |
| `~/.Xresources` | Colors and fonts |
| `~/.config/rofi/windows10.rasi` | Launcher theme |
| `~/.config/picom.conf` | Compositor settings |
| `~/.config/dunstrc` | Notification settings |
| `~/.config/i3/i3status.conf` | Status bar configuration |

## Application Workspace Assignments

Apps automatically open in designated workspaces:

| Workspace | Applications |
|-----------|--------------|
| 1 | Firefox, Chromium |
| 2 | Thunderbird, Evolution |
| 3 | VSCode, VSCodium |
| 4 | Terminal |
| 5 | Thunar, Nemo (File Manager) |
| 6 | Spotify |
| 7 | Discord |
| 8 | Steam |

Customize in `~/.config/i3/config`:
```bash
assign [class="Firefox"] $ws1
assign [class="Code"] $ws3
```

## Colors

Linux Mint Dark Theme:
- **Background:** #1a1a1a
- **Accent (Mint Green):** #87cf3e
- **Border:** #2d2d2d
- **Urgent (Red):** #e74c3c
- **Text:** #ffffff

## Troubleshooting

### Session not showing in login screen
```bash
sudo systemctl restart lightdm
```

### Multi-monitor issues
```bash
arandr  # Configure monitor layout
# Then save the layout and add to autostart.sh
```

### Cinnamon services not working (Cinnamon Compatible session)
Ensure `cinnamon-session` package is installed:
```bash
sudo apt install cinnamon-session
```

### No notifications showing
Check if dunst is running:
```bash
ps aux | grep dunst
# If not running, start manually:
dunst -config ~/.config/dunstrc &
```

## Uninstall

```bash
sudo ./scripts/uninstall.sh
```

## License

MIT
