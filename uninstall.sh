#!/bin/bash
###############################################################################
# Minty-I3 Uninstall Script
# Usage: curl -sSL https://raw.githubusercontent.com/GrangeDevGroup/minty-i3-desktop/main/uninstall.sh | sudo bash
###############################################################################

# Don't exit on error - be bulletproof
set +e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        print_error "This uninstaller needs root privileges."
        print_error "Please run with: curl -sSL ... | sudo bash"
        exit 1
    fi
}

get_user_home() {
    if [ -n "$SUDO_USER" ]; then
        getent passwd "$SUDO_USER" | cut -d: -f6
    else
        echo "$HOME"
    fi
}

# Remove configs
remove_configs() {
    local USER_HOME
    USER_HOME=$(get_user_home)

    print_step "Removing Minty-I3 configurations..."

    # Backup current configs first
    if [ -d "$USER_HOME/.config/i3" ]; then
        BACKUP_DIR="$USER_HOME/.config/minty-i3-backup-$(date +%Y%m%d-%H%M%S)"
        print_info "Backing up current config to $BACKUP_DIR"
        cp -r "$USER_HOME/.config/i3" "$BACKUP_DIR/" 2>/dev/null || true
    fi

    # Remove config files
    rm -rf "$USER_HOME/.config/i3"
    rm -f "$USER_HOME/.Xresources"
    rm -f "$USER_HOME/.config/i3status.conf"
    rm -rf "$USER_HOME/.config/rofi"
    rm -f "$USER_HOME/.config/picom.conf"
    rm -f "$USER_HOME/.config/dunstrc"

    print_info "Configuration files removed"
}

# Remove session entries
remove_sessions() {
    print_step "Removing desktop session entries..."
    
    rm -f /usr/share/xsessions/minty-i3.desktop
    rm -f /usr/share/xsessions/minty-i3-cinnamon.desktop
    
    print_info "Session entries removed"
}

# Optional: Remove packages
remove_packages() {
    print_warn "Do you want to remove installed packages? (i3, rofi, picom, etc.)"
    print_warn "This is optional and may affect other desktop environments."
    print_info "Press Ctrl+C to skip package removal, or wait 5 seconds to continue..."
    
    sleep 5
    
    print_step "Removing packages..."
    
    # List of packages to remove
    PACKAGES="i3 i3-wm i3status i3lock rofi picom dunst nitrogen feh scrot xsel xfce4-terminal lxappearance arandr blueman network-manager-gnome volumeicon-alsa diodon yad zenity playerctl brightnessctl pulseaudio-utils xdotool x11-xserver-utils cinnamon-session policykit-1-gnome"
    
    for pkg in $PACKAGES; do
        if dpkg -l | grep -q "^ii  $pkg"; then
            print_info "Removing $pkg..."
            apt remove -y "$pkg" 2>/dev/null || print_warn "Could not remove $pkg"
        fi
    done
    
    print_info "Package removal complete"
}

# Restore original configs if backup exists
restore_original() {
    local USER_HOME
    USER_HOME=$(get_user_home)

    print_step "Checking for original backups..."

    BACKUP_COUNT=$(ls -d "$USER_HOME/.config/minty-i3-backup-"* 2>/dev/null | wc -l)

    if [ "$BACKUP_COUNT" -gt 0 ]; then
        print_info "Found $BACKUP_COUNT backup directories"
        print_info "Your original configs are preserved in $USER_HOME/.config/minty-i3-backup-*"
    fi
}

# Main uninstall
main() {
    echo "=========================================="
    echo "  Minty-I3 Uninstall Script"
    echo "  Linux Mint i3 Desktop Environment"
    echo "=========================================="
    echo ""
    
    check_root
    
    print_warn "This will remove Minty-I3 configuration files"
    print_info "Starting uninstall in 3 seconds... (Ctrl+C to cancel)"
    sleep 3
    
    remove_configs
    remove_sessions
    restore_original
    
    # Ask about package removal (optional)
    print_info ""
    print_info "Configuration files have been removed."
    print_info "Packages (i3, rofi, etc.) are still installed."
    print_info "To remove packages, run: sudo apt remove i3 rofi picom..."
    
    echo ""
    echo "=========================================="
    echo "  Uninstall Complete!"
    echo "=========================================="
    echo ""
    echo "Minty-I3 has been removed."
    echo "Log out and select a different desktop environment."
    echo ""
}

# Handle errors
trap 'print_error "Uninstall failed at line $LINENO"' ERR

# Run main
main "$@"
