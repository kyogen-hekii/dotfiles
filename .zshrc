# ctrl+dでログアウトを無効
setopt ignoreeof
# 補完を利かせる
autoload -Uz compinit && compinit

# テーマ設定(pure)
fpath+=("$HOME/.nodebrew/node/v14.4.0/lib/node_modules/pure-prompt/functions")
autoload -Uz promptinit && promptinit
prompt pure

# 他のzshrcを読み込む
for rcfile in $HOME/.zshrc_etc/.??*; do
  source "$rcfile"
done
