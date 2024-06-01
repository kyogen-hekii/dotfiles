## nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
## deno
export DENO_INSTALL=$HOME/.deno
export PATH=$DENO_INSTALL/bin:$PATH
## cargo
export PATH=$HOME/.cargo/bin:$PATH
## fzf
export PATH=$HOME/.local/bin/.fzf/bin:$PATH
# docker用設定(改ざん保護機能)
export DOCKER_CONTENT_TRUST=1
# mycli
#   on PJ: ln -sf ${HOME}/mycli ${PJ_DIR}/__my-cli/root
export PATH=$HOME/mycli:$PATH
