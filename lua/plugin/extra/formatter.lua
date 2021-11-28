-- shfmt
local shfmt_func = function()
  return {
    exe = 'shfmt',
    args = {'-s', '-ln', 'posix'}
  }
end
-- luafmt
local luafmt_func = function()
  return {
    exe = "lua-format",
    stdin = true
  }
end
local rustfmt_func = function()
  return {
    exe = "rustfmt",
    args = {"--emit=stdout", '--edition=2018'},
    stdin = true
  }
end

local dprint_func = function()
  return {
    exe = "dprint",
    args = {'fmt', vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

local zigfmt_func = function()
  return {
    exe = "zig",
    args = {"fmt", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {dprint_func},
    javascriptreact = {dprint_func},
    typescript = {dprint_func},
    typescriptreact = {dprint_func},
    yaml = {dprint_func},
    markdown = {dprint_func},
    json = {dprint_func},
    bash = {shfmt_func},
    sh = {shfmt_func},
    rust = {rustfmt_func},
    lua = {luafmt_func},
    zig = {zigfmt_func}
  }
})
