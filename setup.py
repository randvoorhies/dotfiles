#!/usr/bin/env python
import os

def installFile(filename, dest):
  source = os.path.abspath(os.path.join(dotfilesdir, filename))
  destination = os.path.abspath(os.path.join(dest, '.'+filename[:-8]))

  if os.path.islink(destination):
    print 'Removing old symlink: ' + destination
    os.remove(destination)
  elif os.path.ispath(destination):
    print 'Backing up old file: ' + destination + ' to ' + destination + '.bak'
    os.rename(destination, destination + '.bak')

  print 'Installing ' + destination
  os.symlink(source, destination)

dotfilesdir = os.getcwd()
hostname = os.uname()[1].split('.')[0]

for dotfile in os.listdir(dotfilesdir):
  if dotfile[-7:] == "install":
    installFile(dotfile, os.path.join(os.environ["HOME"]))

for dotfile in os.listdir(dotfilesdir + '/hostnames'):
  if dotfile[-7:] == "install" and dotfile[:-8] == hostname:
    installFile(dotfile, os.path.join(os.environ["HOME"]))
