# Minty-I3 Customization Guide

How to customize your Minty-I3 installation.

## Changing Colors

Edit `~/.Xresources` to customize the color scheme:

```bash
# Change accent color
#define WIN10_ACCENT_BLUE  #ff00ff

# Change background
*.background: WIN10_DARK_GRAY
```

After editing, reload:
```bash
xrdb -merge ~/.Xresources
i3-msg reload
```

## Changing Fonts

Edit `~/.Xresources`:

```bash
wm.font: "Your Font 12"
URxvt*font: xft:Your Font:size=12
```

## Changing Wallpaper

Using nitrogen (GUI):
```bash
nitrogen
```

Or set in `~/.config/i3/config`:
```bash
exec --no-startup-id nitrogen --set-scaled /path/to/image.jpg
```

## Adding Startup Applications

Edit `~/.config/i3/config` and add to the startup section:

```bash
exec --no-startup-id your-application
```

## Customizing Rofi Theme

Edit `~/.config/rofi/windows10.rasi` to change the launcher appearance.

## Adding New Keybindings

Edit `~/.config/i3/config`:

```bash
# Example: Open file manager
bindsym $mod+e exec nemo

# Example: Lock screen
bindsym $mod+Escape exec i3lock
```

## Workspace Rules

Assign applications to specific workspaces in `~/.config/i3/config`:

```bash
assign [class="YourApp"] → $ws1
```

Find window class with:
```bash
xprop | grep WM_CLASS
```

## Floating Windows

Add floating rules in `~/.config/i3/config`:

```bash
for_window [class="YourApp"] floating enable
```

## Gaps and Borders

Adjust in `~/.config/i3/config`:

```bash
gaps inner 10
gaps outer 5
default_border pixel 3
```

## Picom Effects

Edit `~/.config/picom.conf` for transparency and blur effects.

## Terminal Configuration

For URxvt, edit `~/.Xresources`:

```bash
URxvt*scrollBar: true
URxvt*transparent: true
URxvt*shading: 30
```

## Status Bar

Edit `~/.config/i3status.conf` to customize the status bar.

For more advanced bars, consider:
- i3blocks
- polybar
