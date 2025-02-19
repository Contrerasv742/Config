#!/bin/bash
# scripts/packages.sh - Basic package installation
log "Installing base packages..."

# Update package lists first
log "Updating package lists..."
sudo apt update || { error "Failed to update package lists"; exit 1; }

# Check for and remove problematic NodeJS packages
if command -v nodejs &>/dev/null || command -v npm &>/dev/null; then
    log "Removing existing NodeJS packages..."
    sudo apt remove -y nodejs npm
    sudo apt autoremove -y
    sudo rm -rf /etc/apt/sources.list.d/nodesource.list*
    sudo apt update
fi

# Install base dependencies with error checking
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
    fontconfig || { error "Failed to install base dependencies"; exit 1; }

# Create a temporary directory for installations
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT
cd "$TEMP_DIR"

# Install NVM if not already installed
if [ ! -d "$HOME/.nvm" ] || [ ! -s "$HOME/.nvm/nvm.sh" ]; then
    log "Installing NVM..."
    # Create NVM directory first
    mkdir -p "$HOME/.nvm"
    # Download and install NVM
    export NVM_DIR="$HOME/.nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash || { error "Failed to install NVM"; exit 1; }
else
    log "NVM already installed, skipping installation"
fi

# Source NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js using NVM if not already installed
if ! nvm ls --no-colors | grep -q "lts/.*" || ! command -v node &>/dev/null; then
    log "Installing Node.js LTS version..."
    nvm install --lts || { error "Failed to install Node.js LTS"; exit 1; }
    nvm use --lts
else
    log "Node.js LTS already installed via NVM"
    nvm use --lts
fi

# Verify Node.js and npm installation
if command -v node &>/dev/null && command -v npm &>/dev/null; then
    log "Node.js $(node -v) and npm $(npm -v) installed successfully"
else
    error "Failed to install Node.js and npm"
    exit 1
fi

# Install Rust if not already installed
if ! command -v cargo &>/dev/null; then
    log "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || { error "Failed to install Rust"; exit 1; }
    # Source cargo environment
    . "$HOME/.cargo/env"
else
    log "Rust already installed, skipping installation"
fi

# Update shell configuration files
for rcfile in ".bashrc" ".zshrc"; do
    if [ -f "$HOME/$rcfile" ]; then
        # Backup the rc file only if it hasn't been backed up already
        if [ ! -f "$HOME/${rcfile}.backup.$(date +%Y%m%d)" ]; then
            cp "$HOME/$rcfile" "$HOME/${rcfile}.backup.$(date +%Y%m%d)"
            log "Created backup of $rcfile"
        fi
        
        # Check if NVM config needs updating
        if ! grep -q 'export NVM_DIR="$HOME/.nvm"' "$HOME/$rcfile" || \
           ! grep -q '\[ -s "$NVM_DIR/nvm.sh" \]' "$HOME/$rcfile"; then
            
            # Remove any existing NVM configurations to avoid duplicates
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
            log "Updated NVM configuration in $rcfile"
        fi
        
        # Add Rust configuration if not present
        if ! grep -q "cargo/env" "$HOME/$rcfile"; then
            echo 'source "$HOME/.cargo/env"' >> "$HOME/$rcfile"
            log "Added Rust configuration to $rcfile"
        fi
    fi
done

# Verify installations
log "Verifying installations..."
# Export PATH to include newly installed binaries
export PATH="$HOME/.nvm/versions/node/$(nvm current)/bin:$HOME/.cargo/bin:$PATH"
command -v node && log "Node.js version: $(node --version)"
command -v npm && log "npm version: $(npm --version)"
command -v cargo && log "Rust version: $(cargo --version)"

success "Base packages installed successfully!"
