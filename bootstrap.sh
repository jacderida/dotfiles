#!/usr/bin/env bash

DOTFILES_ROOT="`pwd`"

for bootstrap in `find $DOTFILES_ROOT -name "bootstrap" -not -path ./*.sh` 
do
	echo "================================================================="
	echo "Running $bootstrap"
	echo "================================================================="
	source $bootstrap
done
