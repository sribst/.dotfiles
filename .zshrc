# .zshrc
# Author: Piotr Karbowski <piotr.karbowski@gmail.com>
# License: beerware

# Basic zsh config.
umask 077
ZDOTDIR=${ZDOTDIR:-${HOME}}
ZSHDDIR="${HOME}/.config/zsh.d"
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE='10000'
SAVEHIST="${HISTSIZE}"


# if [ ! -d "${TMP}" ]; then mkdir "${TMP}"; fi

# if ! [[ "${PATH}" =~ "^${HOME}/bin" ]]; then
#     export PATH="${HOME}/bin:${PATH}"
# fi


# Colors.
red='\e[0;31m'
RED='\e[1;31m'
green='\e[0;32m'
GREEN='\e[1;32m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
blue='\e[0;34m'
BLUE='\e[1;34m'
purple='\e[0;35m'
PURPLE='\e[1;35m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'

# Functions
if [ -f '/etc/profile.d/prll.sh' ]; then
    . "/etc/profile.d/prll.sh"
fi

over_ssh() {
    if [ -n "${SSH_CLIENT}" ]; then
	return 0
    else
	return 1
    fi
}

reload () {
    exec "${SHELL}" "$@"
}

begin_with() {
    local string="${1}"
    shift
    local element=''
    for element in "$@"; do
	if [[ "${string}" =~ "^${element}" ]]; then
	    return 0
	fi
    done
    return 1

}

termtitle() {
    case "$TERM" in
	rxvt*|xterm|nxterm|gnome|screen|screen-*)
	    local prompt_host="${(%):-%m}"
	    local prompt_user="${(%):-%n}"
	    local prompt_char="${(%):-%~}"
	    case "$1" in
		precmd)
		    printf '\e]0;%s@%s: %s\a' "${prompt_user}" "${prompt_host}" "${prompt_char}"
		    ;;
		preexec)
		    printf '\e]0;%s [%s@%s: %s]\a' "$2" "${prompt_user}" "${prompt_host}" "${prompt_char}"
		    ;;
	    esac
	    ;;
    esac
}

