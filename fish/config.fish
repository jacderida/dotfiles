fish_vi_key_bindings

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
if test -e ~/.todoist_settings
    source ~/.todoist_settings
end

set -x VAGRANT_DEFAULT_PROVIDER libvirt

umask 022
