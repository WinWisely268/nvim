--- __  ____   __  _   ___     _____ __  __ _
--- |  \/  \ \ / / | \ | \ \   / /_ _|  \/  |
--- | |\/| |\ V /  |  \| |\ \ / / | || |\/| |
--- | |  | | | |   | |\  | \ V /  | || |  | |
--- |_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|
---
--- Author: @winwisely268
-- ==
-- == Neovim start.lua
-- ==
-- ==
-- ALL OF THIS WILL BE LOADED ONCE SOME OPT PLUGINS ARE LOADED.
-- ==
--
local as = require('lib.async')

--as.async(function()
local gopts = require('globals.options')
-- setup global options
gopts.setup_options()
-- setup global autocommands
gopts.setup_global_autocmd()
-- setup global mappings
local gmap = require('globals.mappings')
gmap.setup_mappings()
-- setup colorscheme , statusline, tabline
require('cosmetics.colors').setup()
require('cosmetics.statusline')
--require('ts.init')
--end)()

vim.schedule(function()
    require('lspc.cfg')
    -- setup colorizer
    require 'colorizer'.setup {
        'css'; 'sass'; 'less'; 'typescript'; 'javascript'; 'vim'; 'html'; 'jsx';
        'lua'
    }
    require('plugin.options')
end)

if vim.g.started_by_firenvim ~= nil then
    vim.o.laststatus = 0
    vim.o.guifont = 'Ligalex\\ Mono:h13'
end
