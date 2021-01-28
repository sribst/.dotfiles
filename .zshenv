path+=~/bin
path+=~/bin/tezos
path+=.

export GPG_TTY=$(tty)
export EDITOR="/usr/bin/emacsclient -nw"
export ALTERNATE_EDITOR="/usr/bin/nano"

export TMP=$HOME/tmp
export TEMP=$TMP
export TMPDIR=$TMP
export TMPPREFIX=${TMPDIR}/zsh

# remove tezos warning that we are in sandbox
export TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=Y

# ocaml global env
eval `opam config env`

# pyenv config
path+=$HOME/.pyenv/bin
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# disable warning message of opencv
export OPENCV_LOG_LEVEL=ERROR

#use gpg-agent instead of ssh-agent
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export PASSWORD_STORE_GPG_OPTS='--no-throw-keyids'
export TERM='xterm-256color'
