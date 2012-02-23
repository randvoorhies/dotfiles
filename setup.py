#!/usr/bin/env python
import os

def installFile(filename, dest):
  source = os.path.abspath(os.path.join(dotfilesdir, filename))
  destination = os.path.abspath(os.path.join(dest, '.'+filename))
  if os.path.exists(destination):
    if os.path.islink(destination):
      print 'Removing old symlink: ' + destination
      os.remove(destination)
    else:
      print 'Backing up old file: ' + destination + ' to ' + destination + '.bak'
      os.rename(destination, destination + '.bak')
  print 'Installing ' + destination
  os.symlink(source, destination)

dotfilesdir = os.getcwd()
hostname = os.uname()[1].split('.')[0]

for dotfile in os.listdir(dotfilesdir):
  if dotfile[-2:] == "rc" or dotfile[:-3] == hostname:
    installFile(dotfile, os.environ["HOME"])
