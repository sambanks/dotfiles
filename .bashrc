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
export PATH="$PATH:/home/sbanks/Android/Sdk/platform-tools"

# Add Aus Post Python Module Path for Wrappers
source <(kubectl completion bash)
complete -C '/usr/bin/aws_completer' aws

# Add openssl path for python (qutebrowser) ssl support
export LD_LIBRARY_PATH=/usr/lib/openssl-1.0

export VISUAL=vim
export EDITOR=vim
