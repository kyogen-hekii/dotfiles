# source ~/.zshrc_etc/.alias.zshrc
# => ほかの*.zshrcファイルも読み込むようにしている
# Q&A
# 1. 'を打ちたいんだけど
#   a.  '\''
#   a. 'は打てないので、一度入力を終了する->'を入れる->入力再開
# 1. trimするには?
#   a. | xargs echo |
#   a. echoでtrimできる

# sed
# sed -E 's/{pattern}/{replacement}/g' {input_file}

# zal(Get-Alias)
alias zal='code ~/.zshrc_etc/.alias.zshrc'
alias karabiner='code ~/.config/karabiner/karabiner.json'

# common
alias ls='eza'
alias la="eza -a --git -g -h --oneline"
alias cat='bat'
if [ "$(whoami)" = "vscode" ]; then
  alias fdf='fd'
elif [ "$(uname)" = "Darwin" ]; then
  alias fdf='fd'
else
  alias fd='fdfind'
  alias fdf='fdfind'
fi
alias cdr='fzf-cdr'
alias python='python3'
alias pip='pip3'
alias grep='rg'
alias cx='() { echo "#!/usr/bin/zsh" > $1 && chmod +x $1 && code $1 }'
alias uml='docker run -d -p 8201:8080 plantuml/plantuml-server:jetty && echo PlantUML Server is running on http://localhost:8201'

#
# etc
#

# ln
# ※ 元はcurrent dirからの相対パスにならないから絶対パス推奨
# ln -s /workspace/xxx_common ./xxx/my-common


