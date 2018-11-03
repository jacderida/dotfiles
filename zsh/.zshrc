export ZSH=/home/$USER/.oh-my-zsh
export TERM=xterm-256color
export TZ=Europe/Dublin
ZSH_THEME="powerlevel9k/powerlevel9k"
HIST_STAMPS="mm/dd/yyyy"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(docker git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"
[[ -s "$HOME/.go_settings" ]] && source "$HOME/.go_settings"
[[ -s "$HOME/.proxy" ]] && source "$HOME/.proxy"
[[ -s "$HOME/.terraform" ]] && source "$HOME/.terraform"
[[ -s "$HOME/.java_settings" ]] && source "$HOME/.java_settings"
[[ -s "$HOME/.gradle_settings" ]] && source "$HOME/.gradle_settings"
[[ -s "$HOME/.pip_settings" ]] && source "$HOME/.pip_settings"
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -s "$HOME/.config/terminator/gruvbox_256palette.sh" ]] && source "$HOME/.config/terminator/gruvbox_256palette.sh"

if [[ -s "/usr/local/bin/virtualenvwrapper.sh" ]]; then
   export WORKON_HOME=$HOME/.virtualenvs
   export PROJECT_HOME=$HOME/dev
   export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
   source /usr/local/bin/virtualenvwrapper.sh
fi

export NOSE_REDNOSE=1 # For python based unit testing with nosetests.
export PATH=$PATH:$HOME/bin:$HOME/.local/bin

unsetopt correct_all

eval "$(direnv hook zsh)"
