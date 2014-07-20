#!/usr/bin/env bash

black='\033[0;30m'
blue='\033[0;34m'
green='\033[0;32m'
cyan='\033[0;36m'
red='\033[0;31m'
purple='\033[0;35m'
orange='\033[0;33m'
light_gray='\033[0;37m'
dark_gray='\033[1;30m'
light_blue='\033[1;34m'
light_green='\033[1;32m'
light_cyan='\033[1;36m'
light_red='\033[1;31m'
light_purple='\033[1;35m'
yellow='\033[1;33m'
white='\033[1;37m'
nc='\033[0m'

set -e

DOTFILES_ROOT="`pwd`"
USER_HOME=`eval echo ~$USER`

# Unfortunately, we have to guarantee that the ruby bootstrap runs before the vim bootstrap.
source ./ruby/bootstrap
for bootstrap in `find $DOTFILES_ROOT -name "bootstrap" -not -path ./*.sh` 
do
	echo -e "${blue}=================================================================${nc}"
	echo -e "${blue}Running $bootstrap${nc}"
	echo -e "${blue}=================================================================${nc}"
	source $bootstrap
done
