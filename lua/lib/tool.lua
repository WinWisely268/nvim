--
-- other tools
--
local jobby = require('luvjob')
local api = vim.api

local function endswith(str, ending)
  return ending == '' or str:sub(-(#ending)) == ending
end

local function close_git_status()
  local wins = api.nvim_list_wins()
  for _, w in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(w)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if endswith(buf_name, '.git/index') then vim.api.nvim_win_close(w, false) end
  end
end

local function async_on_stdout(err, data)
  if err then
    vim.cmd.echoerr('error: ', err)
  elseif data then
    local lines = vim.fn.split(data, '\n')
    for _, line in ipairs(lines) do print(line) end
  end
end

local send_notification = function(text)
  local osname = vim.loop.os_uname().sysname
  local notification = {}
  if osname == 'Linux' then
    notification.command = 'notify-send'
    notification.args = {string.format('%s\n succeeded', text)}
  elseif osname == 'Darwin' then
    notification.command = 'osascript'
    notification.args = {
      '-e'; [[display notification "]] .. text ..
        [[" with title "NVIM" sound name "Submarine"]]
    }
  end
  local notify = jobby:new({
    command = notification.command;
    args = notification.args;
    on_stdout = async_on_stdout;
    on_stderr = async_on_stdout;
    on_exit = function(code, _)
      if code == 0 then print('notification sent') end
    end

  })
  notify:start()
end

local async_git_push = function(force)
  local git_push = jobby:new({
    command = 'git';
    args = {'push'; (force and '-f' or '')};
    on_stdout = async_on_stdout;
    on_stderr = async_on_stdout;
    on_exit = function(code, text)
      if code == 0 then send_notification(text) end
    end
  })
  git_push:start()
  close_git_status()
end

-- custom command where cmd is a table
local async_custom_cmd = function(cmd)
  local job = jobby:new({
    command = cmd.command;
    args = cmd.args;
    on_stdout = async_on_stdout;
    on_exit = function(code, _)
      if code == 0 then
        print(string.format('%s done, success!', cmd.command))
      end
    end
  })
  job:start()
  send_notification(string.format('%s done, success!', cmd.command))
end

return { async_git_push = async_git_push; async_custom_cmd = async_custom_cmd}
