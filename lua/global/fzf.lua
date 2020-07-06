local M = {}

local vcmd = vim.cmd
local lsp = vim.lsp
local nvim_input = vim.api.nvim_input
local vfn = vim.fn

local fzf_actions = {['ctrl-t'] = 'tabedit'; ['ctrl-x'] = 'split'; ['ctrl-v'] = 'vsplit'}

local lines_to_loc_list = function(lines)
  local items = {}
  for _, line in ipairs(lines) do
    local _, _, filename, lnum, col, text = string.find(line, [[([^:]+):(%d+):%[(%d+)%]:(.*)]])
    if filename then
      table.insert(items, {filename = filename; lnum = lnum; col = col; text = text})
    end
  end
  return items
end

function M.handle_lsp_line(lines)
  if #lines < 2 then
    return
  end

  local first_line = table.remove(lines, 1)
  local action = fzf_actions[first_line] or 'edit'
  local loc_list = lines_to_loc_list(lines)
  if #loc_list < 1 then
    return
  end

  if #loc_list == 1 then
    local item = loc_list[1]
    vcmd(string.format('%s %s', action, item.filename))
    vfn.cursor(item.lnum, item.col)
    nvim_input('zvzz')
  else
    lsp.util.set_loclist(loc_list)
    vcmd('lopen')
    vcmd('wincmd p')
    vcmd('ll')
  end
end

return M
