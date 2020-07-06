local vfn = vim.fn
local loop = vim.loop
local cmd = require('lib.cmd')

local second_ms = 1000
local minute_ms = 60 * second_ms

local config_dir = vfn.stdpath('config')
local cache_dir = vfn.stdpath('cache')

local pip_packages = {
  'pip'; 'pip-tools'; 'pynvim'; 'git+https://github.com/luarocks/hererocks.git';
}

local rocks = {
  'lyaml'; 'httpclient'; 'luacheck'; {'--server=https://luarocks.org/dev'; 'luaformatter'};
}

local debug = function(msg)
  if loop.os_getenv('NVIM_DEBUG') then
    print('[DEBUG] ' .. msg)
  end
end

local cmd_to_string = function(cmd_name, args)
  local quoted_args = {}
  for i, arg in ipairs(args or {}) do
    quoted_args[i] = string.format('"%s"', arg)
  end
  return string.format('%s %s', cmd_name, table.concat(quoted_args, ' '))
end

local cmd_status = function(result)
  if not result then
    return 'aborted'
  end

  if result.exit_status == 0 then
    return 'success'
  end

  return string.format('exit status %d - %s', result.exit_status, result.stderr)
end

-- run the given commands and block until all of them are done. it raises an
-- error if any of the command fails, with information about the failure (exit
-- status + stderr).
--
-- The input is a table of commands, where each command is a table in the following format:
--
-- {
--    executable: string;
--    opts: table; (note: this should match vim.loop.spawn options, see lib/cmd.lua for details)
--    timeout_ms: number; (defaults to 10 minutes)
-- }
local run_cmds = function(cmds)
  local ten_minutes_ms = 10 * minute_ms
  local results = {}
  local total_timeout_ms = 0

  for _, c in pairs(cmds) do
    local timeout_ms = c.timeout_ms or ten_minutes_ms
    if timeout_ms > total_timeout_ms then
      total_timeout_ms = timeout_ms
    end

    local cmd_str = cmd_to_string(c.executable, c.opts.args)
    results[cmd_str] = 0
    debug(string.format('running "%s"', cmd_str))
    cmd.run(c.executable, c.opts, nil, function(result)
      results[cmd_str] = result
    end, debug)
  end

  local status = vim.wait(total_timeout_ms, function()
    for _, r in pairs(results) do
      if r == 0 then
        return false
      end
    end
    return true
  end, 500)

  if not status then
    local statuses = {}
    for cmd_str, result in pairs(results) do
      table.insert(statuses, string.format('%s: %s', cmd_str, cmd_status(result)))
    end
    error(string.format('failed to complete all commands in %dms\nStatus:\n', total_timeout_ms,
                        table.concat(statuses, '\n')))
  end
end

local ensure_virtualenv = function()
  local venv_dir = cache_dir .. '/venv'
  if vfn.isdirectory(venv_dir) == 0 then
    run_cmds({
      {
        executable = 'virtualenv';
        opts = {args = {'-p'; 'python3'; venv_dir}};
        timeout_ms = 5 * minute_ms;
      };
    })
  end
  run_cmds({
    {
      executable = cache_dir .. '/venv/bin/pip';
      opts = {
        args = vim.tbl_flatten({
          {'install'; '--upgrade'}; pip_packages;
          {'-r'; config_dir .. '/langservers/requirements.txt'};
        });
      };
    };
  })
  return venv_dir
end

local ensure_hererocks = function(virtualenv)
  local hr_dir = cache_dir .. '/hr'
  if vfn.isdirectory(hr_dir) == 0 then
    run_cmds({
      {
        executable = virtualenv .. '/bin/hererocks';
        opts = {args = {'-j'; 'latest'; '-r'; 'latest'; hr_dir}};
      };
    })
  end

  for _, rock in pairs(rocks) do
    run_cmds({
      {executable = hr_dir .. '/bin/luarocks'; opts = {args = vim.tbl_flatten({'install'; rock})}};
    })
  end

  return hr_dir
end

local setup_langservers = function()
  run_cmds({
    {executable = config_dir .. '/langservers/setup.sh'; opts = {}; timeout = 20 * minute_ms};
  })
end

local install_autoload_plugins = function()
  run_cmds({
    {
      executable = 'curl';
      opts = {
        args = {
          '-sLo'; config_dir .. '/autoload/fzf.vim';
          'https://raw.githubusercontent.com/junegunn/fzf/HEAD/plugin/fzf.vim';
        };
      };
    }; {
      executable = 'curl';
      opts = {
        args = {
          '-sLo'; config_dir .. '/autoload/plug.vim';
          'https://raw.githubusercontent.com/junegunn/vim-plug/HEAD/plug.vim';
        };
      };
    };
  })
end

do
  local autoload_done = false
  vim.schedule(function()
    install_autoload_plugins()
    autoload_done = true
  end)
  local virtualenv = ensure_virtualenv()
  debug(string.format('created virtualenv at "%s"\n', virtualenv))
  local hr_dir = ensure_hererocks(virtualenv)
  debug(string.format('created hererocks at "%s"\n', hr_dir))
  setup_langservers()
  vim.wait(2000, function()
    return autoload_done
  end, 25)
end
