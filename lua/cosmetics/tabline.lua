local icons = require('cosmetics.devicon')
local api = vim.api
------------------------------------------------------------------------
--                              TabLine                               --
------------------------------------------------------------------------

local getTabLabel = function(n)
  local current_win = api.nvim_tabpage_get_win(n)
  local current_buf = api.nvim_win_get_buf(current_win)
  local file_name = api.nvim_buf_get_name(current_buf)
  if string.find(file_name, 'term://') ~= nil then
    return icons.deviconTable['terminal'] ..
             api.nvim_call_function('fnamemodify', {file_name; ':p:t'})
  end
  file_name = api.nvim_call_function('fnamemodify', {file_name; ':p:t'})
  if file_name == '' then return 'No Name' end
  local icon = icons.deviconTable[file_name]
  if icon ~= nil then return icon .. ' ' .. file_name end
  return file_name
end

local function tabline()
  local tabline = ''
  local tab_list = api.nvim_list_tabpages()
  local current_tab = api.nvim_get_current_tabpage()
  for _, val in ipairs(tab_list) do
    local file_name = getTabLabel(val)
    if val == current_tab then
      tabline = tabline .. '%#TabLineSelSeparator# ' ..
                  icons.deviconTable['left_separator']
      tabline = tabline .. '%#TabLineSel# ' .. file_name
      tabline = tabline .. ' %#TabLineSelSeparator#' ..
                  icons.deviconTable['right_separator']
    else
      tabline = tabline .. '%#TabLineSeparator# ' ..
                  icons.deviconTable['left_separator']
      tabline = tabline .. '%#TabLine# ' .. file_name
      tabline = tabline .. ' %#TabLineSeparator#' ..
                  icons.deviconTable['right_separator']
    end
  end
  return tabline
end

return {tabline = tabline}
