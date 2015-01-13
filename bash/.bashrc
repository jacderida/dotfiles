# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

       BLACK="\[\033[0;30m\]"
 LIGHT_BLACK="\[\033[1;30m\]"
   LIGHT_RED="\[\033[1;31m\]"
         RED="\[\033[0;31m\]"
   LIGHT_RED="\[\033[1;31m\]"
       GREEN="\[\033[0;32m\]"
 LIGHT_GREEN="\[\033[1;32m\]"
      YELLOW="\[\033[1;33m\]"
  LIGHT_BLUE="\[\033[0;34m\]"
        BLUE="\[\033[1;34m\]"
      PURPLE="\[\033[0;35m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
        CYAN="\[\033[0;36m\]"
  LIGHT_CYAN="\[\033[1;36m\]"
  LIGHT_GRAY="\[\033[0;37m\]"
       WHITE="\[\033[1;37m\]"
  COLOR_NONE="\[\e[0m\]"

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
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes


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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
libstderr_red="/home/jacderida/dev/stderred/build/libstderred.so"
[[ $(uname -s) != CYGWIN_NT-* && -f "$libstderr_red" ]] && export LD_PRELOAD="$libstderr_red${LD_PRELOAD:+:$LD_PRELOAD}"

# This fixes a permissions issue with using git aliases.
# See here: http://stackoverflow.com/questions/7997700/git-aliases-causing-permission-denied-error
PATH=$(for d in ${PATH//:/ } ; do [ -x $d ] && printf "$d\n"; done | uniq | tr '\12' ':')
PATH=${PATH%?}

alias tmux="TERM=screen-256color tmux -2 -u"
alias mci="mvn clean install"
stty -ixon -ixoff # See here: http://stackoverflow.com/questions/8616843/ctrl-s-is-not-working-as-a-horizontal-split-in-vim-when-using-commandt

function createscript
{
    printf "#!/usr/bin/env bash" >> $1
    vim $1
}

operating_system=`uname -s`
if [ "$operating_system" = "Darwin" ]; then
    vim() {
        (unset GEM_PATH GEM_HOME; command vim "$@")
    }
fi

export PAGER=/usr/local/bin/vimpager
alias less=$PAGER
alias zless=$PAGER
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
[[ -s "$HOME/.proxy" ]] && source "$HOME/.proxy"
[[ -s "$HOME/.aws_keys" ]] && source "$HOME/.aws_keys"
[[ -s "$HOME/.rackspace_details" ]] && source "$HOME/.rackspace_details"
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.local/bin

function is_git_repository() {
    git branch > /dev/null 2>&1
}

function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function set_git_branch() {
    BRANCH="${YELLOW}[${COLOR_NONE}${GREEN}$(parse_git_branch)${COLOR_NONE}${YELLOW}]${COLOR_NONE} "
}

function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function set_prompt() {
    PS1_TIME="${YELLOW}[${COLOR_NONE}${LIGHT_RED}\t${COLOR_NONE}${YELLOW}]${COLOR_NONE}"
    PS1_USER="${CYAN}\u${COLOR_NONE}"
    PS1_LOCATION="${LIGHT_PURPLE}\h${COLOR_NONE}"
    PS1_WORKING_DIR="${BLUE}\w${COLOR_NONE}"
    PS1_SEPARATOR="${YELLOW}»${COLOR_NONE}"
    PS1_PROMPT_SYMBOL="${LIGHT_RED}\$ ${COLOR_NONE}"
    if is_git_repository ; then
        set_git_branch
    else
        BRANCH=""
    fi
    PS1="${PS1_TIME} ${PS1_USER}@${PS1_LOCATION} ${PS1_SEPARATOR} ${PS1_WORKING_DIR} ${BRANCH}${PS1_PROMPT_SYMBOL}"
}

PROMPT_COMMAND=set_prompt
