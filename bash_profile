#!/bin/bash

alias b="bundle"
alias be="bundle exec"
alias ga='git add'                                                                                                                                                                   
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gg='git grep'
alias gp='git push'
alias gr='git rebase'
alias gs='git status'
alias ls="ls -lahG"
alias rd="bundle exec rails dbconsole"
alias rdb="bundle exec rails dbconsole"
alias rs="bundle exec rails server"
alias rc="bundle exec rails console"
alias v='vim -p $(git ls-files -m)'
alias vg="vagrant"
alias vssh='cd ~/dev/work/vagrant; vagrant ssh'

V=""
if [[ $UNDER_VIM = "yes" ]]; then
  V="\[\e[1;31m\][UNDER VIM]\[\033[00m\] "
fi

export PS1=$V"[\h] \W\\$ "
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#opt into pry
export PRY=1

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
if [ -f ~/.custom_git_completion ]; then
  . ~/.custom_git_completion
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
