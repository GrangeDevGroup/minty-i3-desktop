#!/bin/bash
###############################################################################
# Minty-I3 Installation Script for Linux Mint
# Linux Mint Dark Theme i3 Window Manager Setup
# 
# This script installs Minty-I3, a specialized desktop environment that merges
# Cinnamon's stable backend with the i3 tiling window manager.
#
# Features:
# - Tiling window management with i3-wm
# - Cinnamon-Flashback session support (optional)
# - Multi-monitor workspace autonomy
# - Linux Mint services integration
# - Vim-style navigation and tiling controls
###############################################################################

# Don't exit on error - be bulletproof
set +e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then 
        print_error "Please run as root (use sudo)"
        exit 1
    fi
}

# Get the actual user's home directory (not root's)
get_user_home() {
    if [ -n "$SUDO_USER" ]; then
        # Get home directory of the user who ran sudo
        REAL_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
        echo "$REAL_HOME"
    else
        echo "$HOME"
    fi
}

# Get the actual user name
get_user_name() {
    if [ -n "$SUDO_USER" ]; then
        echo "$SUDO_USER"
    else
        echo "$USER"
    fi
}

# Check Linux Mint version
check_mint() {
    if [ ! -f /etc/os-release ]; then
        print_error "Cannot detect OS"
        exit 1
    fi
    
    source /etc/os-release
    if [[ "$ID" != "linuxmint" && "$ID" != "mint" ]]; then
        print_warn "This script is designed for Linux Mint. Proceeding anyway..."
    else
        print_info "Detected Linux Mint $VERSION_ID"
    fi
}

# Update system
update_system() {
    print_info "Updating system packages..."
    apt update
    apt upgrade -y
}

# Install i3 and dependencies - bulletproof version
install_i3() {
    print_info "Installing i3 window manager and dependencies..."
    
    # Essential packages (must have)
    local essential="i3 i3-wm i3status i3lock rofi picom dunst nitrogen feh scrot xsel xfce4-terminal lxappearance arandr blueman network-manager-gnome volumeicon-alsa diodon yad zenity playerctl brightnessctl pulseaudio-utils xdotool x11-xserver-utils cinnamon-session policykit-1-gnome"
    
    # Optional packages (nice to have, skip if not found)
    local optional="i3blocks suckless-tools rxvt-unicode fonts-noto fonts-firacode"
    
    print_info "Installing essential packages..."
    for pkg in $essential; do
        if apt-cache show "$pkg" > /dev/null 2>&1; then
            apt install -y "$pkg" || print_warn "Failed to install $pkg, continuing..."
        else
            print_warn "Package $pkg not found in repository, skipping..."
        fi
    done
    
    print_info "Installing optional packages..."
    for pkg in $optional; do
        if apt-cache show "$pkg" > /dev/null 2>&1; then
            apt install -y "$pkg" 2>/dev/null || print_warn "Optional package $pkg not installed"
        fi
    done
}

# Install additional useful packages - bulletproof
install_extra() {
    print_info "Installing additional useful packages..."
    local extra="vim git curl wget htop neofetch pavucontrol thunar thunar-archive-plugin xarchiver"
    
    for pkg in $extra; do
        if apt-cache show "$pkg" > /dev/null 2>&1; then
            apt install -y "$pkg" 2>/dev/null || print_warn "Could not install $pkg"
        fi
    done
}

# Create backup of existing configs
backup_configs() {
    local USER_HOME=$(get_user_home)
    local USER_NAME=$(get_user_name)
    
    print_info "Backing up existing configurations for user: $USER_NAME"
    BACKUP_DIR="$USER_HOME/.config/minty-i3-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    [ -d "$USER_HOME/.config/i3" ] && cp -r "$USER_HOME/.config/i3" "$BACKUP_DIR/" 2>/dev/null || true
    [ -f "$USER_HOME/.Xresources" ] && cp "$USER_HOME/.Xresources" "$BACKUP_DIR/" 2>/dev/null || true
    [ -d "$USER_HOME/.config/rofi" ] && cp -r "$USER_HOME/.config/rofi" "$BACKUP_DIR/" 2>/dev/null || true
    [ -f "$USER_HOME/.config/picom.conf" ] && cp "$USER_HOME/.config/picom.conf" "$BACKUP_DIR/" 2>/dev/null || true
    [ -f "$USER_HOME/.config/dunstrc" ] && cp "$USER_HOME/.config/dunstrc" "$BACKUP_DIR/" 2>/dev/null || true
    
    print_info "Backup created at: $BACKUP_DIR"
}

