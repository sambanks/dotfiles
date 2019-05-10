#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Spotify hidpi
alias spotify="/usr/bin/spotify --force-device-scale-factor=2"

genpasswd() { 
local l=$1
    [ "$l" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs 
}

# Add personal Bin
export PATH="$PATH:/home/sbanks/bin"

# Mixbus
export PATH="$PATH:/opt/mixbus/bin"

#Android studio sdk
export PATH="$PATH:/home/sbanks/Android/Sdk/platform-tools"

source <(kubectl completion bash)
complete -C '/usr/bin/aws_completer' aws

# Add openssl path for python (qutebrowser) ssl support
export LD_LIBRARY_PATH=/usr/lib/openssl-1.0

export VISUAL=vim
export EDITOR=vim

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /home/sbanks/stackchat/git/hybrid-db-s3-storage-test/node_modules/tabtab/.completions/serverless.bash ] && . /home/sbanks/stackchat/git/hybrid-db-s3-storage-test/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /home/sbanks/stackchat/git/hybrid-db-s3-storage-test/node_modules/tabtab/.completions/sls.bash ] && . /home/sbanks/stackchat/git/hybrid-db-s3-storage-test/node_modules/tabtab/.completions/sls.bash
