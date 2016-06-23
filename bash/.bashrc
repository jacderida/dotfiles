# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples
       BLACK="\[\033[0;30m\]"
 LIGHT_BLACK="\[\033[1;30m\]"
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

set -o vi

HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize
HISTSIZE=1000
HISTFILESIZE=2000
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export TERM=xterm-256color

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

operating_system=`uname -s`
if [ "$operating_system" = "Darwin" ]; then
    vim() {
        (unset GEM_PATH GEM_HOME; command vim "$@")
    }
fi

export NOSE_REDNOSE=1 # For python based unit testing with nosetests.
export PAGER=/usr/local/bin/vimpager
alias less=$PAGER
alias zless=$PAGER
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
[[ -s "$HOME/.proxy" ]] && source "$HOME/.proxy"
[[ -s "$HOME/.aws_keys" ]] && source "$HOME/.aws_keys"
[[ -s "$HOME/.rackspace_details" ]] && source "$HOME/.rackspace_details"
[[ -s "$HOME/.go_details" ]] && source "$HOME/.go_details"
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

function set_virtualenv () {
    if test -z "$VIRTUAL_ENV" ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="${YELLOW}[${COLOR_NONE}${LIGHT_PURPLE}`basename \"$VIRTUAL_ENV\"`${COLOR_NONE}${YELLOW}]${COLOR_NONE}"
    fi
}

function set_prompt() {
    PS1_TIME="${YELLOW}[${COLOR_NONE}${LIGHT_RED}\t${COLOR_NONE}${YELLOW}]${COLOR_NONE}"
    PS1_USER="${CYAN}\u${COLOR_NONE}"
    PS1_LOCATION="${PURPLE}\h${COLOR_NONE}"
    PS1_WORKING_DIR="${BLUE}\w${COLOR_NONE} "
    PS1_SEPARATOR="${YELLOW}»${COLOR_NONE}"
    PS1_PROMPT_SYMBOL="${LIGHT_RED}\$ ${COLOR_NONE}"
    set_virtualenv
    if is_git_repository ; then
        set_git_branch
    else
        BRANCH=""
    fi
    PS1="${PS1_TIME}${PYTHON_VIRTUALENV} ${PS1_USER}@${PS1_LOCATION} ${PS1_SEPARATOR} ${PS1_WORKING_DIR}${BRANCH}${PS1_PROMPT_SYMBOL}"
}

PROMPT_COMMAND=set_prompt
export RUBYRIPPER_CONFIG_PATH=$HOME/.rubyripper_settings_orig

alias azure="docker run --name azure --rm -v ~/.azure:/root/.azure:ro -v ~/.ssh:/root/.ssh:ro -it microsoft/azure-cli"
