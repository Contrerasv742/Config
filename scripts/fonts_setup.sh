#!/bin/bash
# scripts/fonts_setup.sh - Minimal Nerd Font installation

log "Setting up Nerd Fonts..."

# Create font directory
FONT_DIR="$HOME/.local/share/fonts/NerdFonts"
mkdir -p "$FONT_DIR"

# Clean existing installations
rm -f "$FONT_DIR"/Fira*
rm -rf ~/.cache/fontconfig/*

# Direct download URLs for FiraCode (as a reliable alternative)
FONTS=(
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf"
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Bold/FiraCodeNerdFont-Bold.ttf"
)

# Download fonts one by one
for url in "${FONTS[@]}"; do
    filename=$(basename "$url")
    log "Downloading $filename..."
    if wget -q "$url" -O "$FONT_DIR/$filename"; then
        success "Downloaded $filename"
    else
        warn "Failed to download $filename"
    fi
done

# Minimal fontconfig setup
mkdir -p "$HOME/.config/fontconfig"
cat > "$HOME/.config/fontconfig/fonts.conf" << 'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <dir>~/.local/share/fonts</dir>
</fontconfig>
EOF

# Update font cache in small chunks
log "Updating font cache for new directory only..."
fc-cache -f "$FONT_DIR"

# Simple verification
if fc-list | grep -i "FiraCode Nerd" > /dev/null; then
    success "Font installation successful!"
else
    # Fallback to system package
    warn "Using system package as fallback..."
    sudo apt-get update && sudo apt-get install -y fonts-firacode
fi

# Test output
echo -e "\nFont Test (you should see icons below):"
echo -e "  Code: \uf121"
echo -e "  Git: \uf1d3"
echo -e "  Folder: \uf07b"

cat << 'EOF'

Installation Complete!
To use the font:
1. Set your terminal font to "FiraCode Nerd Font" or "Fira Code"
2. Restart your terminal
EOF

success "Font setup completed!"
