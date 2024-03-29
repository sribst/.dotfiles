# .zshrc
# Author: Sylvain Ribstein

source ~/.config/zsh.d//antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle lein
antigen bundle command-not-found
antigen bundle agkozak/zsh-z
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle djui/alias-tips
antigen bundle mollifier/anyframe
antigen bundle MichaelAquilina/zsh-auto-notify
antigen bundle unixorn/fzf-zsh-plugin@main
antigen bundle Tarrasch/zsh-autoenv

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# antigen bundle unixorn/fzf-zsh-plugin
# antigen bundle zsh-users/zsh-history-substring-search

# Load the theme.
antigen theme dogenpunk

# Tell Antigen that you're done.
antigen apply
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_FUZZY=true

# opam configuration

test -r /home/baroud/.opam/opam-init/init.zsh && . /home/baroud/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias private='/usr/bin/git --git-dir=/home/sribaroud/.private/ --work-tree=/home/sribaroud'
alias tezt='dune exec tezt/tests/main.exe --' # tezos test framework
alias teztether='dune exec etherlink/tezt/tests/main.exe --' # tezos test framework

# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
