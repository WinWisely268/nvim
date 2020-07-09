" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: @winwisely268
" Adapted from @theniceboy, @haorenW1025, @wbthomason, @mfussenegger,
" @theHamsta configs
"
" ==
" == Auto load for first time uses
" ==
lua require('plugin.init').setup()

"== 
"== Turn off useless plugins
"==
let g:loaded_2html_plugin      = 1
let loaded_gzip                = 1
let g:loaded_man               = 1
let loaded_matchit             = 1
let loaded_matchparen          = 1
let g:loaded_shada_plugin      = 1
let loaded_spellfile_plugin    = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1
let g:loaded_netrwPlugin       = 1

" ==
" == Load main configs
" ==
if !exists('g:vscode')
	luafile ~/.config/nvim/init.lua
else 
	luafile ~/.config/nvim/mini.lua
endif

