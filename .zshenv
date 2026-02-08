export HOMEBREW_FORBIDDEN_FORMULAE="node python python3 python@3.11 python@3.12 python@3.13 python@3.14 pip npm pnpm yarn claude"

export PATH="$HOME/.local/bin:$PATH"

## mise - node
# ~/.npmrc `prefix=~/.npm-global`
export PATH="$HOME/.npm-global/bin:$PATH"

## cargo
export PATH=$HOME/.cargo/bin:$PATH
## bun
export PATH="$HOME/.bun/bin:$PATH"
## fzf
export PATH=$HOME/.local/bin/.fzf/bin:$PATH
## sql
export PATH=/opt/homebrew/opt/mysql-client@8.0/bin:$PATH
export PATH=/opt/homebrew/opt/sqlite/bin:$PATH
# docker用設定(改ざん保護機能)
export DOCKER_CONTENT_TRUST=0
# mycli
#   on PJ: ln -sf ${HOME}/mycli ${PJ_DIR}/__my-cli/root
export PATH=$HOME/mycli:$PATH
. "$HOME/.cargo/env"

# Added by Windsurf
export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"