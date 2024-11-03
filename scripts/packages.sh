#!/bin/bash
# scripts/packages.sh - Basic package installation

log "Installing base packages..."

# Remove problematic NodeJS packages
log "Removing existing NodeJS packages..."
sudo apt remove -y nodejs npm
sudo apt autoremove -y
sudo rm -rf /etc/apt/sources.list.d/nodesource.list*
sudo apt update

# Install base dependencies
log "Installing base system dependencies..."
sudo apt install -y \
    git \
    curl \
    wget \
    unzip \
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
    doxygen \
    luajit \
    lua5.1 \
    tree-sitter-cli \
    fontconfig

# Create a temporary directory for installations
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Install NVM
log "Installing NVM..."
# Create NVM directory first
mkdir -p "$HOME/.nvm"

# Download and install NVM
export NVM_DIR="$HOME/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Ensure NVM script exists before sourcing
if [ -s "$NVM_DIR/nvm.sh" ]; then
    # Source NVM
    . "$NVM_DIR/nvm.sh"
    
    # Install Node.js using NVM
    log "Installing Node.js LTS version..."
    nvm install --lts
    nvm use --lts
    
    # Verify Node.js and npm installation
    if command -v node &>/dev/null && command -v npm &>/dev/null; then
        log "Node.js $(node -v) and npm $(npm -v) installed successfully"
    else
        error "Failed to install Node.js and npm"
        exit 1
    fi
else
    error "NVM installation failed - script not found"
    exit 1
fi

# Install Rust
log "Installing Rust..."
if ! command -v cargo &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # Source cargo environment
    . "$HOME/.cargo/env"
fi

# Clean up
cd "$HOME"
rm -rf "$TEMP_DIR"

# Update shell configuration files
for rcfile in ".bashrc" ".zshrc"; do
    if [ -f "$HOME/$rcfile" ]; then
        # Backup the rc file
        cp "$HOME/$rcfile" "$HOME/${rcfile}.backup"
        
        # Remove any existing NVM configurations
        sed -i '/NVM_DIR/d' "$HOME/$rcfile"
        sed -i '/nvm.sh/d' "$HOME/$rcfile"
        sed -i '/bash_completion/d' "$HOME/$rcfile"
        
        # Add fresh NVM configuration
        {
            echo ''
            echo '# NVM Configuration'
            echo 'export NVM_DIR="$HOME/.nvm"'
            echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm'
            echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'
        } >> "$HOME/$rcfile"
        
        # Add Rust configuration if not present
        if ! grep -q "cargo/env" "$HOME/$rcfile"; then
            echo 'source "$HOME/.cargo/env"' >> "$HOME/$rcfile"
        fi
    fi
done

# Verify installations
log "Verifying installations..."
# Export PATH to include newly installed binaries
export PATH="$HOME/.nvm/versions/node/$(nvm current)/bin:$PATH"
command -v node && echo "Node.js version: $(node --version)"
command -v npm && echo "npm version: $(npm --version)"
command -v cargo && echo "Rust version: $(cargo --version)"

success "Base packages installed successfully!"