# Install Minty-I3 configurations - bulletproof version
install_configs() {
    local USER_HOME=$(get_user_home)
    local USER_NAME=$(get_user_name)
    
    print_info "Installing Minty-I3 configurations for user: $USER_NAME"
    print_info "Target directory: $USER_HOME"
    
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
    
    print_info "Source directory: $PROJECT_ROOT"
    
    # Verify project root exists
    if [ ! -d "$PROJECT_ROOT/config" ]; then
        print_error "Cannot find config directory at $PROJECT_ROOT/config"
        print_error "Installation failed - config files not found"
        exit 1
    fi
    
    # Create config directories
    mkdir -p "$USER_HOME/.config/i3"
    mkdir -p "$USER_HOME/.config/rofi"
    mkdir -p "$USER_HOME/Screenshots"
    
    # Remove old configs to ensure fresh install (force update)
    print_info "Removing old configurations..."
    rm -f "$USER_HOME/.config/i3/config"
    rm -f "$USER_HOME/.Xresources"
    rm -f "$USER_HOME/.config/i3status.conf"
    rm -f "$USER_HOME/.config/rofi/windows10.rasi"
    rm -f "$USER_HOME/.config/picom.conf"
    rm -f "$USER_HOME/.config/dunstrc"
    rm -f "$USER_HOME/.config/i3/show-shortcuts.sh"
    
    # Copy configuration files with force flag
    print_info "Copying i3 config..."
    cp -f "$PROJECT_ROOT/config/i3/config" "$USER_HOME/.config/i3/config" || print_error "Failed to copy i3 config"
    
    print_info "Copying Xresources..."
    cp -f "$PROJECT_ROOT/config/i3/Xresources" "$USER_HOME/.Xresources" || print_error "Failed to copy Xresources"
    
    print_info "Copying i3status config..."
    cp -f "$PROJECT_ROOT/config/i3/i3status.conf" "$USER_HOME/.config/i3status.conf" || print_warn "Failed to copy i3status.conf"
    
    print_info "Copying rofi theme..."
    cp -f "$PROJECT_ROOT/config/rofi/windows10.rasi" "$USER_HOME/.config/rofi/windows10.rasi" || print_warn "Failed to copy rofi theme"
    
    print_info "Copying picom config..."
    cp -f "$PROJECT_ROOT/config/picom.conf" "$USER_HOME/.config/picom.conf" || print_warn "Failed to copy picom.conf"
    
    print_info "Copying dunst config..."
    cp -f "$PROJECT_ROOT/config/dunstrc" "$USER_HOME/.config/dunstrc" || print_warn "Failed to copy dunstrc"
    
    # Copy shortcuts script
    print_info "Copying shortcuts script..."
    if [ -f "$PROJECT_ROOT/scripts/show-shortcuts.sh" ]; then
        cp -f "$PROJECT_ROOT/scripts/show-shortcuts.sh" "$USER_HOME/.config/i3/show-shortcuts.sh"
        chmod +x "$USER_HOME/.config/i3/show-shortcuts.sh"
    else
        print_warn "show-shortcuts.sh not found"
    fi
    
    # Update i3 config with correct shortcuts path
    sed -i "s|/home/d/CascadeProjects/Minty-I3/scripts/show-shortcuts.sh|$USER_HOME/.config/i3/show-shortcuts.sh|g" "$USER_HOME/.config/i3/config" 2>/dev/null || true
    
    # Set ownership to the user (not root)
    if [ -n "$SUDO_USER" ]; then
        chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/i3" 2>/dev/null || true
        chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.Xresources" 2>/dev/null || true
        chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/rofi" 2>/dev/null || true
        chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/picom.conf" 2>/dev/null || true
        chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/dunstrc" 2>/dev/null || true
        chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/i3status.conf" 2>/dev/null || true
    fi
    
    # Set permissions
    chmod +x "$USER_HOME/.config/i3/config"
    
    print_info "Configurations installed successfully"
    
    # Verify installation
    if [ -f "$USER_HOME/.config/i3/config" ]; then
        print_info "i3 config verified at $USER_HOME/.config/i3/config"
    else
        print_error "i3 config NOT found - installation failed"
    fi
}

