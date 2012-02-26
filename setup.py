#!/usr/bin/env python
import os, inspect

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

# Install oh-my-zsh if it doesnt already exist
if not os.path.exists(os.path.join(os.environ["HOME"], '.oh-my-zsh')):
  print 'Installing oh-my-zsh'
  os.system('curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh')

# Install every file that ends with 'rc' 
for dotfile in os.listdir(dotfilesdir):
  if dotfile[-2:] == "rc":
    installFile(dotfile, os.environ["HOME"])

# Create a new blank .pathrc if one doesnt exist
if not os.path.exists(os.path.join(os.environ["HOME"], '.pathrcc'))
  f = open(os.path.join(os.environ["HOME"], '.pathrcc'), 'w')
  f.write('# This file is for machine specific paths\n\n\n')
  f.write('# vim:syntax=sh')
  f.close()

