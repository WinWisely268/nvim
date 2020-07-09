.PHONY: neorocks

neorocks: install init
	env MACOSX_DEPLOYMENT_TARGET=10.15 nvim -R +'luafile bootstrap/script.lua'

install:
	env NVIM_BOOTSTRAP=1 nvim --headless -E -R +'PkgInstall' +q

init:
	nvim --headless -E -R +'PkgCompile' +q
