local api = vim.api
local nvim_set_keymap = api.nvim_set_keymap
local loop = vim.loop
local vcmd = vim.cmd
local vfn = vim.fn
local util = require("lib.util")

local helpers = require('lib.nvim_helpers')

local initial_mappings = function()
  -- Disable ex mode. I'm not that smart.
  nvim_set_keymap('n', 'Q', '', {})

  -- Remap the leader key.
  nvim_set_keymap('n', '<Space>', '', {})
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Remap jj
  nvim_set_keymap('t', 'jj', [[<c-\><c-n>]], {})
end

local py3_host_prog = function()
  local vim_venv_bin = vfn.stdpath('cache') .. '/venv/bin'
  loop.os_setenv('PATH', vim_venv_bin .. ':' .. loop.os_getenv('PATH'))

  vim.g.python3_host_prog = vim_venv_bin .. '/python'
  vim.g.python3_host_skip_check = true
end

local hererocks = function()
  local lua_version = string.gsub(_VERSION, 'Lua ', '')
  local hererocks_path = vfn.stdpath('cache') .. '/hr'
  local bin_path = hererocks_path .. '/bin'
  local share_path = hererocks_path .. '/share/lua/' .. lua_version
  local lib_path = hererocks_path .. '/lib/lua/' .. lua_version
  package.path = package.path .. ';' .. share_path .. '/?.lua' .. ';' .. share_path ..
                   '/?/init.lua'
  package.cpath = package.cpath .. ';' .. lib_path .. '/?.so'

  loop.os_setenv('PATH', bin_path .. ':' .. loop.os_getenv('PATH'))
end

local global_vars = function()
  vim.g.netrw_home = vfn.stdpath('data')
  vim.g.netrw_banner = 0
  vim.g.netrw_liststyle = 3
  vim.g.fzf_command_prefix = 'Fzf'
  vim.g.fzf_height = '80%'
end

local ui_options = function()
  vim.o.termguicolors = true
  vim.o.showcmd = false
  vim.o.laststatus = 0
  vim.o.ruler = true
  vim.o.rulerformat = [[%-14.(%l,%c   %o%)]]
  vim.o.guicursor = ''
  vim.o.mouse = ''
  vim.o.shortmess = 'filnxtToOFIc'
end

local global_options = function()
  vim.o.completeopt = 'menuone,noinsert,noselect'
  vim.o.hidden = true
  vim.o.backspace = 'indent,eol,start'
  vim.o.hlsearch = false
  vim.o.incsearch = true
  vim.o.smartcase = true
  vim.o.wildmenu = true
  vim.o.wildmode = 'list:longest'
  vim.o.autoindent = true
  vim.o.smartindent = true
  vim.o.smarttab = true
  vim.o.errorbells = false
  vim.o.backup = false
  vim.o.swapfile = false
  vim.o.inccommand = 'split'
  vim.o.timeoutlen = 500
end

local rnu = function()
  vcmd('set relativenumber')
  vim.schedule(function()
    vcmd([[augroup auto_rnu]])
    vcmd([[autocmd!]])
    vcmd([[autocmd TermOpen * setlocal norelativenumber]])
    vcmd([[augroup END]])
  end)
end

local folding = function()
  vim.o.foldlevelstart = 99
  vim.wo.foldmethod = 'syntax'
  vim.schedule(function()
    vcmd([[augroup folding_config]])
    vcmd([[autocmd!]])
    vcmd([[autocmd BufEnter * setlocal foldmethod=syntax]])
    vcmd([[augroup END]])
  end)
