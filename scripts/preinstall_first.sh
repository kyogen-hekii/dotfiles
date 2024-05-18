#!/bin/bash

# ----------
# main
# ----------
main() {
  # 準備
  if is_linux; then
    sudo apt -y update
    sudo apt -y upgrade
    # zsh
    if ! is_exists zsh; then
      sudo apt install zsh
      chsh -s $(which zsh)
    fi
  fi
  if is_mac; then
    # brew
    if ! is_exists 'brew'; then
      xcode-select --install
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    # zsh
    if ! is_exists zsh; then
      brew isntall zsh
      chsh -s $(which zsh)
    fi
    # karabiner
    # https://karabiner-elements.pqrs.org/
    # cp ~/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json_bkup
    # alfred
    # https://www.alfredapp.com/
    # Alfredのactionsとadvancedのctrl設定を無しにする(ctrl=caps)
    # vscode
    # https://azure.microsoft.com/ja-jp/products/visual-studio-code/
    # hyperswitch
    # https://bahoom.com/hyperswitch
    # mapture
    # https://anatoo.jp/mapture/
    # 右クリックしてctrl+開く
  fi
}

# ----------
# methods
# ----------

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
    # [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]
    [[ "$(uname)" =~ Linux ]]
}

# ----------
# exec
# ----------
main
@echo zshをinstallしました。これ以降はzshを使用してください。
