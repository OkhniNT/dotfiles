# Path
export PATH="$PATH:$HOME/.scripts/:$HOME/.local/bin"

# Environment variables
export NVD_BACKEND="direct"
export LC_CTYPE="en_AU.UTF-8"

# Remove lesshst
export LESSHISTFILE=-

# Config directories
export ZDOTDIR="$HOME/.config/zsh"
export VIMINIT="source ~/.vim/.vimrc"

# XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Install directories
export CARGO_HOME="$HOME/.cache/cargo"
export RUSTUP_HOME="$HOME/.cache/rustup"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export _GL_SHADER_DISK_CACHE="$XDG_CACHE_HOME/nv"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

# Default programs
export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="st"
export BROWSER="firefox"
export LAUNCHER="rofi -show run"
