#!/bin/bash
# scripts/starship_setup.sh - Starship prompt setup

log "Setting up Starship prompt..."

# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Configure Starship
mkdir -p ~/.config
cat > ~/.config/starship.toml << 'EOF'
# Get editor completions based on the config schema
"$schema" = 'https://starship.rs/config-schema.json'

# Use custom format
format = """
[█](surface0)\
$directory\
$git_branch\
$git_status\
$python\
$nodejs\
$rust\
[█](surface0)
$character"""

# Catppuccin theme colors
palette = "catppuccin_mocha"

[palettes.catppuccin_mocha]
rosewater = "#f5e0dc"
flamingo = "#f2cdcd"
pink = "#f5c2e7"
mauve = "#cba6f7"
red = "#f38ba8"
maroon = "#eba0ac"
peach = "#fab387"
yellow = "#f9e2af"
green = "#a6e3a1"
teal = "#94e2d5"
sky = "#89dceb"
sapphire = "#74c7ec"
blue = "#89b4fa"
lavender = "#b4befe"
text = "#cdd6f4"
subtext1 = "#bac2de"
subtext0 = "#a6adc8"
overlay2 = "#9399b2"
overlay1 = "#7f849c"
overlay0 = "#6c7086"
surface2 = "#585b70"
surface1 = "#45475a"
surface0 = "#313244"
base = "#1e1e2e"
mantle = "#181825"
crust = "#11111b"

[directory]
style = "bg:surface0 fg:blue"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
style = "bg:surface0 fg:mauve"
format = '[[ $symbol$branch ](fg:mauve bg:surface0)]($style)'

[git_status]
style = "bg:surface0 fg:peach"
format = '[[$all_status$ahead_behind ](fg:peach bg:surface0)]($style)'

[python]
style = "bg:surface0 fg:yellow"
format = '[[ ${symbol}${pyenv_prefix}(${version} )(\($virtualenv\) )]($style)]'

[nodejs]
style = "bg:surface0 fg:green"
format = '[[ ${symbol}($version) ]($style)]'

[rust]
style = "bg:surface0 fg:peach"
format = '[[ ${symbol}($version) ]($style)]'

[character]
success_symbol = "[❯](green)"
error_symbol = "[❯](red)"
EOF

# Add Starship to shell config
echo 'eval "$(starship init bash)"' >> ~/.bashrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

success "Starship setup completed!"
