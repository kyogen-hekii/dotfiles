```sh
mkdir ~/workspace/_pj0base
# project.jsonを記述し、projectを開く
cd _pj0base
code git_info_exclude
code Makefile
```

project.json
```json
[
  {
    "name": "root",
    "rootPath": "/Users/watashi",
    "paths": [],
    "tags": [],
    "enabled": true
  },
  {
    "name": "workspace",
    "rootPath": "/Users/watashi/workspace",
    "paths": [],
    "tags": [],
    "enabled": true
  },
  {
    "name": "dotfiles",
    "rootPath": "/Users/watashi/workspace/dotfiles",
    "paths": [],
    "tags": [],
    "enabled": true
  },
]
```

exclude
```
Makefile
*.code-workspace
**/my-*/*
**/__my-*/*
**/my-memo*
```

Makefile
```Makefile
PJ_NAME:=myprj
MAKEFILE_DIR_0BASE := $(shell pwd)
WORK_DIR := $(shell dirname ${MAKEFILE_DIR_0BASE})
PJ_DIR := $(join $(WORK_DIR),/$(PJ_NAME))

# Deno
e:
	@deno run --allow-net --allow-run --allow-read --allow-write --allow-env --watch bower_components/main.ts

e-%:
	@deno run --allow-net --allow-run --allow-read --allow-env --watch bower_components/${@:e-%=%}.ts

# ----------
# sample
# ----------
base-branch:
	$(eval BASE_BRANCH := main)
echo-base: base-branch
	echo ${BASE_BRANCH}

# ----------
# init
# hspfを作成する
# ----------
__init:
	$(eval DIR_KIND := fiction)
	ln -sf ${MAKEFILE_DIR_0BASE}/.git_info_exclude ${PJ_DIR}-${DIR_KIND}/.git/info/exclude
	ln -sf ${MAKEFILE_DIR_0BASE}/Makefile ${PJ_DIR}-${DIR_KIND}/Makefile
	cp ${MAKEFILE_DIR_0BASE}/this.code-workspace ${PJ_DIR}-${DIR_KIND}/${${DIR_KIND}}.code-workspace

	mkdir ${PJ_DIR}-fiction/__my-cli
	ln -sf ${HOME}/mycli ${PJ_DIR}-fiction/__my-cli/root
	ln -sf ${PJ_DIR}/../${PJ_NAME}0cli ${PJ_DIR}-fiction/__my-cli/${PJ_NAME}0cli
```

this.code-workspace
```json
{
  "folders": [
    {
      "path": "."
    },
    {
      "path": "/home/vscode/dotfiles"
    }
  ],
  "settings": {
    "workbench.colorCustomizations": {
      "titleBar.activeBackground": "#e8c4c4",
      "titleBar.activeForeground": "#2b3a55",
      "titleBar.inactiveBackground": "#e8c4c4",
      "titleBar.inactiveForeground": "#2b3a55",
      "activityBar.background": "#e8c4c4",
      "activityBar.foreground": "#2b3a55",
      "statusBar.background": "#e8c4c4",
      "statusBar.foreground": "#2b3a55",
      "tab.activeBorder": "#ce7777",
      "editor.selectionBackground": "#ce7777"
    },
    "typescript.preferences.importModuleSpecifier": "relative",
    "typescript.tsdk": "node_modules/typescript/lib",
    "deno.enablePaths": ["bower_components", "__my-cli"],
    "terminal.integrated.env.linux": {
      "PATH": "${env:PATH}:${workspaceFolder}cli"
    },
    // formatter
    "[typescript]": {
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[typescriptreact]": {
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "always"
    }
  }
}
```

__END__
