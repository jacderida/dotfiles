#!/usr/bin/env bash

set -e

DOTFILES_ROOT="`pwd`"
USER_HOME=`eval echo ~$USER`

echo $USER_HOME
for bootstrap in `find $DOTFILES_ROOT -name "bootstrap" -not -path ./*.sh` 
do
	echo "================================================================="
	echo "Running $bootstrap"
	echo "================================================================="
	source $bootstrap
done
