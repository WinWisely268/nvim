--- __  ____   __  _   ___     _____ __  __ ____   ____
--- |  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
--- | |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
--- | |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
--- |_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|
---
---  Author: @winwisely268
---  Adapted from @theniceboy, @haorenW1025, @wbthomason, @mfussenegger,
---  @theHamsta configs
-- ==
-- == Neovim init.lua
-- ==
local util = require('lib.util')
local color = require('cosmetics.colors')
local cache_dir = os.getenv('XDG_CACHE_HOME')

local function create_vimdirs()
  local vimdirs = {
    cache_dir .. '/nvim/tmp/backup', cache_dir .. '/nvim/tmp/undo',
    cache_dir .. '/nvim/tmp/sessions',
  }
  for _, d in ipairs(vimdirs) do
    util.check_create_dir(d)
  end
end

local function setup_global_autocmd()
  local autocmds = {
    MarkdownSpell = {{'BufRead,BufNewFile', '*.md', 'setlocal spell'}},
    AutoChdir = {{'BufEnter', '*', 'silent! lcd %:p:h'}},
    TermInsert = {{'TermOpen', 'term://*', 'startinsert'}},
    AfterObject = {
      {'VimEnter', '*', 'call after_object#enable(\'=\', \':\', \'-\', \'#\', \' \')'},
    },
  }
  util.create_augroups(autocmds)
end

local function setup_options()
  create_vimdirs()
  local global_settings = {
    --- System
    clipboard = 'unnamedplus',
    mouse = 'a',
    autochdir = true,
    --- Editor Behavior
    number = true,
    relativenumber = true,
    cursorline = true,
    expandtab = false,
    tabstop = 2,
    shiftwidth = 2,
    softtabstop = 2,
    autoindent = true,
    list = true,
    scrolloff = 4,
    ttimeoutlen = 0,
    timeout = false,
    viewoptions = 'cursor,folds,slash,unix',
    wrap = true,
    tw = 0,
    indentexpr = '',
    foldmethod = 'indent',
    foldlevel = 99,
    foldenable = true,
    splitright = true,
    splitbelow = true,
    showmode = false,
    showcmd = true,
    wildmenu = true,
    ignorecase = true,
    smartcase = true,
    swapfile = false,
    inccommand = 'split',
    completeopt = 'longest,noinsert,menuone,noselect,preview',
    visualbell = true,
    backupdir = cache_dir .. '/nvim/tmp/backup,.',
    directory = cache_dir .. '/nvim/tmp/backup,.',
    undofile = true,
    undodir = cache_dir .. '/nvim/tmp/undo,.',
    colorcolumn = '100',
    updatetime = 1000,
    virtualedit = 'block',
    lazyredraw = true,
    termguicolors = true,
  }

  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

  for k, v in pairs(global_settings) do
    vim.o[k] = v
  end

  local editor_setups = {
    -- These options are too pain in the butt
    -- to set from lua, hence the shortcut shit.
    'let &t_ut=\'\'', 'set listchars=tab:\\|\\ ,trail:▫', 'set formatoptions-=r',
    'set shortmess+=c', 'set number', 'set relativenumber', 'hi NonText ctermfg=gray guifg=grey10',
  }

  for _, v in ipairs(editor_setups) do
    vim.cmd(v)
  end
end

