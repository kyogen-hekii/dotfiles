#!/bin/zsh

# ----------
# main
# ----------
main() {
  brew install cask
  brew install --cask karabiner-elements
  brew install --cask alfred

  # brew install sequel-ace

    # karabiner
    # https://karabiner-elements.pqrs.org/
    # cp ~/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json_bkup
    # alfred
    # https://www.alfredapp.com/
    # keyをoption+spaceに
    # Alfredのactionsとadvancedのctrl設定を無しにする(ctrl=caps)
    # https://t-yng.jp/post/alfred-ctrl-n
    # vscode
    # https://azure.microsoft.com/ja-jp/products/visual-studio-code/
    # hyperswitch
    # https://bahoom.com/hyperswitch
    # mapture
    # https://anatoo.jp/mapture/
    # 右クリックしてctrl+開く
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
