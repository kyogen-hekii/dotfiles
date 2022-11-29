# code ./.git/info/exclude に追加しておく(fpathが変わるため)
# .zshrc_etc/.pure.zshrc

# テーマ設定(pure)
fpath+=("$HOME/.nodebrew/node/v14.4.0/lib/node_modules/pure-prompt/functions")
autoload -Uz promptinit && promptinit
prompt pure
