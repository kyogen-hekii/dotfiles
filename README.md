# dotfiles  
個人用dotfiles  

## 使用方法  
```sh
$ git clone https://github.com/kyogen-hekii/dotfiles.git
$ cd dotfiles
$ ./scripts/preinstall_first.sh
$ ./scripts/preinstall_second.sh
$ (vscodeを再起動)
$ ./scripts/link_as_deploy.sh
$ ./scripts/preinstall_mac.sh

$ ./scripts/preinstall_etc/preinstall_cargo.sh
$ ./scripts/preinstall_etc/preinstall_zsh_tools.sh
$ ./scripts/preinstall_etc/preinstall_docker.sh
$ ./scripts/preinstall_etc/sample_install_fonts.sh
```

### 補足
```sh
# karabinerの設定ファイルをdeploy
$ ./config/karabiner/link_as_deploy_karabiner.sh
# vscodeの設定ファイルをdeploy(mac)
$ ./config/vscode/mac/link_as_deploy_vscode_settings.sh

# vscodeの設定ファイルをdeploy(windows)
$ ./config/vscode/wsl2/link_as_deploy_vscode_settings.sh
```
  
## その他  
動作未確認  
1ファイルに作成しようとしているから変更必要  
makeに変えるのがいいかもしれない  
