THIS_DIRECTORY=$(cd $(dirname $0)/; pwd)
# bkupとoriginを作成
cp -f "$HOME/.config/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner_origin.json"
cp -f "$THIS_DIRECTORY/karabiner.json" "$HOME/.config/karabiner/karabiner_bkup.json"
# シンボリックリンク作成
ln -snfv "$THIS_DIRECTORY/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
