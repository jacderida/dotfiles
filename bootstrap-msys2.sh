#!/usr/bin/env bash

[[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin

rm -f ~/.gitconfig 
ln -f ./git/.gitconfig ~/.gitconfig
rm -f ~/.githelpers 
ln -f ./git/.githelpers ~/.githelpers
rm -f ~/.local/bin/git_diff_wrapper
ln -f ./git/git_diff_wrapper ~/.local/bin/git_diff_wrapper
rm -f ~/.bashrc
ln -f ./bash/.bashrc ~/.bashrc
rm -f ~/.vimrc
ln -f ./vim/minimalist-dev/.vimrc ~/.vimrc
