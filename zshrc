# first check that oh-my-zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh-my-zsh not installed! Installing now..."
  git clone https://github.com/sagargp/oh-my-zsh.git $HOME/.oh-my-zsh
fi

DISABLE_AUTO_UPDATE=true

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sagar"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(sprunge svn git rvm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# Colors for ls
if [[ -x "`whence -p dircolors`" ]]; then
  eval `dircolors`
  alias ls='ls -G --color=auto'
else
  alias ls='ls -G'
fi

# More extensive tab completion. 
autoload -U compinit
compinit

# Better completion for killall.
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# Fix some crappy vi-mode keybindings
# bindkey -M viins '^r' history-incremental-search-backward
# bindkey -M vicmd '^r' history-incremental-search-backward

# extensions
# better mv command
autoload zmv

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name 

autoload -Uz compinit
compinit -d $HOME/.zsh/dumpfile 
# End of lines added by compinstall

# Re-load .zshrc
alias rez="source ${HOME}/.zshrc"

# source extra stuff
source $HOME/.envrc
source $HOME/.aliasrc

# source hostname specific configs
custom="$HOME/.$(hostname -s)rch"
if [ -f $custom ]; then
  source $custom
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