end
	local global_mappings = function()
		local mappings = {
		-- Save and Quit
		['Q']                  = { ':q<CR>--' },
		[ '<C-q>' ]            = { ':qa<CR>' },
		[ 'S' ]                = { ':w<CR>' },
		-- Open vimrc
		['<LEADER>rc']         = { ':e ~/.config/nvim/init.vim<CR>' },
		['l']                  = {'i'},
		['L']                  = {'I'},
		-- Search
		['<LEADER><CR>']       = { ':nohlsearch<CR>' },
		-- Adjacent duplicate words
		['<LEADER>dw']         = { '^(\\<\\w\\+\\>\\)\\_s*\1' },
		-- Folding
		['<LEADER>o']          = {'za'},
		-- Open gitui (Rust alternative to lazygit, great)
		['\\g']                = {':Git'}, -- fugitive
		['<c-g>']              = {':tabe<CR>:-tabmove<CR>:term gitui<CR>'},
		-- ==
		-- == Cursor Movement (Colemak hnei)
		-- ==
		--     ^
		--     e
		-- < h   i >
		--     n
		--     v
		['e']                  = {'k'},
		['n']                  = {'j'},
		['i']                  = {'l'},
		['k']                  = {'n'},
		['ge']                 = {'gk'},
		['gn']                 = {'gj'},
		['E']                  = {'5k'},
		['N']                  = {'5j'},
		['H']                  = {'0'}, -- H -> go to start of line
		['I']                  = {'$'}, -- I -> go to end of line
		['W']                  = {'5w'},
		['B']                  = {'5b'},
		[ '<C-E>' ]            = { '5<C-y>' }, -- move up page
		[ '<C-N>' ]            = { '5<C-e>' }, -- move down page
		-- ==
		-- == Window management
		-- ==
		-- Use <space> + new arrow keys for moving the cursor around windows
		[ '<LEADER>ww' ]        = { '<C-w>w' },
		[ '<LEADER>we' ]        = { '<C-w>k' },
		[ '<LEADER>wn' ]        = { '<C-w>j' },
		[ '<LEADER>wh' ]        = { '<C-w>h' },
		[ '<LEADER>wi' ]        = { '<C-w>l' },
		-- Disable the default s key
		[ 's' ]                = { '<nop>' },
		-- split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
		[ 'se' ]               = { ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>' },
		[ 'sn' ]               = { ':set splitbelow<CR>:split<CR>' },
		[ 'sh' ]               = { ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>' },
		[ 'si' ]               = { ':set splitright<CR>:vsplit<CR>' },
		-- Resize splits with arrow keys
		[ '<Leader>w<up>' ]             = { ':res +5<CR>' },
		[ '<Leader><down>' ]           = { ':res -5<CR>' },
		[ '<Leader><left>' ]           = { ':vertical resize-5<CR>' },
		[ '<Leader><right' ]           = { ':vertical resize+5<CR>' },
		[ 'sh' ]               = { '<C-w>t<C-w>K' }, -- Place the two screens up and down
		[ 'sv' ]               = { '<C-w>t<C-w>H' }, -- Place the two screens side by side
		[ 'srh' ]              = { '<C-w>b<C-w>K' }, -- Rotate screens
		[ 'srv' ]              = { '<C-w>b<C-w>H' },
		[ '<LEADER>q' ]        = { '<C-w>j:q<CR> ' }, -- Press <SPACE> + q to close the window below the current window
		-- ==
		-- == Tab management
		-- ==
		[ 'tu' ]               = { ':tabe<CR>' },
		[ 'th' ]               = { ':-tabnext<CR>' },
		[ 'ti' ]               = { ':+tabnext<CR>' },
		[ 'tmh' ]              = { ':-tabmove<CR>' },
		[ 'tmi' ]              = { ':+tabmove<CR>' },
		-- Opening a terminal window
		[ '<LEADER>/' ]        = { ':set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>' },
		-- Press space twice to jump to the next '' and edit it
		[ '<LEADER><LEADER>' ] = { '<Esc>/<++><CR>:nohlsearch<CR>c4l' },
		-- Spelling Check with <space>sc
		[ '<LEADER>sc' ]       = { ':set spell!<CR>' },
		-- Press ` to change case (instead of ~)
		[ '`' ]                = { '~' },
		[ '<C-c>' ]            = { 'zz' },
		-- Call figlet
		[ 'tx' ]               = { ':r !figlet' },
		[ '<LEADER>-' ]        = { ':lN<CR>' },
		[ '<LEADER>=' ]        = { ':lne<CR>' },
		-- find and replace
		[ '\\s' ]              = { ':%s//g<left><left>' },
		-- set wrap
		[ '<LEADER>sw' ]       = { ':set wrap<CR>' },
	}
	util.noremap_key(mappings)

	local other_global_mappings = {
		-- Clipboard
		['nY']            = { 'y$', {noremap = true, silent = false} }, -- copy to end of line
		['vY']            = { '+y', {noremap = true, silent = false} }, -- copy to system clipboard
		-- Indentation
		['n<']            = { '<<' },
		['n>']            = { '>>' },
		-- Space to Tab
		[ 'n<LEADER>tt' ] = { ':%s/    /\t/g' },
		[ 'v<LEADER>tt' ] = { ':s/    /\t/g' },
		-- Insert mode cursor movement
		[ 'i<C-a>' ]      = {'<ESC>H'},
		[ 'i<C-e>' ]      = {'<ESC>I'},
		-- Command mode cursor movement
		[ 'c<C-a>' ]      = { '<Home>' },
		[ 'c<C-e>' ]      = { '<End>' },
		[ 'c<C-p>' ]      = { '<Up>' },
		[ 'c<C-n>' ]      = { '<Down>' },
		[ 'c<C-b>' ]      = { '<Left>' },
		[ 'c<C-f>' ]      = { '<Right>' },
		[ 'c<M-b>' ]      = { '<S-Left>' },
		[ 'c<M-w>' ]      = { '<S-Right>' },
		-- Open kitty terminal
		['n\\t']          = {":tabe<CR>:-tabmove<CR>:term sh -c 'kitty'<CR><C-\\><C-N>:q<CR>"},
		-- Move next character to the end of the line with ctrl+u
		[ 'i<C-u>' ] =  { '<ESC>lx$p' },
		-- Terminal behavior
		[ 't<C-N>' ] = { "<C-\\><C-N>" },
		[ 't<C-O>' ] = { "<C-\\><C-N><C-O>" },

	}
	util.bind_key(other_global_mappings)
end

do
  local schedule = vim.schedule
  initial_mappings()

  schedule(hererocks)
  schedule(function()
    global_options()
    global_mappings()
  end)

  ui_options()
  rnu()
  folding()
  global_vars()
  py3_host_prog()

  require('vim-plug')
  if not loop.os_getenv('NVIM_BOOTSTRAP') then
    schedule(function()
      require('plugin.init')
    end)
  end
end