# Apply Xresources - force reload
apply_xresources() {
    local USER_HOME=$(get_user_home)
    local USER_NAME=$(get_user_name)
    
    print_info "Applying Xresources for user: $USER_NAME"
    # Clear and reload Xresources
    xrdb -remove 2>/dev/null || true
    
    # Run as the actual user, not root
    if [ -n "$SUDO_USER" ]; then
        su - "$SUDO_USER" -c "xrdb -merge $USER_HOME/.Xresources" 2>/dev/null || xrdb -merge "$USER_HOME/.Xresources"
    else
        xrdb -merge "$USER_HOME/.Xresources"
    fi
    
    print_info "Xresources applied"
}

# Create autostart script
create_autostart() {
    local USER_HOME=$(get_user_home)
    local USER_NAME=$(get_user_name)
    
    print_info "Creating autostart script for user: $USER_NAME"
    
    cat > "$USER_HOME/.config/i3/autostart.sh" << 'EOF'
#!/bin/bash
# Minty-I3 Autostart Script
# This script runs automatically when i3 starts

# Load Xresources for colors and fonts
xrdb -merge ~/.Xresources

# Wait a moment for X to fully initialize
sleep 1

# Detect and setup multi-monitor configuration
if command -v xrandr &> /dev/null; then
    # Get list of connected monitors
    MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)
    MONITOR_COUNT=$(echo "$MONITORS" | wc -l)
    
    if [ "$MONITOR_COUNT" -gt 1 ]; then
        echo "Detected $MONITOR_COUNT monitors"
        # Auto-arrange monitors horizontally if more than one
        # Primary monitor stays as is, others arranged to the right
        PRIMARY=$(echo "$MONITORS" | head -1)
        OTHERS=$(echo "$MONITORS" | tail -n +2)
        
        # You can customize this or remove for manual xrandr configuration
        # notify-send "Minty-I3" "Multiple monitors detected. Configure with arandr."
    fi
fi

# Set wallpaper with nitrogen
if command -v nitrogen &> /dev/null; then
    nitrogen --restore &
fi

# Start picom compositor for transparency and effects
if command -v picom &> /dev/null; then
    picom --config ~/.config/picom.conf &
fi

# Start dunst notification daemon
if command -v dunst &> /dev/null; then
    dunst -config ~/.config/dunstrc &
fi

# Cinnamon Settings Daemon (if using Cinnamon-Flashback session)
# Uncomment these lines if you want Cinnamon's settings management
# if command -v cinnamon-settings-daemon &> /dev/null; then
#     cinnamon-settings-daemon &
# fi

# Start network manager applet
if command -v nm-applet &> /dev/null; then
    nm-applet &
fi

# Start bluetooth applet
if command -v blueman-applet &> /dev/null; then
    blueman-applet &
fi

# Start clipboard manager
if command -v diodon &> /dev/null; then
    diodon &
fi

# Start volume icon
if command -v volumeicon &> /dev/null; then
    volumeicon &
fi

# Start polkit authentication agent (required for some system operations)
if command -v /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &> /dev/null; then
    /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
fi

