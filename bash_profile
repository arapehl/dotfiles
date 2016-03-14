#!/bin/bash

alias afterpull='bin/bootstrap; db; ctb'
alias b='bundle'
alias be='bundle exec'
alias bet='bundle exec ruby -Itest'
alias bi='bundle install --jobs 4'
alias bo='bundle open'
alias ct='ctags -R --languages=ruby --verbose=yes --exclude=.git --exclude=log .'
alias ctb='ctags -R --languages=ruby --verbose=yes --exclude=.git --exclude=log . $(bundle list --paths)'
alias db='be rake db:migrate; be rake lhm:run:all; be rake db:test:clone; be rake db:test:prepare'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gg='git grep -n -i'
alias gl='git log'
alias gp='git push'
alias gr='git rebase'
alias gs='git status'
alias gss='git stash show -p stash@{0}'
alias ls="ls -lahG"
alias morning="gco master; git pull origin master; afterpull"
alias rd="bundle exec rails dbconsole"
alias rdb="bundle exec rails dbconsole"
alias rs="bundle exec rails server"
alias rc="bundle exec rails console"
alias usm="git pull origin master; afterpull"
alias v='vi $(git ls-files -m --others --exclude-standard)'
alias vg="vagrant"
alias vssh='cd ~/dev/work/vagrant; vagrant ssh'

export EDITOR=vi

export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:"/Applications/Postgres.app/Contents/Versions/9.4/bin"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

prompt_callback() {
  # Colours
  # https://github.com/magicmonty/bash-git-prompt
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

  # Are we under vim?
  [[ $UNDER_VIM = "yes" ]] && VIM_CHECK="$LIGHT_RED[UNDER VIM]" || VIM_CHECK=""

  # Are we in a repo that should be running under vagrant?
  [[ ! $HOSTNAME =~ "vagrant" && $PWD =~ "vagrant" ]] && VAGRANT_CHECK=$LIGHT_RED || VAGRANT_CHECK=$LIGHT_GRAY

  # Set prompt
  #GIT_PROMPT_START=$VIMCHECK$IDENT$NO_COLOUR' \w'
  echo $VIM_CHECK$NO_COLOUR'[\h]'$VAGRANT_CHECK' \w'$NO_COLOUR
}

#opt into pry
export PRY=1

#bye bye turbo bar
export TDD=0

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

if [ -f ~/.custom_git_completion ]; then
  source ~/.custom_git_completion
fi

# https://github.com/magicmonty/bash-git-prompt
if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
  GIT_PROMPT_FETCH_REMOTE_STATUS=0
  GIT_PROMPT_START="\[\033[0m\]"
  GIT_PROMPT_THEME=Single_line
  source ~/.bash-git-prompt/gitprompt.sh
fi

# eval "$(rbenv init -)"
# export PATH="$HOME/.rbenv/shims:$PATH"

export NVM_DIR="/Users/ara/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
PATH="~/.themekit:$PATH"

if  [[ $HOSTNAME =~ "vagrant" ]]; then
  cd ~/src/shopify
fi
