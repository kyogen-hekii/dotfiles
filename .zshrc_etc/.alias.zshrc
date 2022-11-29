# source ~/.zshrc
# Q&A
# 1. 'を打ちたいんだけど
#   a.  '\''
#   a. 'は打てないので、一度入力を終了する->'を入れる->入力再開
# 1. trimするには?
#   a. | xargs echo |
#   a. echoでtrimできる

# zal(Get-Alias)
alias zal='code ~/.zshrc_etc/.alias.zshrc'

# pbcopy(for wsl)
alias -g pbc='clip.exe'
alias -g clip='clip.exe'

# copy last command
# https://numb86-tech.hatenablog.com/entry/2019/10/04/164547
# awkのgsubで置換、xargs echoでtrimしている。clip.exeを使うので最後の改行は取り除けない
alias cplc='(){ history -a | tail -n 1 | head -n 1 | tr -d \n | awk '\''{gsub(/^ *[0-9]+/, "", $0); print $0}'\'' | xargs echo | clip.exe }'

# checks to see if we are in a windows or linux dir
function isWinDir {
  case $PWD/ in
    /mnt/*) return $(true);;
    *) return $(false);;
  esac
}
# wrap the git command to either run windows git or linux
function git {
  if isWinDir
  then
    git.exe "$@"
  else
    /usr/bin/git "$@"
  fi
}

# git
alias gch='(){ git checkout $1 }'
alias gchb='(){ git checkout -b $1 $2 }'
alias gchbl='(){ execGbl | uniq | head | fzf | xargs git checkout }'
alias gdev='(){ git checkout main }'
alias gf='(){ git fetch }'
alias gpl='(){ git pull --ff origin $1 }'
alias gpr='(){ git pull --rebase }'
alias gplr='(){ git pull --rebase origin $1 }'
# alias gpld='(){ git pull --rebase origin main }'
alias gpsh='(){ git push origin HEAD }'
alias gbnc='(){ git symbolic-ref --short HEAD | pbc }'
alias gbn='(){ git symbolic-ref --short HEAD }'
alias gbl='(){ execGbl | uniq | head | fzf | pbc }'
alias gusd='(){ git branch -u origin/main }'
alias gbr='(){ git branch }'

alias grn='(){ git branch -m $1 }'
alias gdelb='(){ git branch -d $1 }'
alias gdelremo='(){ git push origin -d $1 }'

alias gbkup='(){ git branch $(git symbolic-ref --short HEAD)_bkup ; echo $(git symbolic-ref --short HEAD)_bkup }'
alias gdelbkup='(){ git branch -d --force $(git symbolic-ref --short HEAD)_bkup ; echo delete $(git symbolic-ref --short HEAD)_bkup }'
alias gold='(){ git branch -m $(git symbolic-ref --short HEAD)_old ; echo $(git symbolic-ref --short HEAD) }'
alias gdelold='(){ git branch -d --force $(git symbolic-ref --short HEAD)_old ; echo delete $(git symbolic-ref --short HEAD)_old }'

execGbl() {
  git --no-pager reflog | awk '$3 == "checkout:" && /moving from/ {print $8}'
}

# ❯ source ~/.zshrc