# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

##################################################
## rvm
##################################################
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

##################################################
## git
##################################################
# Load in the git branch prompt script.
source ~/scripts/.git-prompt.sh

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function custom_prompt {
  # Colored prompt: user@host dir$ (user and host are blue, directory is red)
  export PS1='\[\e[1;34m\]\u@\h\[\e[m\] \[\e[0;31m\]\w\[\e[m\]$(__git_ps1) \[\e[1;34m\]\$\[\e[m\] '
}

# Got this platform checking stuff from http://stackoverflow.com/questions/394230/detect-os-from-a-bash-script
platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='macos'
elif [[ "$unamestr" == 'MINGW32_NT-6.1' ]]; then
  platform='windows'
fi

if [[ $platform == 'linux' ]]; then
  custom_prompt
elif [[ $platform == 'freebsd' ]]; then
  custom_prompt
  # Alias to provide colored output from ls at all times
  # See http://superuser.com/questions/232583/color-coding-mac-terminal
  alias ls='ls -G'
elif [[ $platform == 'macos' ]]; then
  custom_prompt
  export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
  PATH=$PATH:/usr/local/mysql/bin
elif [[ $platform == 'windows' ]]; then
  SSH_ENV="$HOME/.ssh/environment"
  source ~/.bash/bash_functions_windows.sh
  check_agent
fi

##################################################
## path
##################################################
PATH=$PATH:~/bin

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

