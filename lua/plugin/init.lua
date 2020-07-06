local vcmd = vim.cmd
local helpers = require('lib.nvim_helpers')

local setup_fzf_mappings = function()
  helpers.create_mappings({
    n = {
      -- {lhs = '<leader>ff'; rhs = helpers.cmd_map('FzfFiles'); opts = {silent = true}};
      {lhs = '<leader>;'; rhs = helpers.cmd_map('FzfCommands'); opts = {silent = true}};
      -- {lhs = '<leader>zb'; rhs = helpers.cmd_map('FzfBuffers'); opts = {silent = true}};
      -- {lhs = '<leader>zl'; rhs = helpers.cmd_map('FzfLines'); opts = {silent = true}};
      {
        lhs = '<leader>gg';
        rhs = helpers.cmd_map('lua require("plugin.fuzzy").rg()');
        opts = {silent = true};
      }; {
        lhs = '<leader>gw';
        rhs = helpers.cmd_map('lua require("plugin.fuzzy").rg_cword()');
        opts = {silent = true};
      };
    };
  })
end

local setup_terminal_commands = function()
  vcmd([[command! T lua require('plugin.terminal').terminal_here()]])
end

local setup_completion = function()
  vim.g.completion_trigger_on_delete = 1
  vim.g.completion_auto_change_source = 1
  vim.g.completion_confirm_key = [[\<C-y>]]
  vim.g.completion_matching_strategy_list = {'exact'; 'fuzzy'}
  vim.g.completion_chain_complete_list = {
    {complete_items = {'lsp'}}; {complete_items = {'buffers'}}; {mode = {'<c-p>'}};
    {mode = {'<c-n>'}};
  }
end

local setup_hlyank = function()
  vcmd([[augroup yank_highlight]])
  vcmd([[autocmd!]])
  vcmd([[autocmd TextYankPost * silent! lua require('vim.highlight').on_yank('HlYank', 300)]])
  vcmd([[augroup END]])
end

local setup_global_ns = function()
  _G.f = require('plugin.global')
end

local setup_word_replace = function()
  helpers.create_mappings({
    n = {
      {
        lhs = '<leader>e';
        rhs = helpers.cmd_map('lua require("plugin.word_sub").run()');
        opts = {silent = true};
      };
    };
  })
end

local setup_spell = function()
  local filetypes = {'gitcommit'; 'markdown'; 'text'}
  vcmd([[augroup auto_spell]])
  vcmd([[autocmd!]])
  vcmd(string.format([[autocmd FileType %s setlocal spell]], table.concat(filetypes, ',')))
  vcmd([[augroup END]])
end


local setup_prettierd = function()
  local auto_fmt_fts = {
    'json'; 'javascript'; 'typescript'; 'css'; 'html'; 'typescriptreact'; 'yaml';
  }
  vcmd([[augroup auto_prettierd]])
  vcmd([[autocmd!]])
  vcmd(string.format([[autocmd FileType %s lua require('plugin.prettierd').enable_auto_format()]],
                     table.concat(auto_fmt_fts, ',')))
  vcmd(string.format(
         [[autocmd FileType %s nmap <buffer> <silent> <leader>f <cmd>lua require('plugin.prettierd').format()<cr>']],
         table.concat(auto_fmt_fts, ',')))
  vcmd([[augroup END]])
end

do
  local schedule = vim.schedule
  schedule(setup_completion)
  schedule(setup_global_ns)
  schedule(setup_fzf_mappings)
  schedule(setup_hlyank)
  schedule(setup_terminal_commands)
  schedule(setup_word_replace)
  schedule(setup_spell)
  schedule(setup_prettierd)
  schedule(function()
    require('lc.init')
    require('plugin.ts').set_folding()
    helpers.trigger_ft()
  end)
  vcmd('colorscheme nord')
end
