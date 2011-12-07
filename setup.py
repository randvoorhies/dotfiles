#!/usr/bin/env python
import shutil, os, inspect

def installFile(filename):
  source = os.path.abspath(os.path.join(dotfilesdir, filename))
  destination = os.path.abspath(os.path.join(HOME, '.'+filename))
  print 'Installing ' + destination
  if os.path.exists(destination):
    if os.path.islink(destination):
      print '  Removing old symlink: ' + destination
      os.remove(destination)
    else:
      print '  Backing up old file: ' + destination + ' to ' + destination + '.bak'
      os.rename(destination, destination + '.bak')
  os.symlink(source, destination)

dotfilesdir = os.path.dirname(inspect.getfile(inspect.currentframe()))
HOME = os.environ["HOME"]

installFile('vimrc')

