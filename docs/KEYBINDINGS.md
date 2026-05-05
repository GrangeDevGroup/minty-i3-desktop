# Minty-I3 Keybindings

Complete list of default keybindings for Minty-I3 (Manjaro Sway Style).

## Modifier Keys

- **Mod** = Super/Windows key (Mod4)
- **Alt** = Alt key (Mod1)

## System

| Keybinding | Action |
|------------|--------|
| Mod+Shift+? | Show shortcuts help |
| Mod+F1 | Show shortcuts help |
| Mod+Shift+e | Exit i3 (with confirmation) |
| Mod+Shift+r | Restart i3 |
| Mod+Shift+c | Reload i3 configuration |
| Mod+Shift+s | Suspend system |
| Mod+Shift+Shift+s | Hibernate system |
| Mod+Shift+l | Lock screen |
| Mod+Shift+Shift+l | Power off |
| Mod+Shift+Shift+r | Reboot |

## Window Management

| Keybinding | Action |
|------------|--------|
| Mod+Return | Open terminal (xfce4-terminal) |
| Mod+Shift+Return | Open drop-down terminal |
| Mod+Shift+q | Close focused window |
| Mod+d | Application launcher (rofi) |
| Mod+Shift+d | Command launcher (rofi) |
| Mod+f | Toggle fullscreen |
| Mod+Shift+Space | Toggle floating |
| Mod+Space | Focus toggle (floating/tiling) |

## Navigation

| Keybinding | Action |
|------------|--------|
| Mod+Left | Focus window left |
| Mod+Down | Focus window down |
| Mod+Up | Focus window up |
| Mod+Right | Focus window right |
| Mod+h | Focus window left (vim-style) |
| Mod+j | Focus window down (vim-style) |
| Mod+k | Focus window up (vim-style) |
| Mod+l | Focus window right (vim-style) |

## Window Movement

| Keybinding | Action |
|------------|--------|
| Mod+Shift+Left | Move window left |
| Mod+Shift+Down | Move window down |
| Mod+Shift+Up | Move window up |
| Mod+Shift+Right | Move window right |
| Mod+Shift+h | Move window left (vim-style) |
| Mod+Shift+j | Move window down (vim-style) |
| Mod+Shift+k | Move window up (vim-style) |
| Mod+Shift+l | Move window right (vim-style) |

## Layout Management

| Keybinding | Action |
|------------|--------|
| Mod+b | Split horizontal |
| Mod+v | Split vertical |
| Mod+s | Stacking layout |
| Mod+w | Tabbed layout |
| Mod+e | Toggle split direction |

## Container Focus

| Keybinding | Action |
|------------|--------|
| Mod+a | Focus parent container |
| Mod+c | Focus child container |

## Workspace Management

| Keybinding | Action |
|------------|--------|
| Mod+1 | Switch to workspace 1 |
| Mod+2 | Switch to workspace 2 |
| Mod+3 | Switch to workspace 3 |
| Mod+4 | Switch to workspace 4 |
| Mod+5 | Switch to workspace 5 |
| Mod+6 | Switch to workspace 6 |
| Mod+7 | Switch to workspace 7 |
| Mod+8 | Switch to workspace 8 |
| Mod+9 | Switch to workspace 9 |
| Mod+0 | Switch to workspace 10 |

## Move to Workspace

| Keybinding | Action |
|------------|--------|
| Mod+Shift+1 | Move to workspace 1 |
| Mod+Shift+2 | Move to workspace 2 |
| Mod+Shift+3 | Move to workspace 3 |
| Mod+Shift+4 | Move to workspace 4 |
| Mod+Shift+5 | Move to workspace 5 |
| Mod+Shift+6 | Move to workspace 6 |
| Mod+Shift+7 | Move to workspace 7 |
| Mod+Shift+8 | Move to workspace 8 |
| Mod+Shift+9 | Move to workspace 9 |
| Mod+Shift+0 | Move to workspace 10 |

## Scratchpad

| Keybinding | Action |
|------------|--------|
| Mod+Shift+- | Move window to scratchpad |
| Mod+- | Show scratchpad |

## Resize Mode

| Keybinding | Action |
|------------|--------|
| Mod+r | Enter resize mode |
| Left | Shrink width |
| Right | Grow width |
| Up | Shrink height |
| Down | Grow height |
| Enter/Escape | Exit resize mode |

## Media Keys

| Keybinding | Action |
|------------|--------|
| XF86AudioRaiseVolume | Volume up 5% |
| XF86AudioLowerVolume | Volume down 5% |
| XF86AudioMute | Toggle mute |
| XF86AudioPlay | Play/Pause media |
| XF86AudioNext | Next track |
| XF86AudioPrev | Previous track |
| XF86MonBrightnessUp | Brightness up 5% |
| XF86MonBrightnessDown | Brightness down 5% |

## Screenshots

| Keybinding | Action |
|------------|--------|
| Print | Full screenshot to ~/Screenshots |
| Mod+Print | Window screenshot |
| Mod+Shift+Print | Select area screenshot |

## Default Application Assignments

Applications are automatically assigned to specific workspaces:

- **Workspace 1**: Web browsers (Firefox, Chromium)
- **Workspace 2**: Email (Thunderbird, Evolution)
- **Workspace 3**: Code editors (VSCode, VSCodium)
- **Workspace 4**: Terminals
- **Workspace 5**: File managers (Nautilus, Nemo)
- **Workspace 6**: Music (Spotify)
- **Workspace 7**: Chat (Discord)
- **Workspace 8**: Gaming (Steam)

## Customizing Keybindings

To customize keybindings, edit `~/.config/i3/config`:

```bash
# Example: Add custom keybinding
bindsym $mod+Ctrl+Shift+e exec poweroff
```

After editing, reload i3:
```bash
Mod+Shift+c
```

Or use command line:
```bash
i3-msg reload
```
