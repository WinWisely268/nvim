local wanted_parsers = require('ts.fts')
-- setup treesitter
require'nvim-treesitter.configs'.setup({
  highlight = {
    enable = true; -- false will disable the whole extension
    disable = {'tsx','elm','toml','nix','swift','vue','ruby','scala','haskell','julia','php','c_sharp'}
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
    enable = true;
    disable = {};
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
  };
  node_movement = {
    -- this enables incremental selection
    enable = true;
    highlight_current_node = false;
    disable = {};
    keymaps = {
      move_up = '<a-e>';
      move_down = '<a-n>';
      move_left = '<a-h>';
      move_right = '<a-i>'
    }
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
