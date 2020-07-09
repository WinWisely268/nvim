local M = {}

-- Creates an FZF executor for running FZF in lua
-- @param sink_fn Function to execute with selected line(s)
-- @param source to
function M.run(sink_fn, source)
  vim.fn['fzf#run']({{source = source, sink = sink_fn, window = 'call FloatingFZF()'}})
end

return M
