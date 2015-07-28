#!/bin/bash

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

if [ -f ~/.custom_git_completion ]; then
  source ~/.custom_git_completion
fi

# https://github.com/magicmonty/bash-git-prompt
if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
  GIT_PROMPT_THEME=Single_line
  source ~/.bash-git-prompt/gitprompt.sh
fi

alias b="bundle"
alias be="bundle exec"
alias best="bundle exec spring testunit"
alias bi="bundle install --jobs 4"
alias bo="bundle open"
alias ga='git add'                                                                                                                                                                   
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gg='git grep'
alias gl='git log'
alias gp='git push'
alias gr='git rebase'
alias gs='git status'
alias ls="ls -lahG"
alias rd="bundle exec rails dbconsole"
alias rdb="bundle exec rails dbconsole"
alias rs="bundle exec rails server"
alias rc="bundle exec rails console"
alias v='vim -p $(git ls-files -m --others --exclude-standard)'
alias vg="vagrant"
alias vssh='cd ~/dev/work/vagrant; vagrant ssh'

export EDITOR=vim

export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

prompt () {
  # Colours
  local BLACK="\[\033[0;30m\]"
  local DARK_GRAY="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local LIGHT_RED="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local BROWN="\[\033[0;33m\]"
  local YELLOW="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local LIGHT_BLUE="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local LIGHT_PURPLE="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local LIGHT_CYAN="\[\033[1;36m\]"
  local LIGHT_GRAY="\[\033[0;37m\]"
  local WHITE="\[\033[1;37m\]"
  local NO_COLOUR="\[\033[0m\]"

  VIMCHECK=""
  if [[ $UNDER_VIM = "yes" ]]; then
    VIMCHECK="$LIGHT_RED[UNDER VIM]"
  fi

  [[ $HOSTNAME == "GLaDOS.local" ]] && IDENT=$LIGHT_RED"[\h]" || IDENT=$GREEN"[\h]"

  #PS1=$VIMCHECK$IDENT$LIGHT_GRAY' \w'$BROWN'$(__git_ps1 ":%s")'$NO_COLOUR' \$ '
  GIT_PROMPT_START=$VIMCHECK$IDENT$NO_COLOUR' \w'
}
prompt


#opt into pry
export PRY=1

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
