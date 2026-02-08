# .zshenv     → 常に最初（全シェル）
# .zprofile   → ログインシェルのみ
# .zshrc      → 対話シェルのみ
# .zlogin     → ログインシェルのみ（.zshrc の後）

# Fig pre block. Keep at the top of this file.
# [[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

#
# keybind
#
#bindkey '^ ' autosuggest-accept

#
# 履歴
#
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 単一のhistoryファイルを共有
setopt share_history
# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups
# 重複するコマンドは古い方を削除する
setopt hist_ignore_all_dups
# ctrl+dでログアウトを無効
setopt ignoreeof
# 補完を利かせる
autoload -Uz compinit && compinit
# ディレクトリを変更するたびに、Zshは自動的に現在のディレクトリをディレクトリスタックにプッシュします。
# e.g. pushd, popd, dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_cd

# Prompt -> starship
# そもそもpromptって? $(一般ユーザ)とか#(管理者)とか
# config reload
# code ~/.config/starship.toml
[[ -f "$HOME/.cargo/bin/starship" ]] && eval "$(starship init zsh)"

# Package Manager -> sheldon
# config reload
# code ~/.config/sheldon/plugins.toml
[[ -f "$HOME/.cargo/bin/sheldon" ]] && eval "$(sheldon source)"

### -----
### wsl用
### -----
if [[ "$(uname -r)" == *microsoft* ]]; then
  export DOCKER_STATUS_ENABLED=$(service docker status | awk '{print $4}' | grep "running")
  if ! [[ "$DOCKER_STATUS_ENABLED" == "running" ]]; then
    sudo service docker start >/dev/null
  fi
fi

#
# fzf
#

# history
function fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# cdr
function fzf-cdr() {
    local selected_dir=$(dirs -p | fzf --reverse)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-cdr
bindkey '^h' fzf-cdr

# 他のzshrcを読み込む(.zshrc_etc)
for rcfile in $HOME/.zshrc_etc/.??*; do
  source "$rcfile"
done
if [[ -d "$HOME/.zshrc_secret" ]] then
  for rcfile in $HOME/.zshrc_secret/.??*; do
    source "$rcfile"
  done
fi
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# Fig post block. Keep at the bottom of this file.
# [[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

## mise
eval "$(mise activate zsh)"

# opencode
export PATH=$HOME/.opencode/bin:$PATH
