#!/bin/bash
###############################################################################
# Minty-I3 One-Line Installer
# Usage: curl -sSL https://raw.githubusercontent.com/GrangeDevGroup/minty-i3-desktop/main/install.sh | sudo bash
###############################################################################

# Don't exit on error - be bulletproof
set +e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
REPO_URL="https://github.com/GrangeDevGroup/minty-i3-desktop.git"
INSTALL_DIR="/tmp/minty-i3-install"

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
        print_error "This installer needs root privileges."
        print_error "Please run with: curl -sSL ... | sudo bash"
        exit 1
    fi
}

# Check Linux Mint
check_mint() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        if [[ "$ID" == "linuxmint" || "$ID" == "mint" ]]; then
            print_info "Detected Linux Mint $VERSION_ID"
        else
            print_warn "This is designed for Linux Mint, but proceeding anyway..."
        fi
    else
        print_warn "Cannot detect OS version"
    fi
}

# Install dependencies (git)
install_deps() {
    print_step "Installing required dependencies..."
    apt-get update || print_warn "apt update had issues, continuing..."
    apt-get install -y git curl wget || {
        print_warn "Some packages failed to install, trying individually..."
        apt-get install -y git || print_warn "git install failed"
        apt-get install -y curl || print_warn "curl install failed"
        apt-get install -y wget || print_warn "wget install failed"
    }
}

# Download repository
download_repo() {
    print_step "Downloading Minty-I3..."
    
    # Clean up any previous install
    rm -rf "$INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"
    
    # Clone the repository
    if command -v git &> /dev/null; then
        git clone --depth 1 "$REPO_URL" "$INSTALL_DIR" || {
            print_warn "Git clone failed, trying tarball fallback..."
            curl -sL "${REPO_URL%.git}/archive/refs/heads/main.tar.gz" | tar -xz -C "$INSTALL_DIR" --strip-components=1 || {
                print_error "Failed to download repository"
                exit 1
            }
        }
    else
        # Fallback: download as tarball
        print_info "Git not found, downloading archive..."
        curl -sL "${REPO_URL%.git}/archive/refs/heads/main.tar.gz" | tar -xz -C "$INSTALL_DIR" --strip-components=1 || {
            print_error "Failed to download repository"
            exit 1
        }
    fi
    
    print_info "Downloaded to $INSTALL_DIR"
}

# Run the main installer
run_installer() {
    print_step "Running Minty-I3 installer..."
    cd "$INSTALL_DIR"
    
    # Run the main install script
    if [ -f "./scripts/install.sh" ]; then
        bash ./scripts/install.sh
    else
        print_error "Installer not found in downloaded files"
        exit 1
    fi
}

# Cleanup
cleanup() {
    print_step "Cleaning up..."
    rm -rf "$INSTALL_DIR"
}

# Main installation
main() {
    echo "=========================================="
    echo "  Minty-I3 Quick Installer"
    echo "  Linux Mint i3 Desktop Environment"
    echo "=========================================="
    echo ""
    
    check_root
    check_mint
    
    print_info "This will install Minty-I3 on your system."
    print_warn "Make sure you have a backup of your current config!"
    print_info "Starting installation in 3 seconds... (Ctrl+C to cancel)"
    sleep 3
    
    install_deps
    download_repo
    run_installer
    cleanup
    
    echo ""
    echo "=========================================="
    echo "  Installation Complete!"
    echo "=========================================="
    echo ""
    echo "Next steps:"
    echo "1. Reboot your system: sudo reboot"
    echo "2. At login screen, click the session icon (⚙️)"
    echo "3. Select 'Minty-I3' or 'Minty-I3 (Cinnamon Compatible)'"
    echo "4. Log in and enjoy your new desktop!"
    echo ""
    echo "Quick help: Press ⊞+Shift+? for keyboard shortcuts"
    echo ""
}

# Handle errors
trap 'print_error "Installation failed at line $LINENO"' ERR

# Run main function
main "$@"
