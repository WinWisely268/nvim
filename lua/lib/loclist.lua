local api = vim.api
local M = {}
local win_pre_copen = nil

local function toggler(close_cmd, open_cmd)
  for _, win in pairs(api.nvim_list_wins()) do
    local buf = api.nvim_win_get_buf(win)
    if api.nvim_buf_get_option(buf, 'buftype') == 'quickfix' then
      api.nvim_command(close_cmd)
      if win_pre_copen then
        api.nvim_command(api.nvim_win_get_number(win_pre_copen) .. 'wincmd w')
        win_pre_copen = nil
      end
      return
    end
  end

  -- no quickfix buffer found so far, so show it
  win_pre_copen = api.nvim_get_current_win()
  api.nvim_command(open_cmd)

end

function M.toggle()
  toggler('lclose', 'lopen')
end

function M.qftoggle()
  toggler('cclose', 'copen')
end

return M
