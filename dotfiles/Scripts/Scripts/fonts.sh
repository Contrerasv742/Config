mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "Fira Mono Regular Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraMono/Regular/complete/Fira%20Mono%20Regular%20Nerd%20Font%20Complete.otf
curl -fLo "Fira Mono Bold Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraMono/Bold/complete/Fira%20Mono%20Bold%20Nerd%20Font%20Complete.otf
fc-cache -fv
