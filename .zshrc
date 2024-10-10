# ~/.zshrc: executed by zsh for non-login shells.

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
SAVEHIST=2000
setopt APPEND_HISTORY  # append to the history file, don't overwrite it
setopt HIST_IGNORE_SPACE  # ignore commands that start with space

# Update the values of LINES and COLUMNS after each command
#setopt CHECK_WINSIZE

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# setopt GLOBSTAR

# Less friendly input
# [[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Set a variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Prompt settings (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal supports it
# force_color_prompt=yes

if [[ -n "$force_color_prompt" ]]; then
    if command -v tput &> /dev/null && tput setaf 1 &> /dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [[ "$color_prompt" == yes ]]; then
    PS1='${debian_chroot:+($debian_chroot)}%F{green}%n@%m%f:%F{blue}%~%f$ '
else
    PS1='${debian_chroot:+($debian_chroot)}%n@%m:%~$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm, set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a\]$PS1"
        ;;
    *)
        ;;
esac

# Enable color support for ls and handy aliases
if command -v dircolors &> /dev/null; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    alias ls='ls --color=auto'
    # alias dir='dir --color=auto'
    # alias vdir='vdir --color=auto'
    # alias grep='grep --color=auto'
    # alias fgrep='fgrep --color=auto'
    # alias egrep='egrep --color=auto'
fi

# Colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Aliases and custom functions
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias tn='tmux -u new -s'
alias ta='tmux -u attach -t'
alias td='tmux -u detach'
alias tk='tmux -u kill-session -t'
alias tls='tmux -u list-sessions'

alias myx2go="env QT_QPA_PLATFORM=xcb x2goclient"
alias cassis="/home/kmaitreys/Documents/software/cassis/cassis.run"
alias conp="conda activate pegasis"
alias nalaup="sudo nala update && sudo nala upgrade"
alias niser="/home/kmaitreys/Documents/software/forticlientsslvpn/64bit/forticlientsslvpn"
nala() {
  if [[ "$1" == "get" ]]; then
    shift
    sudo nala install "$@"
  elif [[ "$1" == "purge" ]]; then
    shift
    sudo nala purge "$@"
  else
    command nala "$@"
  fi
}

# If ~/.bash_aliases exists, source it (useful if migrating from Bash)
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Enable programmable completion features
if [ -f /usr/share/zsh/functions/Completion/Linux/_bash-completion ]; then
    fpath=(/usr/share/zsh/functions/Completion/Linux $fpath)
    autoload -Uz compinit
    compinit
fi

# Path configurations
export PATH="$PATH:/home/kmaitreys/.local/bin:/opt/nvim-linux64/bin:/home/kmaitreys/.nimble/bin:/home/kmaitreys/.zig/"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kmaitreys/.anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kmaitreys/.anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kmaitreys/.anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kmaitreys/.anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
. "$HOME/.cargo/env"

# >>> juliaup initialize >>>
# !! Contents within this block are managed by juliaup !!
export PATH=/home/kmaitreys/.juliaup/bin${PATH:+:${PATH}}
# <<< juliaup initialize <<<

export MODULAR_HOME="/home/kmaitreys/.modular"
export PATH="/home/kmaitreys/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

[ -f "/home/kmaitreys/.ghcup/env" ] && . "/home/kmaitreys/.ghcup/env" # ghcup-env

## PEGASIS ##
export PATH=$HOME/bin/:$PATH

# RADMC3D
export PYTHONPATH=$HOME/bin/python:$PYTHONPATH

# PYSYNPHOT
export PYSYN_CDBS="/home/kmaitreys/Documents/pegasis-projects/pegasis/grp/redcat/trds"
export MODULAR_HOME="/home/kmaitreys/.modular"
export PATH="/home/kmaitreys/.modular/pkg/packages.modular.com_max/bin:$PATH"

# Fastchem C++ bs
export LD_PRELOAD=/lib/x86_64-linux-gnu/libstdc++.so.6
