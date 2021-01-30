#!/bin/bash
if [ $WIN_USER == '' ]; then
  echo error
  exit 1
fi
THIS_DIRECTORY=$(cd $(dirname $0)/; pwd)
VSCODE_DIRECTORY=/mnt/c/Users/${WIN_USER}/AppData/Roaming/Code/User
# シンボリックリンク作成
cp "$THIS_DIRECTORY/keybindings.json" "$VSCODE_DIRECTORY/keybindings.json"
cp "$THIS_DIRECTORY/settings.json" "$VSCODE_DIRECTORY/settings.json"
cp "$THIS_DIRECTORY/tasks.json" "$VSCODE_DIRECTORY/tasks.json"
#cp "$THIS_DIRECTORY/snippets" "$VSCODE_DIRECTORY/snippets"

# typescriptとtypescriptreactを合わせる
# ln -snfv "$VSCODE_DIRECTORY/snippets/typescriptreact.json" \
#   "$VSCODE_DIRECTORY/snippets/typescript.json"
