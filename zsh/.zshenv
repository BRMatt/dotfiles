#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Matt Button <that.matt.button@gmail.com>
#
export ZDOTDIR="$HOME/.zsh"
export EDITOR="/usr/bin/vim"
export PATH="$HOME/bin:$HOME/go/bin:$HOME/.dotfiles/bin:$HOME/local/bin:$PATH"
export IPLAYER_OUTDIR="/Users/mattbutton/Movies/iplayer"
export GOPATH="$HOME/go"

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE=
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"

export GOPATH="$HOME/development/golang"
export PATH="$GOPATH/bin:$PATH"
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
export PATH="$HOME/.cargo/bin:$PATH"

if [[ `uname` == 'Darwin' ]]
then
  export OSX=1
else
  export OSX=
fi