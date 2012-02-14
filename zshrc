# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(osx cloudapp sprunge vi-mode svn git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# More extensive tab completion. 
autoload -U compinit
compinit

# Better completion for killall.
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# One history for all open shells; store 10,000 entires.
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt incappendhistory 
setopt sharehistory
setopt extendedhistory

# Ctrl-R backwards search
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# Re-load .zshrc
alias rez="source ${HOME}/.zshrc"

# source extra stuff
source $HOME/.envrc
source $HOME/.aliasrc
if [ -f ${HOME}/.pathrc ];
then
  source ~/.pathrc
fi