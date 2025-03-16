#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

zmodload zsh/zprof

export TERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1

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

[ -f ~/.asdf/plugins/golang/set-env.zsh ] && . ~/.asdf/plugins/golang/set-env.zsh

if (( $+commands[go] )); then
  # Recent versions of go default to ~/go, but it's useful to set this
  # environment variable to make it easier to cd into the gopath
  export GOPATH="$(go env GOPATH)"
  export PATH="$GOPATH/bin:$PATH"
fi;

export PATH="$HOME/.cargo/bin:$PATH"

# Use fuzzy finder completion for history search etc.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

command -v starship &>/dev/null && eval "$(starship init zsh)"

command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

command -v brew &>/dev/null && eval "ASDF_DIR=\"$(brew --prefix asdf)/libexec\""

export ASDF_GOLANG_MOD_VERSION_ENABLED=true

[ -f $ASDF_DIR/asdf.sh ] && . $ASDF_DIR/asdf.sh
autoload -Uz compinit && compinit

[ -f ~/.asdf/plugins/golang/set-env.zsh ] && . ~/.asdf/plugins/golang/set-env.zsh

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

zprof
