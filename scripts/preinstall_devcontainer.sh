
# TODO: 個別ファイルにせずまとめる

DOTFILES_PATH=~/dotfiles

main() {
  sudo dnf install -y util-linux-user which make ripgrep fd-find gcc cmake pkg-config libssl-dev

  sudo dnf install -y zsh
  chsh -s $(which zsh)
  # 戻すとき: sudo /bin/chsh /bin/sh

  curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y
  export PATH=$HOME/.cargo/bin:$PATH
  cargo install eza exa bat tre-command

  cargo install starship --locked
  [ ! -d ~/.config ] && mkdir ~/.config
  cp $DOTFILES_PATH/config/starship_initial.toml ~/.config/starship.toml

  cargo install sheldon --locked
  [ ! -d ~/.config/sheldon ] && mkdir ~/.config/sheldon
  cp $DOTFILES_PATH/config/sheldon_plugins_initial.toml ~/.config/sheldon/plugins.toml

}

main