local function setup_global_mappings()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  local global_mappings = {
    -- Save and Quit
    ['Q'] = {':Quit<CR>'},
    ['<C-q>'] = {':Qall<CR>'},
    ['S'] = {':w<CR>'},
    -- Open vimrc
    ['<LEADER>rc'] = {':e ~/.config/nvim/init.vim<CR>'},
    ['l'] = {'i'},
    ['L'] = {'I'},
    -- Search
    ['<LEADER><CR>'] = {':nohlsearch<CR>'},
    -- Adjacent duplicate words
    ['<LEADER>dw'] = {'^(\\<\\w\\+\\>\\)\\_s*\1'},
    -- Folding
    ['<LEADER>o'] = {'za'},
    -- Open gitui (Rust alternative to lazygit, great)
    ['\\g'] = {':Git'}, -- fugitive
    ['<c-g>'] = {':tabe<CR>:-tabmove<CR>:term gitui<CR>'},
    -- ==
    -- == Cursor Movement (Colemak hnei)
    -- ==
    --     ^
    --     e
    -- < h   i >
    --     n
    --     v
    ['e'] = {'k'},
    ['n'] = {'j'},
    ['i'] = {'l'},
    ['k'] = {'n'},
    ['ge'] = {'gk'},
    ['gn'] = {'gj'},
    ['E'] = {'5k'},
    ['N'] = {'5j'},
    ['H'] = {'0'}, -- H -> go to start of line
    ['I'] = {'$'}, -- I -> go to end of line
    ['W'] = {'5w'},
    ['B'] = {'5b'},
    ['<C-E>'] = {'5<C-y>'}, -- move up page
    ['<C-N>'] = {'5<C-e>'}, -- move down page
    -- ==
    -- == Window management
    -- ==
    -- Disable the default s key
    ['s'] = {'<nop>'},
    -- split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
    ['se'] = {':Vsplit<CR>'},
    ['sn'] = {':Vsplit<CR>'},
    ['sh'] = {':Split<CR>'},
    ['si'] = {':Split<CR>'},
    -- Resize splits with arrow keys
    ['srh'] = {'<C-w>b<C-w>K'}, -- Rotate screens
    ['srv'] = {'<C-w>b<C-w>H'},
    ['<LEADER>q'] = {'<C-w>j:q<CR> '}, -- Press <SPACE> + q to close the window below the current window
    -- ==
    -- == Tab management
    -- ==
    ['tu'] = {':Tabedit '},
    ['th'] = {':Tabnext'},
    ['ti'] = {':Tabprevious'},
    -- Press ` to change case (instead of ~)
    ['`'] = {'~'},
    ['<C-c>'] = {'zz'},
    ['<LEADER>-'] = {':lN<CR>'},
    ['<LEADER>='] = {':lne<CR>'},
    -- find and replace
    ['\\s'] = {':%s//g<left><left>'},
    -- set wrap
    ['<LEADER>sw'] = {':set wrap<CR>'},
  }
  util.noremap_key(global_mappings)

  local other_global_mappings = {
    -- Clipboard
    ['nY'] = {'y$', {noremap = true, silent = false}}, -- copy to end of line
    ['vY'] = {'+y', {noremap = true, silent = false}}, -- copy to system clipboard
    -- Indentation
    ['n<'] = {'<<'},
    ['n>'] = {'>>'},
    -- Space to Tab
    ['n<LEADER>tt'] = {':%s/    /\t/g'},
    ['v<LEADER>tt'] = {':s/    /\t/g'},
    -- Insert mode cursor movement
    ['i<C-a>'] = {'<ESC>H'},
    ['i<C-e>'] = {'<ESC>I'},
    -- Command mode cursor movement
    ['c<C-a>'] = {'<Home>'},
    ['c<C-e>'] = {'<End>'},
    ['c<C-p>'] = {'<Up>'},
    ['c<C-n>'] = {'<Down>'},
    ['c<C-b>'] = {'<Left>'},
    ['c<C-f>'] = {'<Right>'},
    ['c<M-b>'] = {'<S-Left>'},
    ['c<M-w>'] = {'<S-Right>'},
    -- Move next character to the end of the line with ctrl+u
    ['i<C-u>'] = {'<ESC>lx$p'},
    -- Terminal behavior
    ['t<C-N>'] = {'<C-\\><C-N>'},
    ['t<C-O>'] = {'<C-\\><C-N><C-O>'},

  }
  util.bind_key(other_global_mappings)
end

local function setup_plugin_mappings()
  local plugin_mappings = {
    -- Vim EasyAlign
    ['nsga'] = {'<Plug>(EasyAlign)', {noremap = false, silent = false}},
    ['xsga'] = {'<Plug>(EasyAlign)', {noremap = false, silent = false}},
  }
  util.bind_key(plugin_mappings)
  local plugin_noremap_mappings = {
    -- Vim Sneak
    ['\''] = {'<Plug>Sneak_s', {noremap = false, silent = false}},
    ['"'] = {'<Plug>Sneak_S', {noremap = false, silent = false}},
    ['f'] = {'<Plug>Sneak_f', {noremap = false, silent = false}},
    ['F'] = {'<Plug>Sneak_F', {noremap = false, silent = false}},
  }
  util.noremap_key(plugin_noremap_mappings)
  -- Vim sneak colors
  vim.cmd('highlight Sneak guifg=' .. color.black .. ' guibg=' .. color.yellow ..
            ' ctermfg=black ctermbg=yellow')
  vim.cmd('highlight SneakScope guifg=' .. color.black .. ' guibg=' .. color.yellow ..
            ' ctermfg=black ctermbg=red')
  vim.cmd('highlight SneakLabel guifg=' .. color.black .. ' guibg=' .. color.yellow ..
            ' ctermfg=black ctermbg=yellow gui=bold')
end

-- global autocmd
setup_global_autocmd()
-- global options
setup_options()
-- global mappings
setup_global_mappings()
-- plugin mappings
setup_plugin_mappings()
