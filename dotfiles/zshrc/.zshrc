export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export PGHOST="/var/run/postgresql"

export PATH=$PATH:/usr/local/go/bin

# ZSH History stuff
export HISTFILE=~/.history
export HISTSIZE=10000
export SAVEHIST=50000
export FUNCNEST=10000

setopt inc_append_history

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Yazi Function
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Shortcuts (Aliases)
alias ls="ls --color=auto"
alias la="ls -al"

alias open="xdg-open"

# Catpuccin Coloring
# Load zsh-syntax-highlighting
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Start tmux server if not already running, but don't attach
if command -v tmux &> /dev/null && [ -z "$TMUX" ] && ! tmux info &> /dev/null; then
    tmux start-server
fi

# Auto-suggestion settings
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585b70,italic"  # Using a Catppuccin Mocha color to match your theme
# bindkey '^\' autosuggest-accept  # Ctrl+\ to accept suggestion

# Catppuccin Mocha colors for syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
# Main colors - using true Catppuccin Mocha palette
ZSH_HIGHLIGHT_STYLES[default]=fg=#cdd6f4
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=#f38ba8
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=#f9e2af,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=#a6e3a1,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=#a6e3a1,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=#a6e3a1,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=#a6e3a1,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=#a6e3a1,italic
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=#cba6f7
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=#a6e3a1
ZSH_HIGHLIGHT_STYLES[path]=fg=#b4befe,underline
ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=#b4befe
ZSH_HIGHLIGHT_STYLES[globbing]=fg=#f5c2e7
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=#cba6f7
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=#f5c2e7
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=#f5c2e7
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=#cba6f7
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=#f9e2af
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=#f9e2af
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=#f9e2af
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=#f9e2af
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=#fab387
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=#f38ba8
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=#f38ba8
ZSH_HIGHLIGHT_STYLES[assign]=fg=#cdd6f4
ZSH_HIGHLIGHT_STYLES[redirection]=fg=#cba6f7
ZSH_HIGHLIGHT_STYLES[comment]=fg=#585b70,italic
ZSH_HIGHLIGHT_STYLES[arg0]=fg=#a6e3a1

# Use vivid for LS_COLORS with Catppuccin theme
export LS_COLORS=$(vivid generate catppuccin)

export PATH="$PATH:/home/panda/.local/opt/zen"

# ECE 118 Paths
export PATH=$PATH:/opt/microchip/xc32/v4.35/bin

# Alias for adjusting PC settings
export PC=1

# Scripts
~/.config/fastfetch/pokemon.sh

eval "$(starship init zsh)"
