local co = coroutine
local luv = vim.loop

-- use with wrap
local spawn = function(shell, opts, cb)

  local stdin = luv.new_pipe(false)
  local stdout = luv.new_pipe(false)
  local stderr = luv.new_pipe(false)
  local args = {
    stdio = {stdin, stdout, stderr},
    args = opts.args or {}
  }

  local process, pid = nil, nil
  local out, errs = {}, {}

  process, pid = luv.spawn(shell, args, function(code)
    local handles = {stdin, stdout, stderr, process}
    for _, handle in ipairs(handles) do luv.close(handle) end
    cb(code, table.concat(out), table.concat(errs))
  end)
  assert(process, pid)

  luv.read_start(stdout, function(err, data)
    assert(not err, err)
    if data then table.insert(out, data) end
  end)

  luv.read_start(stderr, function(err, data)
    assert(not err, err)
    if data then table.insert(errs, data) end
  end)

  if opts.stream then
    luv.write(stdin, opts.stream, function(err)
      assert(not err, err)
      luv.shutdown(stdin, function(err) assert(not err, err) end)
    end)
  end
end

-- use with wrap
local subscribe = function(func, callback)
  assert(type(func) == "function", "type error :: expected func")
  local thread = co.create(func)
  local step = nil
  step = function(...)
    local stat, ret = co.resume(thread, ...)
    assert(stat, ret)
    if co.status(thread) == "dead" then
      (callback or function() end)(ret)
    else
      assert(type(ret) == "function", "type error :: expected func")
      ret(step)
    end
  end
  step()
end

-- inject another function
local wrap = function(func)
  assert(type(func) == "function", "error: expecting function")
  local factory = function(...)
    local params = {...}
    local thunk = function(step)
      table.insert(params, step)
      return func(unpack(params))
    end
    return thunk
  end
  return factory
end

-- join thunks
local join = function(thunks)
  local len = table.getn(thunks)
  local done = 0
  local acc = {}
  local thunk = function(step)
    if len == 0 then return step() end
    for i, tk in ipairs(thunks) do
      assert(type(tk) == "function", "thunk must be function")
      local callback = function(...)
        acc[i] = {...}
        done = done + 1
        if done == len then step(unpack(acc)) end
      end
      tk(callback)
    end
  end
end

-- sugar over coroutine
local await = function(defer)
  assert(type(defer) == "function", "error: expected func")
  return co.yield(defer)
end

local await_all = function(defer)
  assert(type(defer) == "table", "error: expected table")
  return co.yield(join(defer))
end

return {
  spawn = wrap(spawn),
  async = wrap(subscribe),
  await = await,
  await_all = await_all,
  wrap = wrap
}
