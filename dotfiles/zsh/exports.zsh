###############################################################################
## Go Exports                                                                ##
###############################################################################

export GOPATH=~/dev/go
export PATH=$PATH:$GOPATH/bin

go_test() {
  go test $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

###############################################################################
## Rust/Cargo Exports                                                        ##
###############################################################################

export PATH=$PATH:$HOME/.cargo/bin

###############################################################################
## user bin Exports                                                          ##
###############################################################################

export PATH=$PATH:$HOME/bin

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

###############################################################################
## asdf                                                                      ##
###############################################################################

if test -f /opt/asdf-vm/asdf.sh; then
  . /opt/asdf-vm/asdf.sh
fi

if test -f /opt/homebrew/opt/asdf/libexec/asdf.sh; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

###############################################################################
## Auto load completion                                                      ##
###############################################################################

autoload -U compinit
compinit -i

###############################################################################
## Seup direnv                                                               ##
###############################################################################

eval "$(direnv hook zsh)"

###############################################################################
## Setup ssh-agent                                                           ##
###############################################################################

if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval "$(ssh-agent -s)"
  ssh-add
fi

###############################################################################
## alias's                                                                   ##
###############################################################################

# Kubernetes log with follow and tail of 10
alias kubel10='kubectl logs -f --tail 10'

alias kubedp='kubectl delete pod'

alias kubegp='kubectl get pod'

alias kubegd='kubectl get deployment'

alias kubegs='kubectl get service'

