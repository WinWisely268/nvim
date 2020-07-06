local vcmd = vim.cmd
local helpers = require('lib.nvim_helpers')

local M = {}

M.fts = {
  'sh'; 'css'; 'go'; 'html'; 'javascript'; 'json'; 'lua'; 'ocaml'; 'python'; 'rust';
  'typescriptreact'; 'typescript'; 'cpp'; 'c'; 'yaml'; 'markdown';
};

function M.set_folding()
  local foldexpr = 'ts#FoldExpr()'

  for _, ft in pairs(M.fts) do
    if ft == vim.bo.filetype then
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = foldexpr
      break
    end
  end

  vcmd([[augroup folding_config]])
  vcmd([[autocmd!]])
  vcmd(string.format([[autocmd FileType %s setlocal foldmethod=expr foldexpr=%s]],
                     table.concat(vim.tbl_flatten(M.fts), ','), foldexpr))
  vcmd([[augroup END]])
end

function M.set_mappings()
  local should_map = false
  for _, ft in pairs(M.fts) do
    if ft == vim.bo.filetype then
      should_map = true
      break
    end
  end
  if not should_map then
    return
  end

  local mappings = {
    n = {
      {lhs = 'gd'; rhs = '<Plug>(ts-goto-definition)'};
      {lhs = 'gnD'; rhs = '<Plug>(ts-list-definitions)'}; {lhs = 'grr'; rhs = '<Plug>(ts-rename)'};
      {lhs = 'gnn'; rhs = '<Plug>(ts-init-selection)'};
    };
    v = {
      {lhs = '<tab>'; rhs = '<Plug>(ts-node-incremental)'};
      {lhs = '<s-tab>'; rhs = '<Plug>(ts-node-decremental)'};
      {lhs = 'grc'; rhs = '<Plug>(ts-scope-incremental)'};
    };
  }
  helpers.create_mappings(mappings)
end

function M.setup()
  vim.fn['plug#load']('nvim-treesitter')
  local configs = require('nvim-treesitter.configs')
  local ts_parsers = require('nvim-treesitter.parsers')
  local wanted_parsers = {}
  for _, ft in pairs(M.fts) do
    table.insert(wanted_parsers, ts_parsers.ft_to_lang(ft))
  end

  configs.setup({
    highlight = {enable = false};
    incremental_selection = {
      enable = true;
      keymaps = {
        init_selection = 'gnn';
        node_incremental = '<tab>';
        scope_incremental = 'grc';
        node_decremental = '<s-tab>';
      };
    };
    refactor = {
      smart_rename = {enable = true; keymaps = {smart_rename = 'grr'}};
      navigation = {enable = true; keymaps = {goto_definition = 'gd'; list_defitinions = 'gnD'}};
    };
    ensure_installed = wanted_parsers;
  })
  configs.commands.TSEnableAll.run('incremental_selection')
  configs.commands.TSEnableAll.run('refactor.smart_rename')
  configs.commands.TSEnableAll.run('refactor.navigation')
  helpers.trigger_ft()
end

return M
