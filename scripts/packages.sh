#!/bin/bash
# scripts/packages.sh - Basic package installation

log "Installing base packages..."

# Update package list
sudo apt update

# Install base dependencies
sudo apt install -y \
    git \
    curl \
    wget \
    unzip \
    nodejs \
    npm \
    python3 \
    python3-pip \
    python3-venv \
    ripgrep \
    fd-find \
    luarocks \
    xclip \
    build-essential \
    pkg-config \
    libtool \
    libtool-bin \
    gettext \
    cmake \
    g++ \
    pkg-config \
    unzip \
    curl \
    doxygen \
    luajit \
    lua5.1 \
    tree-sitter-cli\
    fontconfig 

# Install Rust (needed for some Neovim plugins)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Node.js 20.x repository and install
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

success "Base packages installed successfully!"
