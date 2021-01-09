" __  ____   __  _   ___     _____ __  __
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| |
"| |  | | | |   | |\  | \ V /  | || |  | |
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|

" Author: @winwisely268

lua require('plugin.init').setup()

" ==
" == Load main configs
" ==
if !exists('g:vscode')
	luafile ~/.config/nvim/start.lua
else
	luafile ~/.config/nvim/mini.lua
endif
