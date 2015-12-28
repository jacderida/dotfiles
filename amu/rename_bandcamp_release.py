#!/usr/bin/env python
import sys
import os

def main():
    path = os.getcwd().decode('utf-8')
    for flac_file in [f for f in os.listdir(path) if f.endswith('.flac')]:
        start = flac_file.rfind('-')
        start += 2
        destination_file = flac_file[start:].replace(' ', '_')
        destination_file = destination_file.replace("'", '_')
        destination_file = destination_file.replace('"', '_')
        os.rename(os.path.join(path, flac_file), os.path.join(path, destination_file))

if __name__ == '__main__':
    sys.exit(main())
