.PHONY: setup

setup:
	env MACOSX_DEPLOYMENT_TARGET=10.15 nvim --headless -E -u NORC +'luafile bootstrap/script.lua' +q
