# dotfiles  
個人用dotfiles  

## 使用方法  
```sh
$ git clone https://github.com/kyogen-hekii/dotfiles.git
$ cd dotfiles
$ ./scripts/preinstall.sh
$ ./scripts/preinstall_specify_zsh.sh
$ ./scripts/link_as_deploy.sh
```
  
### 補足  
```sh
# その他preinstall
$ ./scripts/preinstall_etc/preinstall_docker.sh
# karabinerの設定ファイルをdeploy
$ ./config/karabiner/link_as_deploy_karabiner.sh
# vscodeの設定ファイルをdeploy(mac)
$ ./config/vscode/mac/link_as_deploy_vscode_settings.sh
```
  
## その他  
動作未確認  
1ファイルに作成しようとしているから変更必要  
makeに変えるのがいいかもしれない  
