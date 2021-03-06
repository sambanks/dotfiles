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
export PATH="/home/sbanks/bin:$PATH"

#Android studio sdk
export PATH="$PATH:/home/sbanks/Android/Sdk/platform-tools"

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

# The next line loads swingBot compute engine credentials
export GOOGLE_APPLICATION_CREDENTIALS="/home/sbanks/.gcoud/swingBotCompute.js"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/sbanks/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/sbanks/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/sbanks/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/sbanks/Downloads/google-cloud-sdk/completion.bash.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
