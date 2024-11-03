#!/bin/bash
# scripts/fonts_setup.sh - Enhanced Nerd Fonts installation

# Font preview function
preview_font() {
    local font_name="$1"
    local preview_text="ABCDEF abcdef 123456 →←⇒⇐ λ   "
    
    echo -e "\n=== Preview of $font_name ==="
    echo "Regular text:"
    echo -e "$preview_text" | convert -size 800x60 -font "$font_name" \
        -pointsize 24 -background white -fill black label:@- png:- | \
        convert - -colors 256 sixel:-
    
    echo -e "\nNerd Font Icons:"
    echo -e " \uf121 \uf113 \uf115 \uf23a \uf8ff" | convert -size 800x60 -font "$font_name" \
        -pointsize 24 -background white -fill black label:@- png:- | \
        convert - -colors 256 sixel:-
}

# Fallback function
install_fallback_font() {
    log "Attempting to install fallback font..."
    local fallback_fonts=(
        "FiraMono"
        "JetBrainsMono"
        "Hack"
        "RobotoMono"
    )
    
    for font in "${fallback_fonts[@]}"; do
        if [ "$font" != "$1" ]; then
            log "Trying $font as fallback..."
            wget -q "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/${font}.zip" && {
                unzip -q "${font}.zip" -d "${font,,}"
                cp "${font,,}"/*.ttf ~/.local/share/fonts/
                log "Successfully installed $font as fallback"
                return 0
            }
        fi
    done
    return 1
}

log "Setting up Nerd Fonts..."

# Install dependencies for font preview
sudo apt-get install -y imagemagick libsixel-bin

# Create fonts directory if it doesn't exist
mkdir -p ~/.local/share/fonts

# Create temporary directory for font download
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Array of font weights to download
declare -A font_weights=(
    ["Regular"]="FiraMono-Regular.ttf"
    ["Bold"]="FiraMono-Bold.ttf"
    ["Medium"]="FiraMono-Medium.ttf"
)

# Download and install FiraMono Nerd Font
log "Downloading FiraMono Nerd Font..."
if wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraMono.zip; then
    # Extract the font
    log "Installing FiraMono Nerd Font..."
    unzip -q FiraMono.zip -d fira_mono
    
    # Install each weight and verify
    for weight in "${!font_weights[@]}"; do
        font_file="fira_mono/${font_weights[$weight]}"
        if [ -f "$font_file" ]; then
            cp "$font_file" ~/.local/share/fonts/
            log "Installed FiraMono $weight"
        else
            log "Warning: $weight weight not found in package"
        fi
    done
    
    # Preview the installed font
    if command -v convert >/dev/null && command -v sixel >/dev/null; then
        for weight in "${!font_weights[@]}"; do
            preview_font "FiraMono Nerd Font ${weight}"
        done
    else
        log "Font preview not available (imagemagick or sixel not installed)"
    fi
else
    log "Failed to download FiraMono Nerd Font"
    if install_fallback_font "FiraMono"; then
        log "Successfully installed fallback font"
    else
        log "Failed to install any fonts"
        exit 1
    fi
fi

# Clean up temporary files
rm -rf "$TEMP_DIR"

# Refresh font cache
log "Updating font cache..."
fc-cache -f

# Verify installation
log "Verifying font installation..."
if fc-list | grep -i "FiraMono Nerd Font" >/dev/null; then
    success "FiraMono Nerd Font installed successfully!"
    
    # Show available weights
    echo "Installed weights:"
    fc-list | grep -i "FiraMono Nerd Font" | while read -r line; do
        weight=$(echo "$line" | grep -o "weight=[0-9]*" | cut -d= -f2)
        style=$(echo "$line" | grep -o "style=.*:" | cut -d= -f2 | cut -d: -f1)
        echo "- $style (weight: $weight)"
    done
else
    log "Warning: Font installation might have failed. Please check manually."
fi

# Test font in terminal
echo -e "\nTesting Nerd Font Icons:"
echo -e "  Normal:     \uf121 \uf113 \uf115 \uf23a \uf8ff"
echo -e "  Dev Icons:  \ue718 \ue719 \ue712 \ue711 \ue77f"
echo -e "  Git:        \uf1d3 \uf1d2 \uf1d1 \uf1d0 \uf1d5"
echo -e "  Folders:    \uf115 \uf114 \uf07b \uf07c \uf07d"

echo -e "\nTo use this font in your terminal:"
echo "1. Set your terminal font to 'FiraMono Nerd Font'"
echo "2. You may need to restart your terminal"
echo "3. Test with: echo -e '\uf121' # Should show a code icon"
