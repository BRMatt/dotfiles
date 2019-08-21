#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

export TERM=xterm-256color

#BASE16_SCHEME="default"
#BASE16_SHELL="$HOME/.zsh/base16-shell/base16-$BASE16_SCHEME.dark.sh"
#[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

[[ -f "/etc/profile" ]] && source /etc/profile

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ "$OSX" == "1" ]] then
  alias ll="ls -a -l -F"
else
  alias ll="ls -a -l -F --color=auto"
fi

# Setup autojump
if [[ -s /usr/share/autojump/autojump.sh ]]; then
  . /usr/share/autojump/autojump.sh
elif [[ -s ~/.autojump/etc/profile.d/autojump.zsh ]]; then
  . ~/.autojump/etc/profile.d/autojump.zsh
fi

[[ -a "${ZDOTDIR:-$HOME}/.localrc.zsh" ]] && source "${ZDOTDIR:-$HOME}/.localrc.zsh"

if [[ -s /usr/local/share/chruby/chruby.sh ]]; then
  . /usr/local/share/chruby/chruby.sh

  . /usr/local/share/chruby/auto.sh
fi

# Use fuzzy finder completion for history search etc.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
