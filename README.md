## dotfiles
A single place where I store all my dotfiles, and a handy script to set them up in new environments. Clone the repository wherever you want, then run `install.py`. The script will make symlinks to all the dotfiles in the cloned repository, and will make backups of any files before overwriting. If you add any files, make sure to source them in your `~/.bashrc` or whatever is appropriate for your shell! Updating dotfiles is as easy as pulling from git and re-running `install.py`.

If you want custom configurations depending on hostname, put them into the `hostnames` folder with the filename `hostname.install`. The setup script will only install the relevant files.
