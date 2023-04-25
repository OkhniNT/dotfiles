# Path
export PATH="$PATH:${HOME}/.scripts/:${HOME}/.local/bin"

# Language environment
export LC_CTYPE="en_AU.UTF-8"

# Remove lesshst
export LESSHISTFILE=-

# Config directories
export ZDOTDIR="${HOME}/.config/zsh"
export VIMINIT="source ~/.vim/.vimrc"

# XDG base directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Install directories
export CARGO_HOME="${HOME}/.cache/cargo"
export RUSTUP_HOME="${HOME}/.cache/rustup"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Default programs
export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="st"
export BROWSER="firefox"
export LAUNCHER="wofi --show run"
