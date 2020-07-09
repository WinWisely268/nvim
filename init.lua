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
local lsp_cfg = require('lspc.cfg')
local plug_opts = require('plugin.options')
local gmap = require('globals.mappings')
local gopts = require('globals.options')

-- local neorocks = require('plenary.neorocks')
-- neorocks.setup_hererocks()
-- neorocks.ensure_installed('luacheck')
--
-- ==
-- ALL OF THIS WILL BE LOADED ONCE PLUGINS ARE LOADED.
-- ==
-- setup global options
gopts.setup_options()

-- setup global mappings
gmap.setup_mappings()

-- setup global autocommands
gopts.setup_global_autocmd()

-- setup plugin options
plug_opts.setup_plugin_options()

-- setup plugin mappings
plug_opts.setup_plugin_mappings()

-- setup plugin autocmds
plug_opts.setup_plugin_autocmd()

-- setup lsp configs
lsp_cfg.setup_lsp_cfg()

require'colorizer'.setup {
  'css', 'sass', 'less', 'typescript', 'javascript', 'vim', 'html', 'jst', 'lua',
}
