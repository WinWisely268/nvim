local api = vim.api
local vcmd = vim.cmd
local vfn = vim.fn
local loop = vim.loop
local cmd = require('lib.cmd')

local state = {running = false; port = 0; token = ''}

local M = {}

local load_state = function()
  local state_file = string.format('%s/.prettierd', loop.os_homedir())
  local f = io.open(state_file)
  local contents = f:read('all*')
  f:close()

  local parts = vim.split(contents, ' ')
  if #parts ~= 2 then
    error('invalid state file: ' .. contents)
  end
  state.running = true
  state.port = tonumber(parts[1])
  state.token = parts[2]
end

local start_server = function()
  local exec_path = string.format('%s/langservers/node_modules/.bin/prettierd',
                                  vfn.stdpath('config'))
  cmd.run(exec_path, {args = {'start'}}, nil, function(result)
    if result.exit_status ~= 0 then
      error(string.format('failed to start prettierd - %d: %s', result.exit_status, result.stderr))
    end

    load_state()
  end)
end

local wait_for_server = function(timeout_ms)
  timeout_ms = timeout_ms or 200
  local status = vim.wait(timeout_ms, function()
    return state.running
  end, 25)

  if not status then
    error(string.format('server didnt start after %dms', timeout_ms))
  end
end

local ensure_relative_path = function(cwd, fpath)
  if vim.startswith(fpath, cwd) then
    return string.sub(fpath, string.len(cwd) + 1)
  end
  return fpath
end

function M.format(cb, is_retry)
  if not state.running then
    start_server()
    wait_for_server(1000)
  end

  local fname = vfn.expand('%')
  local bufnr = vfn.bufnr(fname)
  local view = vfn.winsaveview()
  local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local cwd = vfn.getcwd()
  table.insert(lines, 1,
               string.format('%s %s %s', state.token, cwd, ensure_relative_path(cwd, fname)))

  local write_to_buf = function(data)
    local new_lines = vim.split(data, '\n')
    while new_lines[#new_lines] == '' do
      table.remove(new_lines, #new_lines)
    end

    if vim.tbl_isempty(new_lines) then
      return
    end

    if string.find(new_lines[#new_lines], '^# exit %d+') then
      error(string.format('failed to format with prettier: %s', data))
    end

    local write = false
    for i, line in ipairs(new_lines) do
      if line ~= lines[i] then
        write = true
        break
      end
    end
    if write then
      api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
    end
    vfn.winrestview(view)
    if cb ~= nil then
      cb()
    end
  end

  local client = loop.new_tcp()
  loop.tcp_connect(client, '127.0.0.1', state.port, function(err)
    if err then
      state.running = false
      if is_retry then
        error('failed to connect to prettierd: ' .. err)
      else
        return M.format(cb, true)
      end
    end

    local data = ''
    loop.read_start(client, function(read_err, chunk)
      if read_err then
        error('failed to read data from prettierd: ' .. read_err)
      end
      if chunk then
        data = data .. chunk
      else
        loop.close(client)
        vim.schedule(function()
          write_to_buf(data)
        end)
      end
    end)

    loop.write(client, table.concat(lines, '\n'))
    loop.shutdown(client)
  end)
end

function M.auto_format()
  local enable, timeout_ms = require('lib.autofmt').config()
  if not enable then
    return
  end

  local finished = false
  pcall(function()
    M.format(function()
      finished = true
    end)
  end)
  vim.wait(timeout_ms, function()
    return finished == true
  end, 25)
end

function M.enable_auto_format()
  vcmd([[augroup prettierd_autofmt]])
  vcmd([[autocmd!]])
  vcmd([[autocmd BufWritePre <buffer> lua require('plugin.prettierd').auto_format()]])
  vcmd([[augroup END]])
end

return M
