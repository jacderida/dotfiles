# dotfiles

My dotfiles, now pruned down to stuff I'm actively using right now.

For some reason, it took me until 2021 before discovering GNU Stow, which is what I'm now using for managing them. I thought I'd be able to run `stow . --target=/home/chris` and it would go into all the directories here, but that doesn't work. To have the effect I would expect, I need to run it on each folder individually. For that reason, there's a little Makefile.

To make all the links, just run `make links`.
