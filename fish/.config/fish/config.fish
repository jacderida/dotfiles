fish_vi_key_bindings

alias cat="bat"
alias ls="exa --icons"
alias tree="exa --icons --tree"
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
    fzf_key_bindings
end

if test -e ~/.cargo/env2
    source ~/.cargo/env2
end
if test -e ~/.aws_settings
    source ~/.aws_settings
end
if test -e ~/.digital_ocean_settings
    source ~/.digital_ocean_settings
end
if test -e ~/.todoist_settings
    source ~/.todoist_settings
end
if test -e ~/.github_settings
    source ~/.github_settings
end

set -x VAGRANT_DEFAULT_PROVIDER libvirt
set -x BASE_DEV_PATH /home/chris/dev

starship init fish | source
zoxide init fish | source
# This alias must be defined after zoxide is sourced.
alias cd="z"

umask 022
