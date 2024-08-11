# starship
if is_linux; then
  sudo apt install -y cmake pkg-config libssl-dev
fi
if is_mac; then
  brew install cmake pkg-config
fi
cargo install starship --locked
# 以下で設定
# eval "$(starship init zsh)"
# 設定
# code ~/.config/starship.toml
[ ! -d ~/.config ] && mkdir ~/.config
cp ./config/starship_initial.toml ~/.config/starship.toml

# sheldon
cargo install sheldon --locked
# 以下で設定
# eval "$(sheldon source)"
# 設定
# code ~/.config/sheldon/plugins.toml
[ ! -d ~/.config/sheldon ] && mkdir ~/.config/sheldon
cp ./config/sheldon_plugins_initial.toml ~/.config/sheldon/plugins.toml

# os
is_mac() {
    [ "$(uname)" = "Darwin" ]
}
is_linux() {
    # [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]
    [[ "$(uname)" =~ Linux ]]
}
