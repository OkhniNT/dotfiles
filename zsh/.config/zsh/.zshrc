# Theme
source ~/.config/zsh/robbyrussell.zsh

# History
SAVEHIST=100
HISTFILE=~/.config/zsh/.zsh_history

# Autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
compinit

# Custom Autocompletion
fpath=($HOME/.config/zsh/completion $fpath)

# Vim mode
bindkey -v

# Alias commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sx='startx'
alias sw='Hyprland'
alias mnt='sudo mount -o uid=1000,gid=998'
alias bl='bluetoothctl'
alias v='vim'
alias vf='vifmrun'
alias vifm='vifmrun'
alias cdf='cd "$(find * -type d | fzf --reverse)"'
alias ntp='sudo ntpdate 0.au.pool.ntp.org'
alias conf='cd "$(find ~/.config* | fzf --reverse)"'
alias off='shutdown -h now'
