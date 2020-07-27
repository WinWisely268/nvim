local sessions = require('lib.sessions')
local M = {}

-- Creates an FZF executor for running FZF in lua
-- @param sink_fn Function to execute with selected line(s)
-- @param source to
function M.run(opts)
  vim.fn['fzf#run'](vim.fn['fzf#wrap'] {
    source = opts.source;
    sink = opts.sink_fn;
    window = {width = 0.8; height = 0.7; border = true};
    opts = opts.opts or os.getenv('FZF_DEFAULT_OPTS')
  })
end

-- killy buffah
function M.kill_buffers() return M.run({sink_fn = 'bd'; source = 'ls'}) end

-- load sessions
function M.load_sessions()
  return M.run({sink_fn = 'source'; source = sessions.list()})
end

-- list loclist
-- TODO: create funcref in lua maybe?
function M.get_loclist()
	return M.run({sink_fn = 'll'; source = require('lib.loclist').get_loclist(), opts = {'--reverse'}})
end

return M
