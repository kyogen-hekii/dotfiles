# source ~/.zshrc

# zal(Get-Alias)
alias zal='code ~/.zshrc_etc/.alias.zshrc'

# pbcopy(for wsl)
alias -g pbc='clip.exe'

# git
alias gch='(){ git checkout $1 }'
alias gchbd='(){ git checkout -b $1 origin/main }'
alias gdev='(){ git checkout main }'
alias gf='(){ git fetch }'
alias gpl='(){ git pull --ff origin $1 }'
alias gpld='(){ git pull --rebase origin main }'
alias gpsh='(){ git push origin HEAD }'
# alias gbnc='(){ git symbolic-ref --short HEAD | pbc }'
alias gbn='(){ git symbolic-ref --short HEAD }'
alias gusd='(){ git branch -u origin/main }'
