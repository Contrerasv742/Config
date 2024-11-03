#!/bin/bash
# scripts/neovim_setup.sh - Neovim installation and configuration

log "Setting up Neovim..."

# Install latest Neovim from source
sudo apt install -y ninja-build gettext cmake make unzip curl

# Clone Neovim
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ..
rm -rf neovim

# Install additional dependencies for your specific plugins
log "Installing plugin dependencies..."
sudo apt install -y \
    ripgrep \
    fd-find \
    python3-pip \
    nodejs \
    npm \
    cargo \
    luarocks \
    xclip

# Install Python dependencies
pip3 install --user pynvim neovim

# Install Node.js dependencies
sudo npm install -g \
    neovim \
    pyright \
    typescript-language-server \
    bash-language-server \
    vscode-langservers-extracted \
    @tailwindcss/language-server \
    swagger-cli

# Backup existing config if it exists
if [ -d ~/.config/nvim ]; then
    log "Backing up existing Neovim configuration..."
    mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
fi

# Copy your configuration
log "Copying Neovim configuration..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp -r "${SCRIPT_DIR}/../nvim" ~/.config/nvim

# Install lazy.nvim
log "Installing lazy.nvim package manager..."
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
  --branch=stable ~/.local/share/nvim/lazy/lazy.nvim

# Install null-ls dependencies
cargo install stylua
pip3 install --user black flake8 mypy ruff

# Additional LSP servers based on your lsp-config.lua
sudo npm install -g \
    dockerfile-language-server-nodejs \
    yaml-language-server

# Launch Neovim to trigger plugin installation
log "Installing plugins..."
nvim --headless "+Lazy! sync" +qa

success "Neovim setup completed! Plugins have been installed."
