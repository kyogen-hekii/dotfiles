
# TODO: 個別ファイルにせずまとめる

DOTFILES_PATH=~/dotfiles

main() {
  sudo dnf install -y util-linux-user which make gcc cmake openssl-devel

  sudo dnf install -y zsh
  sudo chsh -s $(which zsh)
  # 戻すとき: sudo /bin/chsh /bin/sh

  DOT_DIRECTORY="$HOME/dotfiles"
  for rcfile_fullpath in $DOT_DIRECTORY/.??*; do
    # 前方一致でパターン削除
    rcfile=${rcfile_fullpath##*/}

    # 不要ファイルを無視
    [[ $rcfile = ".git" ]] && continue
    [[ $rcfile = ".gitignore" ]] && continue

    # シンボリックリンク作成
    ln -snfv "$DOT_DIRECTORY/$rcfile" "$HOME/$rcfile"
  done

  curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y
  export PATH=$HOME/.cargo/bin:$PATH
  cargo install eza exa bat tre-command

  cargo install starship --locked
  [ ! -d ~/.config ] && mkdir ~/.config
  cp $DOTFILES_PATH/config/starship_initial.toml ~/.config/starship.toml

  cargo install sheldon --locked
  [ ! -d ~/.config/sheldon ] && mkdir ~/.config/sheldon
  cp $DOTFILES_PATH/config/sheldon_plugins_initial.toml ~/.config/sheldon/plugins.toml

  eval "$(starship init zsh)"

  autoload -Uz compinit
  compdef
  eval "$(sheldon source)"
}

prepare_font() {
  mkdir ~/tmp
  curl -L https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip --output ~/tmp/HackGen_NF.zip
  # unzipはworkdirに作られる
  unzip ~/tmp/HackGen_NF.zip
  rm ~/tmp/HackGen_NF.zip
  sudo mkdir /usr/local/share/fonts
  sudo mv HackGen_NF_v2.9.0 /usr/local/share/fonts/HackGen_NF
  fc-cache -fv
}

main
prepare_font
