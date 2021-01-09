.PHONY: setup

setup:
	env MACOSX_DEPLOYMENT_TARGET=11.1 nvim --headless -E -u NORC +'luafile bootstrap/script.lua' +q
