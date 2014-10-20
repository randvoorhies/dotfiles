#!/usr/bin/env python 

import os
import sys
import platform
import subprocess
from collections import OrderedDict
from datetime import datetime 
from datetime import timedelta

try:
  from uptime import uptime
except ImportError:
  print "You need python-uptime to continue!"
  sys.exit(1)

try:
  from pyfiglet import Figlet
except ImportError:
  print "You need python-pyfiglet to continue!"
  sys.exit(1)

try:
  from termcolor import colored
except ImportError:
  print "You need python-termcolor to continue!"
  sys.exit(1)

def _colored(toggle, *args):
  if toggle:
    return colored(*args)
  return args[0]

def run_cmd(what):
  try:
    p = subprocess.Popen(what.split(), stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
    out, err = p.communicate()
    return {"returncode": p.returncode, "output": out.strip(), "error": err}
  except OSError:
    return {"returncode": 127, "output": "", "error": ""}

def get_platform_info():
  stats = OrderedDict([
    ('Hostname',     platform.node()),
    ('Distribution', " ".join(platform.dist())),
    ('Kernel',       platform.uname()[2]),
    ('Uptime',       str(timedelta(seconds=uptime()))),
    ('Load avg',     ", ".join([str(k) for k in os.getloadavg()]))
    ])
  return stats

def get_services_info(colorized):
  stats = OrderedDict([
    ('Dropbox',     "???"),
    ('SABnzbd+',    "???"),
    ('Plex',        "???"),
    ('Last backup', "???"),
    ])

  dropbox = run_cmd("dropbox status")
  if dropbox["returncode"] == 0:
    if dropbox["output"] == "Up to date":
      stats['Dropbox'] = _colored(colorized, "Running", "green")
    elif dropbox["output"] == "Dropbox isn't running!":
      stats['Dropbox'] = _colored(colorized, "Not running", "yellow")
    else:
      stats['Dropbox'] = _colored(colorized, dropbox["output"], "yellow")
  else:
    stats['Dropbox'] = _colored(colorized, "Not installed", "grey")

  sab = run_cmd("/etc/init.d/sabnzbdplus status")
  if sab["returncode"] == 0:
    stats['SABnzbd+'] = _colored(colorized, "Running", "green")
  elif sab["returncode"] == 3:
    stats['SABnzbd+'] = _colored(colorized, "Not running", "yellow")
  elif sab["returncode"] == 127:
    stats['SABnzbd+'] = _colored(colorized, "Not installed", "grey")

  plex = run_cmd("service plexmediaserver status")
  if plex["returncode"] == 0:
    if "start/running" in plex["output"]:
      stats['Plex'] = _colored(colorized, "Running", "green")
    elif "stop/waiting" in plex["output"]:
      stats['Plex'] = _colored(colorized, "Not running", "yellow")
  else:
    stats['Plex'] = _colored(colorized, "Not installed", "gray")

  rsnapshot = run_cmd("ls --full-time -ltr /srv/media/backups/snapshots/")
  if rsnapshot["returncode"] == 0:
    timestamp   = " ".join(rsnapshot["output"].split("\n")[-1].split(" ")[5:7])
    timestamp   = timestamp.split(".")[0]
    last_backup = datetime.strptime(timestamp, "%Y-%m-%d %H:%M:%S")

    if datetime.now() - last_backup > timedelta(days=1):
      stats['Last backup'] = _colored(colorized, "More than a day old! " + str(last_backup), "red")
    else:
      stats['Last backup'] = _colored(colorized, last_backup, "green")
  elif rsnapshot["returncode"] == 2:
    stats['Last backup'] = _colored(colorized, "Not found", "yellow")

  return stats

def print_tmux_sessions(colorized):
  tmux = run_cmd("tmux ls")

  if tmux["returncode"] == 0:
    tmux_sessions = []
    for session in tmux["output"].split("\n"):
      session_info = session.split(":")
      name = session_info[0]
      num_windows, _ = session_info[1].split("(")
      tmux_sessions.append((name, num_windows.strip()))
    
    lengths = [len(k[0]) for k in tmux_sessions]
    longest = max(lengths)
    
    print _colored(colorized, "        tmux", "cyan")
    for session, num_windows in tmux_sessions:
      if len(session) > 12:
        print "%12s   %s" % (session[:10] + "..", num_windows)
      else:
        print "%12s   %s" % (session, num_windows)

if __name__ == "__main__":
  import argparse
  parser = argparse.ArgumentParser()
  parser.add_argument("--no-services", "-s", action="store_true", default=False, help="Don't show the services (like Dropbox, etc)")
  parser.add_argument("--no-colors", "-c", action="store_false", default=True, help="Don't write colorized output")
  args = parser.parse_args()

  # platform 
  pl_info = get_platform_info()
  
  for key,val in pl_info.iteritems():
    print "%s   %s" % (_colored(args.no_colors, key.rjust(12), "cyan"), val)
  print
  
  # services
  if not args.no_services:
    services = get_services_info(args.no_colors)
    for key,val in services.iteritems():
      print "%s   %s" % (_colored(args.no_colors, key.rjust(12), "cyan"), val) 
    print
  
  # tmux info
  print_tmux_sessions(args.no_colors)

  # dotfiles git status
  dotfiles = run_cmd("check_dotfiles.sh")
  if dotfiles["returncode"] == 1:
    print colored("Your dotfiles are out of date.", "yellow")
