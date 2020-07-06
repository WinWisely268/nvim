mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

.PHONY: bootstrap
bootstrap:
	env MACOSX_DEPLOYMENT_TARGET=10.15 nvim --headless -E -u NORC -R +'set rtp+=$(mkfile_dir)' +'luafile scripts/bootstrap.lua' +q
	env NVIM_BOOTSTRAP=1 nvim -R --headless +'PlugInstall|qa' +cq

.PHONY: shellcheck
shellcheck:
	shellcheck langservers/bin/*-lsp langservers/setup.sh
