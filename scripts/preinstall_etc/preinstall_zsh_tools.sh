# starship
sudo apt install -y cmake pkg-config libssl-dev
cargo install starship --locked
# 以下で設定
# eval "$(starship init zsh)"
# 設定
# code ~/.config/starship.toml
[ ! -d ~/.config ] && mkdir ~/.config
cp ~/dotfiles/config/starship_initial.toml ~/.config/starship.toml

# sheldon
cargo install sheldon --locked
# 以下で設定
# eval "$(sheldon source)"
# 設定
# code ~/.config/sheldon/plugins.toml
[ ! -d ~/.config/sheldon ] && mkdir ~/.config/sheldon
cp ~/dotfiles/config/sheldon_plugins_initial.toml ~/.config/sheldon/plugins.toml
