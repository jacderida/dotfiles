dotfiles
========

Since beginning development on UNIX based platforms, I've discovered people maintain repositories for app specific settings, and immediately knew I had to get on the bandwagon. In particular, having it version controlled is very useful, because if you need to, you can follow your own train of thought as to why you applied some particular setting. My intention, as with everyone else, is to be able to get a fresh development machine (on OSX or Linux) up and running with all my custom settings, with as little as possible manual input; when I automate something once, I never again have to worry about remembering all the tedious little error prone steps for each set of application settings participating in the process.

This repository will be supplemented with my automation repository, which will aim to setup the OS and all the actual applications themselves, and do any system specific setup along those lines.

Automated
---------

bash
* Install custom .bashrc
* Sets up powerline

fonts
* Install AndaleMono
* Install terminus

git (Install my gitconfig)
* Sets my name
* Sets my email
* Sets editor for commits
* Use colors by default
* Sets my github username

netbeans
* Copy my configuration
* Maintains a copy of the solarized colour scheme

powerline
* Installs powerline (based on an assumption that there's a Python install on the machine)
* Copies the config files to custom profile directory
* Symlinks config.json and the custom config for the shell to the profile directory

ruby
* Installs RVM
* Installs ruby version 2.0.0
* Installs rails version 4.0.0

ubuntu
* Automates custom settings related to Ubuntu

vim
* Install vimrc
* Install solarized colour scheme
* Install wombat256 colour scheme
* Install pathogen for plugin management
* Install JSON plugin
