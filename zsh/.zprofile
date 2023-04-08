# Path
export PATH="$PATH:${HOME}/.scripts/:${HOME}/.local/bin"

# XDG base directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Language environment
export LC_CTYPE="en_AU.UTF-8"

# ZSH config directory
export ZDOTDIR="${HOME}/.config/zsh"

# Vim config directory
export VIMINIT="source ~/.vim/.vimrc"

# Remove lesshst
export LESSHISTFILE=-

# Install directories
export CARGO_HOME="${HOME}/.cache/cargo"
export RUSTUP_HOME="${HOME}/.cache/rustup"

# Default programs
export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="st"
export BROWSER="firefox"
export LAUNCHER="rofi -show run"
