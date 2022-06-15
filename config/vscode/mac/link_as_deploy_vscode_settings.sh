THIS_DIRECTORY=$(cd $(dirname $0)/; pwd)
VSCODE_DIRECTORY=$HOME/Library/Application\ Support/Code/User
# シンボリックリンク作成
ln -snfv "$THIS_DIRECTORY/keybindings.json" "$VSCODE_DIRECTORY/keybindings.json"
ln -snfv "$THIS_DIRECTORY/settings.json" "$VSCODE_DIRECTORY/settings.json"
ln -snfv "$THIS_DIRECTORY/snippets" "$VSCODE_DIRECTORY/snippets"

# typescriptとtypescriptreactを合わせる
ln -snfv "$VSCODE_DIRECTORY/snippets/typescriptreact.json" \
  "$VSCODE_DIRECTORY/snippets/typescript.json"
