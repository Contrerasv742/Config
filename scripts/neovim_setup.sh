#!/bin/bash
# scripts/neovim_setup.sh - Neovim installation and configuration

log "Setting up Neovim..."

# Create temporary directory for building
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR" || exit 1

# Install build dependencies
log "Installing Neovim build dependencies..."
sudo apt install -y ninja-build gettext cmake make unzip curl

# Clone and build Neovim
log "Cloning Neovim repository..."
git clone https://github.com/neovim/neovim
cd neovim || exit 1
git checkout stable

log "Building Neovim..."
make CMAKE_BUILD_TYPE=Release
sudo make install

# Return to original directory and cleanup
cd "$SCRIPT_DIR" || exit 1
rm -rf "$TEMP_DIR"

# Backup existing Neovim config if it exists
if [ -d "$HOME/.config/nvim" ]; then
    log "Backing up existing Neovim configuration..."
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Copy your existing configuration
log "Copying Neovim configuration..."
NVIM_CONFIG_SRC="${SCRIPT_DIR}/nvim"  # Changed this line to use direct path
if [ -d "$NVIM_CONFIG_SRC" ]; then
    log "Copying configuration from $NVIM_CONFIG_SRC"
    cp -r "$NVIM_CONFIG_SRC" "$HOME/.config/nvim"
else
    error "Neovim configuration source not found at $NVIM_CONFIG_SRC"
    ls -la "${SCRIPT_DIR}"  # Debug line to show directory contents
    exit 1
fi

# Install package manager (lazy.nvim)
log "Installing lazy.nvim package manager..."
LAZY_NVIM_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_NVIM_PATH" ]; then
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
        --branch=stable "$LAZY_NVIM_PATH"
fi

# Install language servers and tools
log "Installing LSP servers and tools..."
npm install -g \
    pyright \
    typescript-language-server \
    bash-language-server \
    vscode-langservers-extracted

# Install additional tools
pip3 install --user pynvim
npm install -g neovim

# Verify Neovim installation
if command -v nvim >/dev/null; then
    log "Running Neovim headless plugin installation..."
    nvim --headless "+Lazy! sync" +qa || {
        warn "Plugin installation completed with some warnings"
    }
    success "Neovim setup completed!"
else
    error "Neovim installation failed"
    exit 1
fi
