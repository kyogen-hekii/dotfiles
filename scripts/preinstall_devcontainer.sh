
# TODO: 個別ファイルにせずまとめる

main() {
  if ! is_exists zsh; then
    # zsh
    sudo apt install zsh
    chsh -s $(which zsh)
    # 戻すとき: sudo /bin/chsh /bin/sh
  fi
}

# utils
is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

main
