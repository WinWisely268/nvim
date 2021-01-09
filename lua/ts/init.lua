local wanted_parsers = require('ts.fts')
-- setup treesitter
require'nvim-treesitter.configs'.setup({
	indent = {
    enable = true
  };
  highlight = {
    enable = true; -- false will disable the whole extension
    disable = {'tsx','elm','swift','vue','ruby','scala','haskell','julia','php','c_sharp'}
  };
  incremental_selection = {
    -- this enables incremental selection
    enable = true;
    disable = {};
    keymaps = {
      init_selection = '<enter>'; -- maps in normal mode to init the node/scope selection
      node_incremental = 'grn'; -- increment to the upper named parent
      scope_incremental = 'grc'; -- increment to the upper scope (as defined in locals.scm)
      node_decremental = 'grm'
    }
  };
  textobjects = { -- syntax-aware textobjects
	 -- lsp_interop = {
      -- enable = true,
      -- peek_definition_code = {
        -- ["df"] = "@function.outer",
        -- ["dF"] = "@class.outer",
      -- },
    -- },
		move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
	  select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer';
          ['if'] = '@function.inner';
          ['aC'] = '@class.outer';
          ['iC'] = '@class.inner';
          ['ac'] = '@conditional.outer';
          ['ic'] = '@conditional.inner';
          ['ae'] = '@block.outer';
          ['ie'] = '@block.inner';
          ['al'] = '@loop.outer';
          ['il'] = '@loop.inner';
          ['is'] = '@statement.inner';
          ['as'] = '@statement.outer';
          ['ad'] = '@comment.outer';
          ['am'] = '@call.outer';
          ['im'] = '@call.inner'
        }
    },
  };
  refactor = {
    highlight_current_scope = {enable = false};
    highlight_definitions = {enable = false; disable = {}};
    smart_rename = {
      enable = true;
      disable = {};
      keymaps = {smart_rename = 'grr'}
    };
    navigation = {
      enable = false;
      disable = {};
      keymaps = {goto_definition = 'grd'; list_definitions = 'grD'}
    }
  };
  ensure_installed = wanted_parsers
})

-- activate folds only on supported filetypes.
local fts = table.concat(wanted_parsers, ', ')
local fold_augroup = {
  FtFold = {
    {'Filetype'; fts; 'setlocal foldmethod=expr'};
    {'Filetype'; fts; 'setlocal foldexpr=nvim_treesitter#foldexr()'}
  }
}
require('lib.au').create_augroups(fold_augroup)

--  create command to reset treesitter highlights
vim.cmd(
	[[command! -nargs=0 TSRestart :write | edit | TSBufEnable highlight]]
)
