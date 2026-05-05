#!/bin/bash
###############################################################################
# Minty-I3 Installation Verification Script
# Checks if all configs are properly installed
###############################################################################

echo "=========================================="
echo "  Minty-I3 Installation Verification"
echo "=========================================="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $2 found"
        return 0
    else
        echo -e "${RED}✗${NC} $2 NOT FOUND"
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $2 found"
        return 0
    else
        echo -e "${RED}✗${NC} $2 NOT FOUND"
        return 1
    fi
}

ERRORS=0

echo "Checking configuration files..."
check_file "$HOME/.config/i3/config" "i3 config" || ((ERRORS++))
check_file "$HOME/.Xresources" "Xresources" || ((ERRORS++))
check_file "$HOME/.config/i3status.conf" "i3status config" || ((ERRORS++))
check_file "$HOME/.config/rofi/windows10.rasi" "Rofi theme" || ((ERRORS++))
check_file "$HOME/.config/picom.conf" "Picom config" || ((ERRORS++))
check_file "$HOME/.config/dunstrc" "Dunst config" || ((ERRORS++))
check_file "$HOME/.config/i3/autostart.sh" "Autostart script" || ((ERRORS++))
check_file "$HOME/.config/i3/show-shortcuts.sh" "Shortcuts script" || ((ERRORS++))

echo ""
echo "Checking theme colors in i3 config..."
if grep -q "#87cf3e" "$HOME/.config/i3/config" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Mint green accent color (#87cf3e) found"
else
    echo -e "${RED}✗${NC} Mint green accent color NOT found"
    ((ERRORS++))
fi

if grep -q "#1a1a1a" "$HOME/.config/i3/config" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Dark background color (#1a1a1a) found"
else
    echo -e "${RED}✗${NC} Dark background color NOT found"
    ((ERRORS++))
fi

echo ""
echo "Checking if i3 is running..."
if pgrep -x "i3" > /dev/null; then
    echo -e "${GREEN}✓${NC} i3 is running"
else
    echo -e "${YELLOW}!${NC} i3 is NOT running (you may need to log out and back in)"
fi

echo ""
echo "=========================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}All checks passed!${NC}"
    echo "Your Minty-I3 theme is properly installed."
    echo ""
    echo "Next steps:"
    echo "1. Log out of your current session"
    echo "2. Select 'Minty-I3' from the login screen"
    echo "3. Log back in"
    exit 0
else
    echo -e "${RED}Found $ERRORS missing files/configs${NC}"
    echo "Please run the installer again:"
    echo "  curl -sSL https://raw.githubusercontent.com/GrangeDevGroup/minty-i3-desktop/main/install.sh | sudo bash"
    exit 1
fi
