# os
is_mac() {
    [ "$(uname)" = "Darwin" ]
}
is_linux() {
    # [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]
    [[ "$(uname)" =~ Linux ]]
}

# cargo
if is_linux; then
  sudo apt install -y gcc
fi
# curl https://sh.rustup.rs -sSf | sh
# cargo etc(exaはほかで使っているから必要..)
cargo install eza exa bat tre-command

if is_linux; then
  sudo apt install -y fd-find
fi
if is_mac; then
  brew install fd
fi
