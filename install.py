#!/usr/bin/env python
import os

special = {}
special["notes.vim"] = os.path.abspath(os.path.join(os.environ["HOME"], ".vim/syntax/notes.vim"))

def remove(dry_run, what):
  print "rm %s" % what
  if not dry_run:
    os.remove(what)

def rename(dry_run, what, where):
  print "mv %s %s" % (what, where)
  if not dry_run:
    os.rename(what, where)

def symlink(dry_run, what, where):
  print "ln -s %s %s" % (what, where)
  if not dry_run:
    os.symlink(what, where)

def install_file(dry_run, filename, dest):
  file = os.path.basename(filename)

  if file in special:
    destination = special[file]

  elif file.endswith(".install"):
    destination = os.path.abspath(os.path.join(dest, "."+file[:-8]))

  if os.path.islink(destination):
    remove(dry_run, destination)

  elif os.path.exists(destination):
    rename(dry_run, destination, destination + ".bak")

  if not os.path.exists(os.path.dirname(destination)):
    print "\nWarning: %s doesn't exist. Skipping installation of %s!\n" % (os.path.dirname(destination), filename)
  else:
    source = os.path.abspath(os.path.join(dotfilesdir, filename))
    symlink(dry_run, source, destination)

if __name__ == "__main__":
  import optparse

  o = optparse.OptionParser(description="Install all dotfiles into your home folder")
  o.add_option("--dry-run", "-n", action="store_true", help="Don't actually run anything")
  options, args = o.parse_args()

  dotfilesdir = os.getcwd()
  sysname, hostname, release, version, machine = os.uname()

  for dotfile in os.listdir(dotfilesdir):
    if dotfile.endswith("install") or dotfile in special:
      install_file(options.dry_run, dotfile, os.path.join(os.environ["HOME"]))

  for dotfile in os.listdir(os.path.join(dotfilesdir, "hostnames")):
    if dotfile.endswith("install") and dotfile.startswith(hostname):
      install_file(options.dry_run, os.path.join(dotfilesdir, "hostnames", dotfile), os.path.join(os.environ["HOME"]))
