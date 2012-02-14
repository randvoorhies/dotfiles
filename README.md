## dotfiles
A single place where I store all my dotfiles, and a handy script to set them up in new environments. Clone the repository wherever you want, then run `setup.py`. The script will make symlinks to all the dotfiles in the cloned repository, and will make backups of any files before overwriting. If you add any files, make sure to source them in your `~/.bashrc` or `~/.zshrc`! Updating dotfiles is as easy as pulling from git and re-running `setup.py`.

For setting up custom paths for your individual machines, you can create a ~/.pathrc which will be sourced by .zshrc and .bashrc. 