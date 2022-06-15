# ctrl+dでログアウトを無効
setopt ignoreeof
# 補完を利かせる
autoload -Uz compinit && compinit

#
# 履歴
#
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups
# 重複するコマンドは古い方を削除する
setopt hist_ignore_all_dups
# 補完候補を ←↓↑→ で選択
zstyle ':completion:*:default' menu select true

#
# 色
#
autoload colors && colors
# ls
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'
# alias ls='ls -F --color'
alias ls='ls -FG'
# 補完候補もLS_COLORSに合わせて色が付くようにする...はできない

# テーマ設定(pure)
fpath+=("$HOME/.nodebrew/node/v14.15.4/lib/node_modules/pure-prompt/functions")
autoload -Uz promptinit && promptinit
prompt pure

# 他のzshrcを読み込む
for rcfile in $HOME/.zshrc_etc/.??*; do
  source "$rcfile"
done
