#!/usr/bin/python

import i3
import subprocess
import sys

if __name__ == '__main__':
    direction = str(sys.argv[1])
    xdo_cmd_dict = {
        'left': 'control+h',
        'down': 'control+j',
        'up': 'control+k',
        'right': 'control+l'
    }
    current = i3.filter(nodes=[], focused=True)[0]
    if 'GVIM' in current['name']:
        wid = current['window']
        xdotool_call = ["xdotool", "key", "--window", str(wid), xdo_cmd_dict[direction]]
        subprocess.call(xdotool_call)
    else:
        i3.focus(direction)
