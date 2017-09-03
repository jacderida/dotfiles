export ZSH=/home/vagrant/.oh-my-zsh
ZSH_THEME="powerlevel9k/powerlevel9k"
HIST_STAMPS="mm/dd/yyyy"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"
[[ -s "$HOME/.proxy" ]] && source "$HOME/.proxy"
[[ -s "$HOME/.terraform" ]] && source "$HOME/.terraform"

export NOSE_REDNOSE=1 # For python based unit testing with nosetests.
export PATH=$PATH:$HOME/bin:$HOME/.local/bin
