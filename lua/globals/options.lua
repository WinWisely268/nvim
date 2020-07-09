local util = require('lib.util')
local color = require('cosmetics.colors')
local M = {}

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

function M.setup_global_autocmd()
  local autocmds = {
    MarkdownSpell = {{'BufRead,BufNewFile', '*.md', 'setlocal spell'}},
    AutoChdir = {{'BufEnter', '*', 'silent! lcd %:p:h'}},
    TermInsert = {{'TermOpen', 'term://*', 'startinsert'}},
  }
  util.create_augroups(autocmds)
end

function M.setup_options()
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

return M
