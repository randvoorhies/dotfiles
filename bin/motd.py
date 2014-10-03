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

def get_services_info():
  stats = OrderedDict([
    ('Dropbox',     "???"),
    ('SABnzbd+',    "???"),
    ('Last backup', "???"),
    ('Mail',        "???")
    ])

  dropbox = run_cmd("dropbox status")
  if dropbox["returncode"] == 0:
    if dropbox["output"] == "Up to date":
      stats['Dropbox'] = colored("Up to date", "green")
    else:
      stats['Dropbox'] = colored(dropbox["output"], "yellow")
  else:
    stats['Dropbox'] = colored("Not installed", "grey")

  sab = run_cmd("/etc/init.d/sabnzbdplus status")
  if sab["returncode"] == 0:
    stats['SABnzbd+'] = colored(sab["output"].split(":")[-1].strip().capitalize(), "green")
  elif sab["returncode"] == 3:
    stats['SABnzbd+'] = colored(sab["output"].split(":")[-1].strip().capitalize(), "yellow")
  elif sab["returncode"] == 127:
    stats['SABnzbd+'] = colored("Not installed", "grey")

  rsnapshot = run_cmd("ls --full-time -ltr /media/foo/backups/snapshots/")
  if rsnapshot["returncode"] == 0:
    timestamp   = " ".join(rsnapshot["output"].split("\n")[-1].split(" ")[5:7])
    timestamp   = timestamp.split(".")[0]
    last_backup = datetime.strptime(timestamp, "%Y-%m-%d %H:%M:%S")

    if datetime.now() - last_backup > timedelta(days=1):
      stats['Last backup'] = colored("More than a day old! " + str(last_backup), "red")
    else:
      stats['Last backup'] = colored(last_backup, "green")
  elif rsnapshot["returncode"] == 2:
    stats['Last backup'] = colored("Not found", "yellow")

  return stats

def print_tmux_sessions():
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
    
    print colored("        tmux", "cyan")
    for session, num_windows in tmux_sessions:
      if len(session) > 12:
        print "%12s   %s" % (session[:10] + "..", num_windows)
      else:
        print "%12s   %s" % (session, num_windows)

if __name__ == "__main__":
  import argparse
  parser = argparse.ArgumentParser()
  parser.add_argument("--no-services", "-s", action="store_true", default=False, help="Don't show the services (like Dropbox, etc)")
  args = parser.parse_args()

  # platform 
  pl_info = get_platform_info()
  #print Figlet(font="standard").renderText(pl_info['hostname']).strip()
  #print
  
  for key,val in pl_info.iteritems():
    print "%s   %s" % (colored(key.rjust(12), "cyan"), val)
  print
  
  # services
  if not args.no_services:
    services = get_services_info()
    for key,val in services.iteritems():
      print "%s   %s" % (colored(key.rjust(12), "cyan"), val) 
    print
  
  # tmux info
  print_tmux_sessions()

  # dotfiles git status
  dotfiles = run_cmd("check_dotfiles.sh")
  if dotfiles["returncode"] == 1:
    print colored("Your dotfiles are out of date.", "yellow")
