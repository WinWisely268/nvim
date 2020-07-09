local packer = nil
local function init()
  if packer == nil then
    packer = require('packer')
    packer.init()
  end

  local use = packer.use
  packer.reset()

  -- Packer
  use {'wbthomason/packer.nvim', opt = true}
  -- plenary & luvjob
  use {'tjdevries/plenary.nvim', opt = true}
  use {'tjdevries/luvjob.nvim', opt = true}
  -- Nord colorscheme
  use 'arcticicestudio/nord-vim'
  -- Change directory on edit
  use {'airblade/vim-rooter', opt = true}
  -- Fastest colorizer (for real)
  use {'norcalli/nvim-colorizer.lua', opt = true}
  -- Fuzzy finder
  use {
    'junegunn/fzf.vim',
    opt = true,
    cmd = {'Files', 'Rg', 'History', 'Commands', 'Help', 'Lines', 'Buffers'},
  }
  -- Tag finder
  use {'liuchengxu/vista.vim', opt = true, cmd = {'Vista'}}
  -- Debugger, following Debug Adapter Protocol
  use {'mfussenegger/nvim-dap', opt = true, ft = {'rs', 'c', 'cpp', 'py'}}
  -- Builtin lsp
  use {'neovim/nvim-lsp', opt = true}
  -- Completion for lsp
  use {
    'nvim-lua/completion-nvim',
    opt = true,
    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}},
  }
  use {'steelsojka/completion-buffers', opt = true}
  -- Diagnostics for lsp
  use {'nvim-lua/diagnostic-nvim', opt = true}
  use {'nvim-lua/lsp-status.nvim', opt = true}
  -- Golang stuff
  use {'fatih/vim-go', opt = true, ft = {'go'}}
  -- Async git
  use {'lambdalisue/gina.vim', opt = true}
  -- GitGutter
  use {'mhinz/vim-signify', opt = true}
  -- NERDTree alternative in Lua
  use {
    'kyazdani42/nvim-tree.lua',
    opt = true,
    cmd = {'LuaTreeToggle', 'LuaTreeRefresh', 'LuaTreeOpen', 'LuaTreeClose'},
    requires = {{'kyazdani42/nvim-web-devicons', opt = true}},
  }
  -- UndoTree
  use {'mbbill/undotree', opt = true, cmd = {'UndotreeToggle'}}
  -- Vimtex
  use {'lervag/vimtex', opt = true, ft = {'tex'}}
  -- Markdown plugins
  use {'dhruvasagar/vim-table-mode', opt = true, ft = {'md'}, cmd = {'TableModeToggle'}}
  use {'mzlogin/vim-markdown-toc', opt = true, ft = {'md'}}
  -- Markdown
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = {'MarkdownPreview'}}
  -- Essentials
  use 'tpope/vim-surround'
  use 'terryma/vim-multiple-cursors'
  -- Sessions
  use {'tpope/vim-obsession', opt = true}
  -- AutoCloseTags
  use {'alvan/vim-closetag', opt = true}
  -- Visually selects closest object
  use 'gcmt/wildfire.vim'
  -- Delete after object
  use 'junegunn/vim-after-object'
  -- Easily align shit
  use 'junegunn/vim-easy-align'
  -- Jump anywhere
  use 'justinmk/vim-sneak'
  -- Editorconfig
  use 'editorconfig/editorconfig-vim'
  -- Distraction-free writing
  use {'junegunn/goyo.vim', opt = true, cmd = {'Goyo'}}
  -- Bookmarks plugin
  use {
    'MattesGroeger/vim-bookmarks',
    opt = true,
    keys = {
      'BookmarkToggle', 'BookmarkAnnotate', 'BookmarkShowAll', 'BookmarkNext', 'BookmarkPrev',
      'BookmarkClear', 'BookmarkClearAll', 'BookmarkMoveUp', 'BookmarkMoveDown',
      'BookmarkMoveToLine',
    },
  }
  -- Calendar inside vim
  use {'itchyny/calendar.vim', opt = true, cmd = {'Calendar'}}
  -- Pretty please with a cherry on top
  use 'lambdalisue/suda.vim'
  use {'jiangmiao/auto-pairs', opt = true}
  use {'tomtom/tcomment_vim', opt = true}
  -- Autoformat lua
  use {'andrejlevkovitch/vim-lua-format', ft = {'lua'}, opt = true}
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
