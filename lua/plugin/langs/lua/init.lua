local au = require('lib.au')
local M = {}

function M.setup_lua_autocmd()
  local lua_augroups = {
    OnLuaFt = {
      {'Filetype'; 'lua'; 'nmap <buffer> <LEADER>mrl <Plug>(Luadev-Runline)'};
      {'Filetype'; 'lua'; 'vmap <buffer> <LEADER>mrr <Plug>(Luadev-Run)'};
      {'Filetype'; 'lua'; 'nmap <buffer> <LEADER>mrw <Plug>(Luadev-RunWord)'};
      {'Filetype'; 'lua'; 'imap <buffer> <LEADER>mrc <Plug>(Luadev-Complete)'}
    }
  }
  au.create_augroups(lua_augroups)
end

return M
