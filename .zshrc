### (x.com/@7etsuo) - 2024 ################################################
#  ▄▄▄█████▓▓█████▄▄▄█████▓  ██████  █    ██  ▒█████  
#  ▓  ██▒ ▓▒▓█   ▀▓  ██▒ ▓▒▒██    ▒  ██  ▓██▒▒██▒  ██▒
#  ▒ ▓██░ ▒░▒███  ▒ ▓██░ ▒░░ ▓██▄   ▓██  ▒██░▒██░  ██▒
#  ░ ▓██▓ ░ ▒▓█  ▄░ ▓██▓ ░   ▒   ██▒▓▓█  ░██░▒██   ██░
#    ▒██▒ ░ ░▒████▒ ▒██▒ ░ ▒██████▒▒▒▒█████▓ ░ ████▓▒░
#    ▒ ░░   ░░ ▒░ ░ ▒ ░░   ▒ ▒▓▒ ▒ ░░▒▓▒ ▒ ▒ ░ ▒░▒░▒░ 
#      ░     ░ ░  ░   ░    ░ ░▒  ░ ░░░▒░ ░ ░   ░ ▒ ▒░ 
#    ░         ░    ░      ░  ░  ░   ░░░ ░ ░ ░ ░ ░ ▒  
#              ░  ░              ░     ░         ░ ░  
############################################################


# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

# ZSH options
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"

# Update behavior
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# Plugins (reduced for faster startup)
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Environment variables
export LANG=en_US.UTF-8
export EDITOR='vim'
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"

# Lazy load NVM
nvm() {
    unset -f nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}

# Lazy load pyenv
pyenv() {
    unset -f pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(command pyenv init -)"
    pyenv "$@"
}

# Lazy load conda
conda() {
    unset -f conda
    __conda_setup="$('/home/storm/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/storm/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/storm/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/storm/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    conda "$@"
}

# Custom Gruvbox-inspired prompt
PROMPT=$'%{$fg[blue]%}┌[%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[magenta]%}%m%{$fg[blue]%}]─[%{$fg[yellow]%}%~%{$fg[blue]%}]\n└─%{$fg[red]%}$ %{$reset_color%}'

# Right-side prompt with git information
RPROMPT='$(git_prompt_info)%{$fg[gray]%}[%{$fg[cyan]%}%D{%H:%M:%S}%{$fg[gray]%}]%{$reset_color%}'

# Git prompt configuration
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Aliases
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias update='sudo pacman -Syu'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias vi='vim'

# Functions
mkcd() { mkdir -p "$1" && cd "$1"; }

# Fast system info display
echo "Welcome to Arch Linux, $(whoami)!"
neofetch
