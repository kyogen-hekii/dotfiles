export DENO_INSTALL=$HOME/.deno
# PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$DENO_INSTALL/bin:$PATH

# docker用設定(改ざん保護機能)
export DOCKER_CONTENT_TRUST=1
