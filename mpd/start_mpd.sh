#!/usr/bin/env bash

sudo service mpd stop
[[ ! -d "/media/ext" ]] && sudo mkdir /media/ext
sudo mount -t ntfs /dev/sdb1 /media/ext
mpdscribble
mpd
