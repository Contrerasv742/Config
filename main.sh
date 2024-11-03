#!/bin/bash

# main.sh - Main installation script
set -e  # Exit on error

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Log functions
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Validate directory structure
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NVIM_CONFIG_DIR="$SCRIPT_DIR/nvim"

if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    error "Neovim configuration directory not found at $NVIM_CONFIG_DIR"
    exit 1
fi

if [ ! -f "$NVIM_CONFIG_DIR/init.lua" ]; then
    error "Neovim init.lua not found at $NVIM_CONFIG_DIR/init.lua"
    exit 1
fi

# Create necessary directories
mkdir -p ~/.config
mkdir -p ~/.local/share/nvim
mkdir -p ~/.cache/nvim

# Source the individual setup scripts
log "Starting installation process..."

# Run individual setup scripts
. "$SCRIPT_DIR/scripts/packages.sh"

# Source nvm before continuing
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Continue with other scripts
. "$SCRIPT_DIR/scripts/fonts_setup.sh"
. "$SCRIPT_DIR/scripts/neovim_setup.sh"
. "$SCRIPT_DIR/scripts/terminal_setup.sh"
. "$SCRIPT_DIR/scripts/starship_setup.sh"

success "Development environment setup completed!"
