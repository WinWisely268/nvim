local util = require('lib.util')
local api = vim.api

local M = {}

function M.lua_ft_opts()
  api.nvim_buf_set_option(0, 'shiftwidth', 2)
  api.nvim_buf_set_option(0, 'tabstop', 2)
  api.nvim_buf_set_option(0, 'softtabstop', 2)
end

function M.setup_lua_autocmd()
  local lua_augroups = {
    OnLuaFt = {
      {'FileType', '*.lua', [[lua require('plugin.langs.lua.init').lua_ft_opts()]]},
      {'BufWrite', '*.lua', 'call LuaFormat()'},
    },
  }
  util.create_augroups(lua_augroups)
end

return M
