vim.cmd [[packadd packer.nvim]]
-- TODO: Temporary
vim._update_package_paths()
return require('packer').startup(function()
  -- Packer
  use {'wbthomason/packer.nvim'; opt = true}
  -- plenary & luvjob
  use {'tjdevries/plenary.nvim'; opt = true}
  use {'tjdevries/luvjob.nvim'; opt = true}
  -- statusline
  use {'tjdevries/expressline.nvim'; opt = true}
  -- nvim-luadev
  use {'bfredl/nvim-luadev'; opt = true; cmd = {'Luadev'}}
  -- Fastest colorizer (for real)
  use {'norcalli/nvim-colorizer.lua'; opt = true}
  -- Fuzzy finder
  use {
    'junegunn/fzf.vim';
    opt = true;
    cmd = {
      'Files'; 'Rg'; 'History'; 'Commands'; 'Help'; 'Lines'; 'Buffers';
      'Commits'; 'Tags'; 'BTags'
    }
  }
  -- Tag finder
  use {'liuchengxu/vista.vim'; opt = true; cmd = {'Vista'}}
  -- Debugger, following Debug Adapter Protocol
  -- use {'mfussenegger/nvim-dap', opt = true, ft = {'rust', 'py'}}
  -- Builtin lsp
  use {'neovim/nvim-lsp'; opt = true}
  -- Completion for lsp
  use {
    'nvim-lua/completion-nvim';
    opt = true;
    after = 'nvim-lsp';
    requires = {
      {'hrsh7th/vim-vsnip'; opt = true; after = 'nvim-lsp'};
      {'hrsh7th/vim-vsnip-integ'; opt = true; after = 'nvim-lsp'}
      -- {'steelsojka/completion-buffers', opt = true, after = 'nvim-lsp'}
    }
  }
  -- Diagnostics for lsp
  use {'nvim-lua/diagnostic-nvim'; opt = true; after = 'nvim-lsp'}
  -- Tree-sitter
  use {'nvim-treesitter/nvim-treesitter'; opt = true}
  -- Golang stuff
  -- use {'fatih/vim-go'; opt = true; ft = {'go'}}
  -- Zig stuff
  -- use 'ziglang/zig.vim'
  -- Git blame & commits
  use {
    'rhysd/git-messenger.vim';
    opt = true;
    cmd = {'GitMessenger'};
    keys = {'(gitmessenger'}
  }
  -- GitGutter
  use {'mhinz/vim-signify'; opt = true}
  -- Undo visualization
  use {'simnalamburt/vim-mundo'; opt = true; cmd = {'MundoToggle'}}
  -- Vimtex
  use {'lervag/vimtex'; opt = true; ft = {'tex'}}
  -- Markdown plugins
  use {
    'dhruvasagar/vim-table-mode';
    opt = true;
    ft = {'md'; 'wiki'};
    cmd = {'TableModeToggle'}
  }
  use {
    'euclio/vim-markdown-composer';
		opt = true;
    run = 'cargo build --release --locked --no-default-features --features json-rpc';
    cmd = {'ComposerStart'; 'ComposerUpdate'; 'ComposerOpen'}
  }
  -- Essentials
  use 'tpope/vim-surround'
  -- Easily align shit
  use 'junegunn/vim-easy-align'
  -- Jump anywhere
  use 'justinmk/vim-sneak'
  -- Calendar inside vim
  -- use {'itchyny/calendar.vim'; opt = true; cmd = {'Calendar'}}
  -- Pretty please with a cherry on top
  use 'tpope/vim-commentary'
  -- Firenvim (nvim inside firefox)
  use {'glacambre/firenvim'; opt = true; run = ':call firenvim#install(0)'}
  -- pear-tree (because it annoys me to have 'common sense'
  use 'tmsvg/pear-tree'
  -- formatter
  use {
    'sbdchd/neoformat';
    opt = true;
    ft = {'lua'; 'rust'; 'fish'; 'yaml'; 'xml'; 'json'; 'html'; 'c'; 'markdown'}
  }
  use {
    'winwisely268/findr.vim';
    opt = true;
    branch = 'centered';
    cmd = {'Findr'; 'FindrLocList'}
  }
  use {
    'lervag/wiki.vim';
    opt = true;
    event = {'BufNewFile ~/Notes/**/*.md'; 'BufReadPre ~/Notes/**/*.md'};
    cmd = {
      'WikiJournal'; 'WikiOpen'; 'WikiFzfPages'; 'WikiFzfToc'; 'WikiEnable';
      'WikiIndex'; 'WikiFzfTags'
    }
  }
	use 'lambdalisue/suda.vim';
end)

