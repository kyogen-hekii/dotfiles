#!/bin/sh

# dotfiles内の.始まりのファイル/ディレクトリ全てhomeディレクトリにリンクを作成
# ※このファイルはdotfilesで実行される
DOT_DIRECTORY=$(cd $(dirname $0)/../; pwd)
for rcfile_fullpath in $DOT_DIRECTORY/.??*; do
  # 前方一致でパターン削除
  rcfile=${rcfile_fullpath##*/}
  
  # 不要ファイルを無視
  [[ $rcfile = ".git" ]] && continue
  [[ $rcfile = ".gitignore" ]] && continue
  
  # シンボリックリンク作成
  ln -snfv "$DOT_DIRECTORY/$rcfile" "$HOME/$rcfile"
done
