#!/bin/bash

# main.sh - Main installation script
set -e  # Exit on error

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Log function
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Create necessary directories
mkdir -p ~/.config/nvim
mkdir -p ~/.scripts

# Source the individual setup scripts
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run individual setup scripts
. "$SCRIPT_DIR/scripts/packages.sh"
. "$SCRIPT_DIR/scripts/fonts_setup.sh"
. "$SCRIPT_DIR/scripts/neovim_setup.sh"
. "$SCRIPT_DIR/scripts/terminal_setup.sh"
. "$SCRIPT_DIR/scripts/starship_setup.sh"

success "Development environment setup completed!"
