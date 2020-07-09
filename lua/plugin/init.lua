-- Wrapper for vim-packager
local M = {}
local vcmd = vim.cmd
-- local options = require('plugin.options')

local config_path = vim.api.nvim_call_function('stdpath', {'config'}):gsub('\\', '/')

function M.root()
  return vim.loop.os_homedir() .. '/.local/share/nvim/site/pack/packer'
end

local function download()
  local path = M.root() .. '/opt/packer.nvim/'
  local url = 'https://github.com/wbthomason/packer.nvim'
  if vim.api.nvim_call_function('filereadable', {path .. 'LICENSE'}) ~= 1 then
    vim.api.nvim_command(string.format('!git clone %q %q', url, path))
  end
end

local function create_machine_specific_file()
  local specific_file_path = vim.api.nvim_call_function('filereadable',
                                                        {config_path .. '/machine_specific.vim'})
  if specific_file_path ~= 1 then
    vim.api.nvim_command(string.format('!cp %q %q',
                                       config_path .. '/_machine_specific.vim.example',
                                       config_path .. '/machine_specific.vim'))
  end
  vcmd([[source ]] .. config_path .. '/machine_specific.vim')
end

local function loadpkg(pkg)
  return vcmd('packadd! ' .. pkg)
end

local function load_eager()
  -- ==
  -- == LOAD ALL PACKAGES IN THE start packpath
  -- ==
  -- 	"nord-vim",
  -- 	"editorconfig-vim",
  -- 	"vim-multiple-cursors",
  -- 	"vim-surround",
  -- 	"wildfire.vim",
  -- 	"vim-after-object",
  -- 	"vim-easy-align",
  -- 	"vim-sneak",
  return vcmd('packloadall!')
end

local function load_extras()
  -- ==
  -- == Load optional packages when vscode-neovim is not active.
  local extra_pkgs = {
    -- luarocks & neorocks
    'plenary.nvim', 'luvjob.nvim', -- package manager
    'packer.nvim', -- fastest colorizer
    'nvim-colorizer.lua', -- lcd & tcd
    'vim-rooter', -- LSP
    'nvim-lsp', 'completion-nvim', 'diagnostic-nvim', 'completion-buffers', 'lsp-status.nvim',
    'vim-vsnip', 'vim-vsnip-integ', -- Statusline
    'gina.vim', 'vim-signify', -- Sudo
    'suda.vim', -- Sessions
    'vim-obsession', 'vim-bookmarks', -- tree
    'nvim-tree.lua', 'nvim-web-devicons', -- auto pairs
    'auto-pairs', -- close tags for html and others
    'vim-closetag', -- comment
    'tcomment_vim',
  }
  if vim.g.vscode == nil then
    for _, pkg in ipairs(extra_pkgs) do
      loadpkg(pkg)
    end
  end
end

function M.setup()
  download()
  create_machine_specific_file()
  local schedule = vim.schedule
  local done_loading_pkgs = 0
  schedule(function()
    require('plugin.pkgs')
    done_loading_pkgs = 1
  end)
  if done_loading_pkgs then
    local all_installed = 1
    require('plugin.commands').packer_cmds()
    if vim.loop.os_getenv('NVIM_BOOTSTRAP') then
      all_installed = 0
      vcmd([[PkgInstall]])
      all_installed = 1
    end
    if all_installed then
      load_eager()
      load_extras()
    end
  end
end

local function setup_hererocks()
  local neorocks = require('plenary.neorocks')
  neorocks.setup_hererocks()
  neorocks.ensure_installed('luacheck')
  neorocks.ensure_installed({'--server=https://luarocks.org/dev', 'luaformatter'})
end

return M
