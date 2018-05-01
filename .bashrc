# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# PS4='+ $(date "+%s.%N")\011 '
# exec 3>&2 2>/tmp/bashstart.$$.log
# set -x

# Cow says a quote as you open the terminal
if [ -x /usr/games/fortune ]; then
     fortune -a | cowsay
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$fedora_chroot" ] && [ -r /etc/fedora_chroot ]; then
    fedora_chroot=$(cat /etc/fedora_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${fedora_chroot:+($fedora_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
else
    PS1='${fedora_chroot:+($fedora_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${fedora_chroot:+($fedora_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# add tab completion to sudo
complete -cf sudo

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# for using git
source ~/.git-completion.bash
source ~/.git-prompt.sh
alias gitt='export PS1="[\033[01;34m]\W\$(__git_ps1)$ [\033[00m] "'

PATH=$PATH:$HOME/racket/bin # Add RVM to PATH for scripting
# source ~/perl5/perlbrew/etc/bashrc
export PYTHONPATH="~/bin/wxPython-src-2.9.4.0/wxPython"
export PATH=~/.local/bin/:$PATH
export LD_LIBRARY_PATH="~/bin/wxPython-src-2.9.4.0/bld/lib"
export PYTHONSTARTUP=~/.pythonrc

# The next line updates PATH for the Google Cloud SDK.
# source ~/learning/google-cloud-sdk/path.bash.inc

# The next line enables bash completion for gcloud.
# source ~/learning/google-cloud-sdk/completion.bash.inc

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# PERL_MB_OPT="--install_base \"~/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=~/perl5"; export PERL_MM_OPT;
# set +x
# exec 2>&3 3>&-

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="~/.sdkman"
[[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && source "~/.sdkman/bin/sdkman-init.sh"

# run MS-SQL tools
export PATH="$PATH:/opt/mssql-tools/bin"

# added by Anaconda3 installer
export PATH="$PATH:/home/smash/miniconda3/bin"
