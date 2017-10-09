#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

case $- in *i*)
    [ -z "$TMUX" ] && exec tmux
esac

genpasswd() { 
local l=$1
    [ "$l" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs 
}

export PATH="$PATH:/home/sbanks/.yarn/bin"
source <(kubectl completion bash)
complete -C '/usr/bin/aws_completer' aws

