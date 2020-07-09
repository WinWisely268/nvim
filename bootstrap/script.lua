local loop = vim.loop

local debug = function(msg)
  if loop.os_getenv('NVIM_DEBUG') then
    print('[DEBUG] ' .. msg)
  end
end

do
  local hererocks_done = false
  vim.schedule(function()
    local nrock = require('plenary.neorocks')
    nrock.setup_hererocks()
    nrock.ensure_installed('luacheck')
    debug(string.format('neorocks installed'))
    hererocks_done = true
  end)
  vim.wait(10000, function()
    return hererocks_done
  end, 25)
end