#
# git
#
# wrap the git command to either run windows git or linux
isWinDir() {
  case $PWD/ in
    /mnt/*) return $(true);;
    *) return $(false);;
  esac
}
git() {
  if isWinDir
  then
    git.exe "$@"
  else
    /usr/bin/git "$@"
  fi
}
github_ssh_init() {
  cd ~/.ssh
  ssh-keygen -f ./id_xxx_mac_ed25519 -t ed25519
  # ssh -T git@github.com
  # => git@github.com: Permission denied (publickey).
  # ssh -T git@github.com -i ~/.ssh/id_xxx_mac_ed25519
  # => You've successfully authenticated, but GitHub does not provide shell access.
  ssh-add ./id_xxx_mac_ed25519
  ssh-add ls
  ssh -T git@github.com
  # => You've successfully authenticated, but GitHub does not provide shell access.
  git remote -v
  # ssh-add -d ./id_xxx_mac_ed25519

  # ※.gitconfigに追加するだけでできる
  # code ~/.gitconfig_me
  #=> [core]
	#=> sshCommand = ssh -i ~/.ssh/id_xxx_mac_ed25519 -F /dev/null
}

alias g='git'

alias gch='() { git checkout $1 }'
alias gchb='(){ git checkout -b $1 $2 }'
alias gchbm='(){ git checkout -b $1 main }'
alias gchbl='execGbl | uniq | head | fzf | xargs git checkout'
alias gdev='git checkout main'
alias gf='git fetch'
alias gpl='git pull --ff-only'
alias gpr='git pull --rebase'
alias gplr='git pull --rebase'
alias gplrabort='git merge --abort'
alias gpld='git pull --rebase origin main'
gpsh() {
  git rev-parse --abbrev-ref --symbolic-full-name '@{u}' >/dev/null 2>&1 \
    && git push \
    || git push -u origin HEAD
}
gpshf() {
  git rev-parse --abbrev-ref --symbolic-full-name '@{u}' >/dev/null 2>&1 \
    && git push --force-with-lease \
    || git push -u origin HEAD --force-with-lease
}
alias gbn='git symbolic-ref --short HEAD'
alias gbnc='git symbolic-ref --short HEAD | pbc'
alias gbl='execGbl | uniq | head | fzf | pbc'
gsetupstream() {
  local current_branch
  current_branch="$(git branch --show-current)"
  if [ -z "$current_branch" ]; then
    echo "Not on a branch (detached HEAD)."
    return 1
  fi
  git branch --set-upstream-to="origin/$current_branch" "$current_branch"
}

alias gusd='git branch -u origin/main'
alias grn='(){ git branch -m $1 }'
alias gdelb='(){ git branch -d $1 }'
alias gdelremo='(){ git push origin -d $1 }'
alias gbkup='git branch $(git symbolic-ref --short HEAD)_bkup ; echo $(git symbolic-ref --short HEAD)_bkup ; echo $(git symbolic-ref --short HEAD)_bkup | clip'
alias gdelbkup='git branch -d --force $(git symbolic-ref --short HEAD)_bkup ; echo delete $(git symbolic-ref --short HEAD)_bkup'
alias gold='git branch -m $(git symbolic-ref --short HEAD)_old ; echo $(git symbolic-ref --short HEAD)'
alias gdelold='git branch -d --force $(git symbolic-ref --short HEAD)_old ; echo delete $(git symbolic-ref --short HEAD)_old'
# alias gmyignore='code ./.git/info/exclude'
# alias gitdiff='git diff --staged > ' #$1
alias gs='git status -s | awk '\''{print $2}'\'''
alias gskip='git status -s | awk '\''{print $2}'\'' | fzf | xargs git update-index --skip-worktree'
alias gskipu='git ls-files -v | grep ^S | awk '\''{print $2}'\'' | fzf | xargs git update-index --no-skip-worktree'
alias gskipls='git ls-files -v | grep ^S | awk '\''{print $2}'\'''
# alias gcp='コピーしたいブランチから git checkout -b でブランチを作成 & git branch -u origin/main'

# エラーのファイルだけ抽出してスキップをキャンセル
# >を使うのに標準(エラー)出力できるのが& 2>&1は標準エラー出力を標準出力にマージ
# gch main 2>&1 >/dev/null | grep '^\s' | awk '{print $1}' | fzf | xargs git update-index --no-skip-worktree

# abort
# git merge --abort

# copy
# git checkout -b feature/xxx_copied

# gh
# cache確認,削除
# gh api repos/dev/backend/actions/caches --paginate --jq '.actions_caches[] | select(.ref == "refs/pull/1186/merge") | "\(.id)\t\(.key)"'
# gh api repos/dev/backend/actions/caches --paginate --jq '.actions_caches[] | select(.ref == "refs/pull/1186/merge") | .key' | while read -r key; do
#   echo "Deleting cache: $key"
#   gh api --method DELETE "repos/dev/backend/actions/caches?key=${key}"
#   sleep 1  # Rate limit対策
# done


execGbl() {
  git --no-pager reflog | awk '$3 == "checkout:" && /moving from/ {print $8}'
}

alias grepo='cloneHelpfulRepo'
cloneHelpfulRepo() {
    cd ~/workspace/git_repos
    git clone $1
    cd -
}

#
# clip
#
if [[ "$(uname -r)" == *microsoft* ]]; then
  # pbcopy(for wsl)
  alias -g pbc='clip.exe'
  alias -g clip='clip.exe'
  # copy last command
  # https://numb86-tech.hatenablog.com/entry/2019/10/04/164547
  # awkのgsubで置換、xargs echoでtrimしている。clip.exeを使うので最後の改行は取り除けない
  alias cph='history | fzf | sed -E "s/^ +[0-9]+ +//" | clip'
  alias cphlc='history | head -n 1 | sed -E "s/^ +[0-9]+ +//" | clip'
fi
if [ "$(uname)" = "Darwin" ]; then
  alias -g pbc='pbcopy'
  alias -g clip='pbcopy'
  alias -g cph='history | tac | fzf | sed -E "s/^ +[0-9]+\*? +//" | pbcopy'
  alias -g cphlc='history | tail -n 1 | sed -E "s/^ +[0-9]+\*? +//" | pbcopy'
fi

# -----
# docker
# -----
alias docker-compose='docker compose'
alias dc='docker compose'
alias dcup='docker compose up -d'
alias dcstop='docker compose stop'
alias dcrm='docker compose down --rmi all --volumes --remove-orphans'
alias dcdown='docker compose down --remove-orphans'
alias dcps='docker compose ps'

# alias dclogs='docker compose logs'
# ファイルのコピー
# docker-compose cp management-db:./etc/adduser.conf ./

# ダンプ=バックアップ作成
# - [data]
# docker-compose exec data-db pg_dump -U postgres data_db --file=data.sql
# docker-compose cp data-db:./data.sql ./

# リストア=バックアップ適用
# - [data]
# docker-compose cp ./data.sql data-db:./data.sql
# docker-compose exec data-db psql -U postgres data_db --file=./data.sql


# -----
# nodebrew
# -----


# -----
# aws
# -----
aws_profile_fzf() {
  export AWS_PROFILE="$(grep '^\[profile ' ~/.aws/config | sed 's/^\[profile \(.*\)\]$/\1/' | fzf)"
}

set AWS_PROFILE_DEFAULT aws
set AWSP aws --profile {$AWS_PROFILE_DEFAULT}
# ユーザープール一覧
alias aws_userpools '{$AWSP} cognito-idp list-user-pools --max-results 10'
# ユーザープールのクライアント一覧
alias aws_clients_by_userpoolid '{$AWSP} cognito-idp list-user-pool-clients --max-results 10 --user-pool-id'

# アイデンティティプール一覧
alias aws_idps '{$AWSP} cognito-identity list-identity-pools --max-results 10'
# aws --profile aws cognito-identity list-identity-pools --max-results 10 --query "IdentityPools[].IdentityPoolId"
# アイデンティティプール詳細
alias aws_idp_detail_by_idpid '{$AWSP} cognito-identity describe-identity-pool --identity-pool-id'
# idp, clientIdの一覧
alias aws_idp_detail_list '{$AWSP} cognito-identity list-identity-pools --max-results 10 --query "IdentityPools[].IdentityPoolId" | jq -r ".[]" | xargs -I {} aws --profile aws cognito-identity describe-identity-pool --identity-pool-id {} | jq "{idpName: .IdentityPoolName, idpId: .IdentityPoolId, clientId: .CognitoIdentityProviders[].ClientId}"'

# -----
# postgres docker
# -----
alias dcp_exec 'docker exec -it postgres bash'
# docker container内で
# 一覧
# psql -U postgres -l

# -----
# xargs
# -----
alias xargs_sample='echo "foo and bar." | xargs -I {} echo "Argument: {}"'

# -----
# fd: ファイル名の検索。directoryは -t d。-Iはgitignoreを無視
# https://zenn.dev/21f/articles/fd-find-alternative
# -----
# fd util | awk '/apis?/'
# fd -t d -I node_modules
# my-だけ
# fd my- -u -t f -E node_modules

#
# net関連
#
# port一覧
# netstat -tuln


# -----
# ripgrep
# -----
# rg 'useMutation.*\('

# -----
# cargo
# -----
# list: ls ~/.cargo/bin

# -----
# pnpm
# -----
alias p='pnpm'
alias px='pnpm dlx'
# pnpm store path -> (cache) store の場所
# pnpm store prune

#
# functions
#

# os
is_mac() {
    [ "$(uname)" = "Darwin" ]
}
is_linux() {
    # [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]
    [[ "$(uname)" =~ Linux ]]
}
# ❯ source ~/.zshrc

sample_node_eval0() {
  local txt="Hi!!"
  NAME="John" node -e "console.log('${txt} ' + process.env.NAME)"
}

function last_output() {
  local output_file=~/.last_output
  local clean_output_file=~/.last_output_clean
  local hist_line=$(fc -ln -1)
  # ファイルに情報を保存
  {
      echo "Command: $hist_line"
      echo "Time: $(date)"
      echo "PWD: $(pwd)"
      echo "Output:"
      echo "---"
  } > "$output_file"

  # コマンド再実行（生の出力も保存）
  eval "$hist_line" 2>&1 | tee -a "$output_file"

  # ANSIエスケープコードを除去したクリーン版も作成
  sed 's/\x1b\[[0-9;]*m//g; s/\x1b\[[0-9]*[A-Za-z]//g; s/\x1b\[[0-9]*K//g' "$output_file" > "$clean_output_file"
  echo -e "\n📋 Output captured! Use these commands:"
  echo "  cat ~/.last_output_clean    # Clean output (recommended)"
  echo "  cat ~/.last_output          # Raw output (with escape codes)"
  # echo "  pbcopy < ~/.last_output_clean  # Copy clean version (macOS)"
  pbcopy < ~/.last_output_clean
}

function rddb() {
  local db_file="${1:?Database file is required. Usage: rddb <db_file>}"

  local cur=$(date +%Y%m%d_%H%M%S)
  local session_file=~/duckdb_sessions/duckdb_session_"$cur".log
  local session_clean_file=~/duckdb_sessions/clean/duckdb_clean_"$cur".log
  local log_file=~/.last_output
  local log_clean_file=~/./last_output_clean

  echo "🎬 Recording DuckDB session..."
  echo "📁 Database: $db_file"
  echo "📝 Output: $session_file"
  echo "💡 Use 'exit' or Ctrl+D to finish recording"
  echo "---"

  # macOS式の構文(関数のスコープでのみ記録される)
  script -a "$session_file" duckdb "$db_file"
  cp "$session_file" "$log_file"
  clean_duckdb_output "$log_file" "$log_clean_file"
  cp "$log_clean_file" "$session_clean_file"
  echo "---"
  echo "✅ Recording completed: $session_clean_file"
  echo "✅ same as: $log_clean_file"
}

function clean_duckdb_output() {
    local output_file="${1:-$HOME/.last_output}"
    local clean_output_file="${2:-$HOME/.last_output_clean}"

    # ステップバイステップで処理（修正版）
    # 1. エスケープコードを除去
    sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' "$output_file" > /tmp/step1.txt
    # 2. カーソル位置制御を除去
    sed 's/\[[0-9]*;[0-9]*f//g' /tmp/step1.txt > /tmp/step2.txt
    # 3. 改行を復元（D の前で改行を挿入） + 改行コード正規化
    sed 's/D /\nD /g; s/\r//g' /tmp/step2.txt > /tmp/step2a.txt
    # 4. 空行を削除
    grep -v '^$' /tmp/step2a.txt > /tmp/step2b.txt
    # 5. セミコロンで終わらないD行のみを除去（順序保持）
    awk '
    /^D / {
        if ($0 ~ /;$/) {
            # セミコロンで終わるD行は保持
            print $0
        }
        # セミコロンで終わらないD行は無視
    }
    !/^D / {
        # D以外の行はそのまま保持
        print $0
    }
    ' /tmp/step2b.txt > /tmp/step3.txt
    # 6. 重複行を除去
    uniq /tmp/step3.txt > "$clean_output_file"
    # 一時ファイル削除
    rm -f /tmp/step*.txt
    echo "🧹 DuckDB output cleaned:"
}
