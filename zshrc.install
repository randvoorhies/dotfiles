# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export DISABLE_AUTO_UPDATE="true"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

export DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(osx cloudapp sprunge vi-mode svn git brew)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# More extensive tab completion. 
autoload -U compinit
compinit

# Better completion for killall.
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# One history for all open shells; store 10,000 entires.
#HISTFILE=~/.zhistory
#HISTSIZE=SAVEHIST=10000
#setopt incappendhistory 
#setopt sharehistory
#setopt extendedhistory

# Fix some crappy vi-mode keybindings
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[kcuu1]}" up-line-or-history
bindkey "${terminfo[kcud1]}" down-line-or-history
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# Re-load .zshrc
alias rez="source ${HOME}/.zshrc"

# source extra stuff
source ${HOME}/.envrc 
source ${HOME}/.aliasrc 

# Source the optional pathrc file for machine specific paths
if [ -f ${HOME}/.pathrc ];
then
  source ${HOME}/.pathrc
fi


function nrtcd() 
{
  cd `find ${NRTMODULEPATH} -type d -name ${1}`
}

function nrtcdcompletion() {
  reply=()
  for directory in ${NRTMODULEPATH}/**/manifest.yaml
  do
    fulldirectory=`dirname ${directory}`
    modulename=`basename ${fulldirectory}`
    reply+=($modulename)
  done
}
compctl -K nrtcdcompletion nrtcd

# vim:syntax=zsh
