fish_vi_key_bindings

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
    fzf_key_bindings
end

eval (python -m virtualfish)
if test -e ~/.cargo/env
    source ~/.cargo/env
end
if test -e ~/.aws_settings
    source ~/.aws_settings
end
umask 022
