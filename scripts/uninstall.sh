#!/bin/bash
###############################################################################
# Minty-I3 Uninstallation Script for Linux Mint
###############################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

check_root() {
    if [ "$EUID" -ne 0 ]; then
        print_error "Please run as root (use sudo)"
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

remove_session_entry() {
    print_info "Removing desktop session entry..."
    rm -f /usr/share/xsessions/minty-i3.desktop
}

restore_configs() {
    local USER_HOME
    USER_HOME=$(get_user_home)

    print_info "Restoring original configurations..."

    # Find the most recent backup
    BACKUP_DIR=$(ls -dt "$USER_HOME/.config/minty-i3-backup-"* 2>/dev/null | head -1)

    if [ -n "$BACKUP_DIR" ]; then
        print_info "Restoring from: $BACKUP_DIR"

        [ -d "$BACKUP_DIR/i3" ] && rm -rf "$USER_HOME/.config/i3" && cp -r "$BACKUP_DIR/i3" "$USER_HOME/.config/" 2>/dev/null || true
        [ -f "$BACKUP_DIR/.Xresources" ] && cp "$BACKUP_DIR/.Xresources" "$USER_HOME/" 2>/dev/null || true
        [ -d "$BACKUP_DIR/rofi" ] && rm -rf "$USER_HOME/.config/rofi" && cp -r "$BACKUP_DIR/rofi" "$USER_HOME/.config/" 2>/dev/null || true
        [ -f "$BACKUP_DIR/picom.conf" ] && cp "$BACKUP_DIR/picom.conf" "$USER_HOME/.config/" 2>/dev/null || true
        [ -f "$BACKUP_DIR/dunstrc" ] && cp "$BACKUP_DIR/dunstrc" "$USER_HOME/.config/" 2>/dev/null || true

        print_info "Configurations restored"
    else
        print_warn "No backup found. Removing Minty-I3 configs..."
        rm -rf "$USER_HOME/.config/i3"
        rm -f "$USER_HOME/.Xresources"
        rm -rf "$USER_HOME/.config/rofi"
        rm -f "$USER_HOME/.config/picom.conf"
        rm -f "$USER_HOME/.config/dunstrc"
        rm -f "$USER_HOME/.config/i3status.conf"
    fi
}

ask_remove_packages() {
    print_warn "Do you want to remove i3 and related packages? (y/N)"
    read -r response
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
        print_info "Removing i3 and related packages..."
        apt remove -y \
            i3 \
            i3-wm \
            i3status \
            i3lock \
            i3blocks \
            suckless-tools \
            rofi \
            picom \
            dunst \
            nitrogen \
            feh \
            scrot \
            xsel \
            rxvt-unicode \
            lxappearance \
            arandr \
            blueman \
            network-manager-gnome \
            volumeicon-alsa \
            diodon
    else
        print_info "Keeping packages installed"
    fi
}

main() {
    echo "=========================================="
    echo "  Minty-I3 Uninstallation Script"
    echo "=========================================="
    echo ""
    
    check_root
    remove_session_entry
    restore_configs
    ask_remove_packages
    
    print_info "Minty-I3 uninstalled successfully!"
    echo "You may need to log out and log back in to see changes."
}

main "$@"
