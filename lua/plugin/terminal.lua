local M = {}

local vcmd = vim.cmd
local vfn = vim.fn

local run_in_terminal = function(wd, cmd)
  -- Use vfn.termopen() instead?
  vcmd(string.format('belowright split | resize 20 | lcd %s | term %s', wd, cmd))
end

function M.terminal_cmd(wd)
  if wd == nil then
    wd = vfn.getcwd()
  end
  local cmd = vfn.input('＞ ')
  run_in_terminal(wd, cmd)
end

function M.terminal_here()
  M.terminal_cmd(vfn.expand('%:h'))
end

return M
