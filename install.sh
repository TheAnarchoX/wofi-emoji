#!/usr/bin/env bash
set -euo pipefail

# wofi-emoji installer script
# This script downloads and installs wofi-emoji to ~/.local/bin

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="wofi-emoji"
GITHUB_REPO="TheAnarchoX/wofi-emoji"
# Dynamically determine the default branch of the repository
DEFAULT_BRANCH=$(curl -fsSL "https://api.github.com/repos/${GITHUB_REPO}" | grep '"default_branch":' | cut -d '"' -f4)
DOWNLOAD_URL="https://github.com/${GITHUB_REPO}/raw/${DEFAULT_BRANCH}/${SCRIPT_NAME}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required commands are available
check_dependencies() {
    local missing_deps=()
    
    if ! command -v curl >/dev/null 2>&1; then
        missing_deps+=("curl")
    fi
    
    if ! command -v wofi >/dev/null 2>&1; then
        missing_deps+=("wofi")
    fi
    
    if ! command -v wtype >/dev/null 2>&1; then
        missing_deps+=("wtype")
    fi
    
    if ! command -v wl-copy >/dev/null 2>&1; then
        missing_deps+=("wl-copy")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        print_error "Please install them first and run this script again."
        exit 1
    fi
}

# Create install directory if it doesn't exist
create_install_dir() {
    if [ ! -d "$INSTALL_DIR" ]; then
        print_status "Creating directory: $INSTALL_DIR"
        mkdir -p "$INSTALL_DIR"
    fi
}

# Download and install the script
install_script() {
    local temp_file
    temp_file=$(mktemp)
    
    print_status "Downloading $SCRIPT_NAME from $DOWNLOAD_URL"
    
    if curl -fsSL "$DOWNLOAD_URL" -o "$temp_file"; then
        print_status "Installing $SCRIPT_NAME to $INSTALL_DIR"
        mv "$temp_file" "$INSTALL_DIR/$SCRIPT_NAME"
        chmod +x "$INSTALL_DIR/$SCRIPT_NAME"
        print_status "Successfully installed $SCRIPT_NAME!"
    else
        print_error "Failed to download $SCRIPT_NAME"
        rm -f "$temp_file"
        exit 1
    fi
}

# Check if ~/.local/bin is in PATH
check_path() {
    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        print_warning "$INSTALL_DIR is not in your PATH"
        print_warning "Add the following line to your shell configuration file:"
        print_warning "  export PATH=\"\$HOME/.local/bin:\$PATH\""
        print_warning ""
        print_warning "For bash: ~/.bashrc or ~/.bash_profile"
        print_warning "For zsh: ~/.zshrc"
        print_warning "For fish: ~/.config/fish/config.fish"
    else
        print_status "$INSTALL_DIR is already in your PATH"
    fi
}

# Main installation process
main() {
    print_status "Starting wofi-emoji installation..."
    
    check_dependencies
    create_install_dir
    install_script
    check_path
    
    print_status "Installation complete!"
    print_status "You can now run 'wofi-emoji' from anywhere in your terminal"
    print_status "Or add a keybinding in your window manager configuration"
}

# Run the installer
main "$@"
