fish_vi_key_bindings

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
    fzf_key_bindings
end

source ~/.cargo/env
umask 022
