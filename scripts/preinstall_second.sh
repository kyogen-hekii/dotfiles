#!/usr/bin/zsh
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
  fi
  if is_mac; then
    brew update
  fi
  
  # make
  if ! is_exists 'make'; then
    sudo apt install make
  fi

  # nodebrew(https://github.com/hokaccha/nodebrew)
  if ! is_exists 'node'; then
    curl -L git.io/nodebrew | perl - setup
    env PATH=$HOME/.nodebrew/current/bin:$PATH
    nodebrew install stable && nodebrew use stable
  fi

  # pnpm
  if ! is_exists 'pnpm'; then
    # curl -fsSL https://get.pnpm.io/install.sh | sh -
    # pnpm env use --global 18
    npm i -g pnpm
  fi

  # etc
  # basic
  sudo apt install -y zip unzip make ripgrep
  # fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/bin/.fzf
  ~/.local/bin/.fzf/install
  # deno
  curl -fsSL https://deno.land/install.sh | sh
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
