#!/bin/bash
# scripts/terminal_setup.sh - Terminal customization

log "Setting up terminal environment..."

# Install Kitty terminal (optional - remove if not needed)
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Install Catppuccin theme
mkdir -p ~/.config/kitty
curl -o ~/.config/kitty/catppuccin.conf https://raw.githubusercontent.com/catppuccin/kitty/main/catppuccin.conf

# Configure Kitty
cat > ~/.config/kitty/kitty.conf << 'EOF'
include catppuccin.conf
font_family      JetBrains Mono
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size 12.0
EOF

success "Terminal setup completed!"
