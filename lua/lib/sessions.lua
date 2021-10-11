local dirs = require('lib.dirs')
local session_dir = vim.api.nvim_call_function('stdpath', {'cache'}) ..
                      '/tmp/sessions'

local session_save = function(name)
  dirs.check_create_dir(session_dir)
  local session_file_path = session_dir .. '/' .. name
  vim.cmd('mksession! ' .. vim.fn.fnameescape(session_file_path))
  print('Session file created' .. session_file_path)
end

local session_list = function()
  local session_files = {}
  if dirs.isdir(session_dir) then
    local files = vim.fn.systemlist("cd " .. session_dir .. '&& rg --files')
    for _, file in ipairs(files) do
      table.insert(session_files, session_dir .. '/' .. file)
    end
  end
  return session_files
end

local session_load = function(name)
  vim.cmd('source' .. session_dir .. '/' .. name)
end

local save = function()
  vim.cmd(
    [[command! -nargs=? SessSave lua require('lib.sessions').session_save(<q-args>)]])
end

return {
  session_save = session_save,
  save = save,
  load = session_load,
  list = session_list
}
