#!/bin/bash

#
# main
#
main() {
  # 準備
  if is_linux; then
    sudo apt -y update
    sudo apt -y upgrade
  fi
  if is_mac; then
    #TODO
  fi
  
  # - core -
  # make
  if ! is_exists 'make'; then
    #TODO
    sudo apt install make
  fi
  
  # zsh
  if ! is_zsh; then
    #TODO
    echo 'no_zsh'; return
  fi
  # 


  # nodebrew(https://github.com/hokaccha/nodebrew)
  if ! is_exists 'node'; then
    curl -L git.io/nodebrew | perl - setup
    export PATH=$HOME/.nodebrew/current/bin:$PATH
    source ~/.bashrc
    nodebrew install stable && nodebrew use stable
  fi
  
  # zsh関連
  #   pure(theme)※symlinkが貼れないから.zshrcにfpathに追加が必要
  npm install --global pure-prompt
  #   zinit
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  source ~/.zshrc
  zinit self-update
}

#
# methods
#

# utils
is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

# os
is_mac() {
    [ "$(uname)" = "Darwin" ]
}
is_linux() {
    [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]
}

# etc
is_zsh() {
    [ -n "$ZSH_VERSION" ]
}

#
# exec
#
main