git_check_if_worktree() {
    # This function intend to be only executed in chpwd().
    # Check if the current path is in git repo.

    # We would want stop this function, on some big git repos it can take some time to cd into.
    if [ -n "${skip_zsh_git}" ]; then
	git_pwd_is_worktree='false'
	return 1
    fi
    # The : separated list of paths where we will run check for git repo.
    # If not set, then we will do it only for /root and /home.
    if [ "${UID}" = '0' ]; then
	# running 'git' in repo changes owner of git's index files to root, skip prompt git magic if CWD=/home/*
	git_check_if_workdir_path="${git_check_if_workdir_path:-/root:/etc}"
    else
	git_check_if_workdir_path="${git_check_if_workdir_path:-/home}"
	git_check_if_workdir_path_exclude="${git_check_if_workdir_path_exclude:-${HOME}/_sshfs}"
    fi

    if begin_with "${PWD}" ${=git_check_if_workdir_path//:/ }; then
	if ! begin_with "${PWD}" ${=git_check_if_workdir_path_exclude//:/ }; then
	    local git_pwd_is_worktree_match='true'
	else
	    local git_pwd_is_worktree_match='false'
	fi
    fi

    if ! [ "${git_pwd_is_worktree_match}" = 'true' ]; then
	git_pwd_is_worktree='false'
	return 1
    fi

    # todo: Prevent checking for /.git or /home/.git, if PWD=/home or PWD=/ maybe...
    #	damn annoying RBAC messages about Access denied there.
    if [ -d '.git' ] || [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
	git_pwd_is_worktree='true'
	git_worktree_is_bare="$(git config core.bare)"
    else
	unset git_branch git_worktree_is_bare
	git_pwd_is_worktree='false'
    fi
}

git_branch() {
    git_branch="$(git symbolic-ref HEAD 2>/dev/null)"
    git_branch="${git_branch##*/}"
    git_branch="${git_branch:-no branch}"
}

git_dirty() {
    if [ "${git_worktree_is_bare}" = 'false' ] && [ -n "$(git status --untracked-files='no' --porcelain)" ]; then
	git_dirty='%F{red}'
    else
	git_dirty='%F{green}'
    fi
}

precmd() {
    # Set terminal title.
    termtitle precmd

    # No git under remote directory, because of sshfs zsh incompatibility
    if [ "${git_pwd_is_worktree}" = 'true' ] && ! grep "remote" <<< $PWD &> /dev/null; then
	git_branch
	git_dirty
	is_git="${git_dirty}${git_branch} "
    else
	unset is_git
    fi
}

preexec() {
    # Set terminal title along with current executed command pass as second argument
    termtitle preexec "${(V)1}"
}

chpwd() {
    git_check_if_worktree
}

man() {
    if command -v vimmanpager >/dev/null 2>&1; then
	PAGER="vimmanpager" command man "$@"
    else
	command man "$@"
    fi
}

# Are we running under grsecurity's RBAC?
rbac_auth() {
    local auth_to_role='admin'
    if [ "${USER}" = 'root' ]; then
	if ! grep -qE '^RBAC:' "/proc/self/status" && command -v gradm > /dev/null 2>&1; then
	    echo -e "\n${BLUE}*${NC} ${GREEN}RBAC${NC} Authorize to '${auth_to_role}' RBAC role."
	    gradm -a "${auth_to_role}"
	fi
    fi
}
#rbac_auth

# Le features!
# extended globbing, awesome!
setopt extendedGlob

# zmv -  a command for renaming files by means of shell patterns.
autoload -U zmv

# zargs, as an alternative to find -exec and xargs.
autoload -U zargs

# Turn on command substitution in the prompt (and parameter expansion and arithmetic expansion).
setopt promptsubst

# Control-x-e to open current line in $EDITOR, awesome when writting functions or editing multiline commands.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Include user-specified configs.
if [ ! -d "${ZSHDDIR}" ]; then
    mkdir -p "${ZSHDDIR}" && echo "# Put your user-specified config here." > "${ZSHDDIR}/example.zsh"
fi

for zshd in $(ls -A ${HOME}/.config/zsh.d/^*.(z)sh$); do
    . "${zshd}"
done

# Completion.
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# If running as root and nice >0, renice to 0.
if [ "$USER" = 'root' ] && [ "$(cut -d ' ' -f 19 /proc/$$/stat)" -gt 0 ]; then
    renice -n 0 -p "$$" && echo "# Adjusted nice level for current shell to 0."
fi

ifroot="%(#,%F{cyan},%F{blue})"
op="%F{yellow}[${ifroot}"
cp="%F{yellow}]${ifroot}"

# Fancy prompt.
if over_ssh && [ -z "${TMUX}" ]; then
    remote_prompt='%F{red}SSH'
elif over_ssh; then
    remote_prompt='%F{253}SSH'
else
    unset remote_prompt
fi

#Smiley depending of last command
smiley='%(?,%B%F{green}:)%f,%B%F{red}:(%f)%b'

PROMPT='${ifroot}╭--${op}${smiley}${cp}%(?..--${op}%?${cp})--${op}${is_git}${remote_prompt}%~${cp}
${ifroot}╰--${op}%n%f${cp}-->%b%f%k'
PROMPT2='${op}%_${cp}>'

# Ignore lines prefixed with '#'.
setopt interactivecomments

# Ignore duplicate in history.
setopt hist_ignore_dups

# Prevent record in history entry if preceding them with at least one space
setopt hist_ignore_space

# Nobody need flow control anymore. Troublesome feature.
#stty -ixon
setopt noflowcontrol

# Aliases
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias l="ls -v"
alias ll="ls -l"
alias la="ls -a"

alias cp='cp -iv'
alias rcp='rsync -v --progress'
alias rmv='rsync -v --progress --remove-source-files'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias ln='ln -v'
alias chmod="chmod -c"
alias chown="chown -c"

alias ".."="cd .."

alias e="emacsclient"

alias sudo='sudo'               # to have alias within sudo
alias suspend='systemctl suspend'
alias poweroff='systemctl poweroff'
alias halt='systemctl halt'
alias reboot='systemctl reboot'

alias meteo='curl wttr.in/Lyon'
alias moon='curl wttr.in/moon'
alias clock='tty-clock -c -C 1 -B -s -x'
alias email='emacsclient -c --eval "(gnus)"'

if command -v colordiff > /dev/null 2>&1; then
    alias diff="colordiff -Nuar"
else
    alias diff="diff -Nuar"
fi

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias diff='diff --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias privateconf='/usr/bin/git --git-dir=$HOME/.private/ --work-tree=$HOME'
typeset -A key

# Emacs key binding
bindkey -e

# Keys.
case $TERM in
    rxvt*|xterm*)
	bindkey "^[[7~" beginning-of-line #Home key
	bindkey "^[[8~" end-of-line #End key
	bindkey "^[[3~" delete-char #Del key
	bindkey "^[[A" history-beginning-search-backward #Up Arrow
	bindkey "^[[B" history-beginning-search-forward #Down Arrow
	bindkey "^[Oc" forward-word # control + right arrow
	bindkey "^[Od" backward-word # control + left arrow
	bindkey "^H" backward-kill-word # control + backspace
	bindkey "^[[3^" kill-word # control + delete
	;;
esac

bindkey "^p" history-beginning-search-backward #Up Arrow
bindkey "^n" history-beginning-search-forward #Down Arrow

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

if [ -f ~/.alert ]; then cat ~/.alert; fi

# opam configuration
test -r /home/baroud/.opam/opam-init/init.zsh && . /home/baroud/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#To save every command before it is executed (this is different from bash's history -a solution):
setopt inc_append_history

#To retrieve the history file everytime history is called upon.
setopt share_history

# clipboard

x-copy-region-as-kill () {
    zle copy-region-as-kill
    print -rn $CUTBUFFER | xsel -i -b
}
zle -N x-copy-region-as-kill

x-kill-region () {
    zle kill-region
    print -rn $CUTBUFFER | xsel -i -b
}
zle -N x-kill-region

x-yank () {
    CUTBUFFER=$(xsel -o -b </dev/null)
    zle yank
}
zle -N x-yank
bindkey -e '\ew' x-copy-region-as-kill
bindkey -e '^W' x-kill-region
bindkey -e '^Y' x-yank


# Only load Liquid Prompt in interactive shells, not from a script or from scp
# [[ $- = *i* ]] && source liquidprompt
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# remove tezos warning for sandbox
export TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=Y
export EDITOR='emacsclient -nw'

export PASSWORD_STORE_GPG_OPTS='--no-throw-keyids'

# add shh to yubico gpg
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
# disable warning message of opencv
export OPENCV_LOG_LEVEL=ERROR

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip3
# pip zsh completion end
