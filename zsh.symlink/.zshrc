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

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# custom stuff

alias ll="ls -alF --color=auto"
alias bi="bundle install"
alias be="bundle exec"
alias rspc="bundle exec rspec"
alias rls="bundle exec rails"

# config that's specific to this machine
# e.g.
#
# cdpath=(
#   ~/development
#   ~/development/golang/src/github.com/geckoboard
#   $cdpath
# )
[[ -a "${HOME}/.localrc.zsh" ]] && source "${HOME}/.localrc.zsh"

if [[ -s /usr/local/share/chruby/chruby.sh ]]; then
  . /usr/local/share/chruby/chruby.sh

  chruby ruby-2.0

  . /usr/local/share/chruby/auto.sh
fi

# Use fuzzy finder completion for history search etc.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
