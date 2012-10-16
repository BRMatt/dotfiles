#!/usr/bin/zsh

ZSH_THEME="fino"
DISABLE_AUTO_UPDATE="true"

plugins=(rails3 terminator thor github command-not-found rvm zsh-syntax-highlighting rbenv bundler)

source $HOME/.zshenv

source /etc/profile

source $ZSH/oh-my-zsh.sh