# Show welcome message with shortcuts hint
sleep 2 && notify-send "Minty-I3 Ready" "Press ⊞+Shift+? or ⊞+F1 for keyboard shortcuts" --expire-time=5000 &
EOF
    
    chmod +x "$USER_HOME/.config/i3/autostart.sh"
    
    # Set ownership to the user
    if [ -n "$SUDO_USER" ]; then
        chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/i3/autostart.sh" 2>/dev/null || true
    fi
}

# Create desktop session entry
create_session_entry() {
    print_info "Creating desktop session entry..."
    
    # Create standard i3 session entry
    cat > /usr/share/xsessions/minty-i3.desktop << EOF
[Desktop Entry]
Name=Minty-I3
Comment=Linux Mint i3 Window Manager - Mint Dark Theme
Exec=/usr/bin/i3
TryExec=/usr/bin/i3
Type=Application
X-LightDM-DesktopName=minty-i3
Keywords=tiling;window;manager;wm;i3;
EOF

    # Create Cinnamon-Flashback session for better Mint integration
    cat > /usr/share/xsessions/minty-i3-cinnamon.desktop << EOF
[Desktop Entry]
Name=Minty-I3 (Cinnamon Compatible)
Comment=Linux Mint i3 with Cinnamon services
Exec=/usr/bin/cinnamon-session --session i3
TryExec=/usr/bin/i3
Type=Application
X-LightDM-DesktopName=minty-i3-cinnamon
Keywords=tiling;window;manager;wm;i3;cinnamon;
EOF
    
    print_info "Session entries created."
    print_info "Select 'Minty-I3' for pure i3 or 'Minty-I3 (Cinnamon Compatible)' for Cinnamon backend."
}

# Print completion message
print_completion() {
    print_info "Minty-I3 installation completed successfully!"
    echo ""
    echo "=========================================="
    echo "  Installation Complete!"
    echo "=========================================="
    echo ""
    echo "Session Options:"
    echo "  - 'Minty-I3' - Pure i3 tiling window manager"
    echo "  - 'Minty-I3 (Cinnamon Compatible)' - i3 with Cinnamon backend"
    echo ""
    echo "Next steps:"
    echo "1. Log out of your current session"
    echo "2. At the login screen, click the session icon (⚙️)"
    echo "3. Select 'Minty-I3' or 'Minty-I3 (Cinnamon Compatible)'"
    echo "4. Log in and enjoy!"
    echo ""
    echo "Essential Keybindings:"
    echo "  ⊞+Enter: Open terminal"
    echo "  ⊞+d: Application launcher (rofi)"
    echo "  ⊞+Shift+?: Show keyboard shortcuts help"
    echo "  ⊞+Shift+e: Exit i3"
    echo "  ⊞+1-0: Switch workspaces"
    echo "  ⊞+h/j/k/l: Vim-style navigation"
    echo ""
    echo "Multi-Monitor:"
    echo "  ⊞+Shift+>/<: Move workspace to other monitor"
    echo "  ⊞+comma/period: Focus other monitor"
    echo ""
    echo "Run 'arandr' to configure monitor layout"
    echo ""
    echo "Documentation: docs/KEYBINDINGS.md, docs/CUSTOMIZATION.md"
}

# Main installation
main() {
    echo "=========================================="
    echo "  Minty-I3 Installation Script"
    echo "  Linux Mint Dark Theme i3 Desktop"
    echo "=========================================="
    echo ""
    echo "This will install Minty-I3, a tiling window"
    echo "manager desktop with Cinnamon integration."
    echo ""
    
    check_root
    check_mint
    update_system
    install_i3
    install_extra
    backup_configs
    install_configs
    apply_xresources
    create_autostart
    create_session_entry
    print_completion
    
    # Restart i3 if running to apply new config immediately
    if pgrep -x "i3" > /dev/null; then
        print_info "i3 is running. Restarting to apply new config..."
        print_info "Press Mod+Shift+r to restart i3 manually, or log out and back in."
        # Try to reload i3 config
        su - "$SUDO_USER" -c "i3-msg reload" 2>/dev/null || true
        su - "$SUDO_USER" -c "i3-msg restart" 2>/dev/null || true
    fi
}

# Run main function
main "$@"
