#!/bin/bash
# scripts/terminal_setup.sh - Terminal customization

log "Setting up terminal environment..."

# Install Yazi (terminal file manager)
apt install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick

# Install TMUX + add a configuration file
apt install tmux
cp ../setup_files/tmux.conf ~/.config/tmux/tmux.conf

success "Terminal setup completed!"
