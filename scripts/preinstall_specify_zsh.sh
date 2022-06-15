#!/usr/bin/zsh
if [[ $SHELL =~ bash ]]; then
  echo please zsh
  echo if you use wsl, you edit settings.json like terminal.integratedshell.windows wslPath
  # "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\wsl.exe"
  return
fi

# zsh関連
#   pure(theme)※symlinkが貼れないから.zshrcにfpathに追加が必要
npm install --global pure-prompt
#   zinit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
source ~/.zshrc
zinit self-update  
