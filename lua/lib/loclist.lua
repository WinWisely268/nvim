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

function M.toggle() toggler('lclose', 'lopen') end

function M.qftoggle() toggler('cclose', 'copen') end

function M.get_loclist()
  local api = vim.api
  local loclist = api.nvim_call_function('getloclist', {0})
  local result = {}
  for _, err in ipairs(loclist) do
    local name = vim.api.nvim_call_function('bufname', {err.bufnr})
    local display = ' ' .. err.lnum .. ':' .. err.col .. ' ' ..name.. ' -> '.. err.text
    table.insert(result, display)
  end
  return result
end

function M.get_quickfix()
  local ll = vim.api.nvim_call_function('getqflist', {0})
  for _, v in ipairs(ll) do print(v) end
end

function M.open_loc_item(e)
  local line = e
  local filename = vim.fn.fnameescape(vim.fn.split(line, [[:\d\+:]])[1])
  local linenr = vim.fn.matchstr(line, [[:\d\+:]])
  local column = vim.fn.matchstr(line, [[\(:\d\+\)\@<=:\d\+:]])
  vim.cmd('e ' .. filename)
  vim.cmd('call cursor('..linenr..','..column')')
end

return M

