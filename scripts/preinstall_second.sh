#!/bin/zsh
if [[ $SHELL =~ bash ]]; then
  echo please zsh
  echo if you use wsl, you may have to edit settings.json like terminal.integratedshell.windows wslPath
  # "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\wsl.exe"
  return
fi

# ----------
# main
# ----------
main() {
  # 準備
  if is_linux; then
    sudo apt -y update
    sudo apt -y upgrade

    if ! is_exists 'make'; then
      # make
      sudo apt install make
    fi
  fi
  if is_mac; then
    brew update
  fi

  # mise
  brew install mise
  # activate はシェル再起動後に効くから、ここでは env を使う..?
  eval "$(mise env)"

  mise use -g node@24
  # yarn pnpm も on
  corepack enable
  mise use -g python@3.14
  mise use -g uv@latest
  mise use -g bun@latest
  mise use -g deno@latest

  # pnpm
  if ! is_exists 'pnpm'; then
    # curl -fsSL https://get.pnpm.io/install.sh | sh -
    # pnpm env use --global 18
    npm i -g pnpm
  fi

  # etc
  # basic
  if is_linux; then
    sudo apt -y update
    sudo apt -y upgrade
    sudo apt install -y make zip unzip ripgrep fd-find
  fi
  if is_mac; then
    brew install ripgrep fd
  fi

  # fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/bin/.fzf
  ~/.local/bin/.fzf/install
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
