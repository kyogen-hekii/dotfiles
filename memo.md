最強の dotfiles 駆動開発と GitHub で管理する運用方法
[URL](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2)
> 1. リポジトリのダウンロード
> 2. ドットファイルのデプロイ
> 3. （任意で）イニシャライズ
※initializeなんてこの人のrepoには存在しない?
そしてこの人のinitialzeという言葉は現在、説明とrepoで一致していない

TODO
* peco導入
* ZLE
* https://github.com/ymm1x/dotfiles/blob/master/.zshrc


https://qiita.com/yasudanaoya/items/8b928cfadbf702108ba3

一番最初は
https://sousaku-memo.net/php-system/1683
brew(macのみ)
zsh

これらはdefaultで設定できる
* setopt
* zstyle

preztoのgit submodule...いやpreztoはいらないはず
zplug...はzinitにする

```sh
git submodule add -f https://github.com/sorin-ionescu/prezto.git .zprezto
git submodule update --init --recursive

```

zinit
```sh
# ~/.zinit/binにinstall
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
```


まずはinit.shから
```sh
DOT_DIR="${HOME}/workspace/dotfiles"
REMOTE_URL="https://github.com/kyogen-hekii/dotfiles.git"
# zsh install
# zplug install
# 
```

```sh
# コマンドの有無は今後よく使うので
has() {
  type "$1" > /dev/null 2>&1
}
# 関数を作って、こんな風に使いましょう
if has "brew"; then
  ...
fi
```

デプロイ
```sh
cd ${DOT_DIRECTORY}

for f in .??*
do
  # 無視したいファイルやディレクトリはこんな風に追加してね
  [[ ${f} = ".git" ]] && continue
  [[ ${f} = ".gitignore" ]] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done
echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
```
