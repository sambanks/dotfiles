#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


genpasswd() { 
local l=$1
    [ "$l" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs 
}

# Add Yarn Bin
#export PATH="$PATH:/home/sbanks/.yarn/bin"

#Android studio sdk
export PATH="$PATH:/home/sbanks/Android/Sdk"

# Add Aus Post Python Module Path for Wrappers
export PYTHONPATH="$PYTHONPATH:/home/sbanks/git/ap/aem_management/src/"
source <(kubectl completion bash)
complete -C '/usr/bin/aws_completer' aws

