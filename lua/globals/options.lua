local dirs = require('lib.dirs')
local au = require('lib.au')
local M = {}

local cache_dir = vim.api.nvim_call_function('stdpath', {'cache'})

local function create_vimdirs()
  local vimdirs = {
    cache_dir .. '/nvim/tmp/backup'; cache_dir .. '/nvim/tmp/undo';
    cache_dir .. '/nvim/tmp/sessions'
  }
  for _, d in ipairs(vimdirs) do dirs.check_create_dir(d) end
end

function M.setup_global_autocmd()
  local autocmds = {
    TermInsert = {
      {'TermOpen'; 'term://*'; 'startinsert'};
      {'TermOpen'; 'term://*'; 'setlocal norelativenumber'}
    };
    SpellSetup = {{'FileType'; 'gitcommit, text'; 'setlocal spell'}}
  }
  au.create_augroups(autocmds)
end

function M.setup_options()
  create_vimdirs()
  -- FZF
  vim.cmd('set rtp+=$XDG_CONFIG_HOME/fzf')
  local global_settings = {
    --- System
    clipboard = 'unnamedplus';
    mouse = 'a';
    autochdir = true;
    --- Editor Behavior
    number = true;
    relativenumber = true;
    cursorline = true;
    expandtab = false;
    tabstop = 2;
    shiftwidth = 2;
    softtabstop = 2;
    autoindent = true;
    list = true;
    scrolloff = 4;
    ttimeoutlen = 0;
    timeout = false;
    viewoptions = 'cursor,folds,slash,unix';
    foldmethod = 'indent';
    wrap = true;
    tw = 0;
    indentexpr = '';
    foldlevel = 99;
    foldenable = true;
    splitright = true;
    splitbelow = true;
    showmode = false;
    showcmd = true;
    wildmenu = true;
    ignorecase = true;
    smartcase = true;
    swapfile = false;
    inccommand = 'split';
    completeopt = 'longest,noinsert,menuone,noselect,preview';
    visualbell = true;
    backupdir = cache_dir .. '/nvim/tmp/backup,.';
    directory = cache_dir .. '/nvim/tmp/backup,.';
    undofile = true;
    undodir = cache_dir .. '/nvim/tmp/undo,.';
    colorcolumn = '100';
    updatetime = 300;
    virtualedit = 'block';
    shortmess = 'filnxtToOFIc';
    listchars = [[trail:·,nbsp:␣,tab:  ]]
  }

  for k, v in pairs(global_settings) do vim.o[k] = v end

  local global_pkg_settings = {
    netrw_silent = 1;
    loaded_2html_plugin = 1;
    loaded_gzip = 1;
    loaded_man = 1;
    loaded_matchit = 1;
    loaded_matchparen = 1;
    loaded_shada_plugin = 1;
    loaded_spellfile_plugin = 1;
    loaded_tarPlugin = 1;
    loaded_tutor_mode_plugin = 1;
    loaded_vimballPlugin = 1;
    loaded_zipPlugin = 1;
    loaded_netrwPlugin = 1;
    loaded_python_provider = 0;
    loaded_ruby_provider = 0;
    loaded_perl_provider = 0;
    loaded_node_provider = 0;
    netrw_use_noswf = 0;
    -- FZF
    fzf_preview_window = 'right:70%';
    fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"';
    fzf_layout = {
      window = [[lua require('lib.window').floating_window({width = 0.8, height = 0.7, border = true})]]
    };
  }

  for k, v in pairs(global_pkg_settings) do vim.g[k] = v end
end

return M
