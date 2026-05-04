PJ_NAME:=pj_xxx
# /Users/me/workspace/_pj0base | /Users/me/workspace/base_root/0base
MAKEFILE_DIR_0BASE := $(shell pwd)
# /Users/me/workspace | /Users/me/workspace/base_root
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
# init xxx0base
# ----------
__init-this:
# pwd => /Users/me/workspace/_pj0base
	touch ${MAKEFILE_DIR_0BASE}/.git_info_exclude
	touch ${MAKEFILE_DIR_0BASE}/Makefile
	touch ${MAKEFILE_DIR_0BASE}/this.code-workspace
__init-from-pj0base-to-domain-0base:
# pwd => /Users/me/workspace/_pj0base
	$(eval PJ_ROOT := xxx)
	$(eval PJ_KEY_0BASE := ddm0base)
	mkdir -p ${WORK_DIR}/${PJ_ROOT}/${PJ_KEY_0BASE}
#   => mkdir /Users/me/workspace/<pj_root>/<0base>
	cp ${MAKEFILE_DIR_0BASE}/.git_info_exclude ${WORK_DIR}/${PJ_ROOT}/${PJ_KEY_0BASE}/git_info_exclude
	cp ${MAKEFILE_DIR_0BASE}/Makefile ${WORK_DIR}/${PJ_ROOT}/${PJ_KEY_0BASE}/Makefile
	cp ${MAKEFILE_DIR_0BASE}/this.code-workspace ${WORK_DIR}/${PJ_ROOT}/${PJ_KEY_0BASE}/this.code-workspace
__init-domain-cli:
# pwd => /Users/me/workspace/<pj_root>/<0base>
	$(eval PJ_KEY_0BASE := $(shell basename $(shell pwd)))
	$(eval PJ_KEYWORD := $(shell echo ${PJ_KEY_0BASE} | sed 's/0base//'))
	mkdir ../${PJ_KEYWORD}0cli

# ----------
# init
# ----------
__init_frontend:
	$(eval THIS_NAME := frontend)
	$(eval THIS_ALIAS := front)
	$(eval PJ_ROOT := $(shell echo ${WORK_DIR}))
	$(eval PJ_KEY_0BASE := $(shell basename $(shell pwd)))
	$(eval PJ_KEYWORD := $(shell echo ${PJ_KEY_0BASE} | sed 's/0base//'))
	ln -sf ${MAKEFILE_DIR_0BASE}/.git_info_exclude ${PJ_ROOT}/${THIS_NAME}/.git/info/exclude
	ln -sf ${MAKEFILE_DIR_0BASE}/Makefile ${PJ_ROOT}/${THIS_NAME}/Makefile
	cp ${MAKEFILE_DIR_0BASE}/this.code-workspace ${PJ_ROOT}/${THIS_NAME}/${THIS_ALIAS}.code-workspace
	mkdir ${PJ_ROOT}/${THIS_NAME}/__my-cli
	ln -sf ${HOME}/mycli ${PJ_ROOT}/${THIS_NAME}/__my-cli/root
	ln -sf ${PJ_ROOT}/${PJ_KEYWORD}0cli ${PJ_ROOT}/${THIS_NAME}/__my-cli/${PJ_NAME}0cli

__init_backend:
# cd ~/workspace/ddm/ddm0base
	$(eval THIS_NAME := backend)
	cp -f ${MAKEFILE_DIR_0BASE}/git_info_exclude ${PJ_DIR}/${THIS_NAME}/.git/info/exclude
	cp -f ${MAKEFILE_DIR_0BASE}/Makefile ${PJ_DIR}/${THIS_NAME}/Makefile
	cp -f ${MAKEFILE_DIR_0BASE}/this.code-workspace ${PJ_DIR}/${THIS_NAME}/${THIS_ALIAS}.code-workspace

# mkdir ${PJ_DIR}-fiction/__my-cli
# ln -sf ${HOME}/mycli ${PJ_DIR}-fiction/__my-cli/root
# ln -sf ${PJ_DIR}/../${PJ_NAME}0cli ${PJ_DIR}-fiction/__my-cli/${PJ_NAME}0cli
