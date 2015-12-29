#!/usr/bin/env python
import re
import sys
import os

def main():
    path = os.getcwd().decode('utf-8')
    rename_flacs(path)
    rename_covers(path)

def rename_flacs(current_directory):
    for flac_file in [f for f in os.listdir(current_directory) if f.endswith('.flac')]:
        match = re.search(r'(\-\s[0-9][0-9])', flac_file)
        start = match.start(1) + 2
        rename_file(current_directory, flac_file, start)

def rename_covers(current_directory):
    for cover in [f for f in os.listdir(current_directory) if f.endswith(('.png', '.jpg', '.gif'))]:
        start = cover.rfind('-')
        if start != -1:
            start += 2
            rename_file(current_directory, cover, start)

def rename_file(folder, source_file, start):
    destination_file = source_file[start:].replace(' ', '_')
    destination_file = destination_file.replace("'", '_')
    destination_file = destination_file.replace('"', '_')
    os.rename(os.path.join(folder, source_file), os.path.join(folder, destination_file))

if __name__ == '__main__':
    sys.exit(main())
