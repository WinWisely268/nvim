local M = {}

local vfn = vim.fn

local get_dmypy = function()
  return {
    ['lint-command'] = 'dmypy run';
    ['lint-formats'] = {'%f:%l: %trror: %m'; '%f:%l: %tarning: %m'; '%f:%l: %tote: %m'};
  }
end

local get_black = function()
  local nvim_config_path = vfn.stdpath('config')
  local bin = nvim_config_path .. '/langservers/bin/blackd-format'
  return {['format-command'] = bin; ['format-stdin'] = true}
end

local get_isort = function()
  return {['format-command'] = 'isort -'; ['format-stdin'] = true}
end

local get_flake8 = function()
  return {
    ['lint-command'] = 'flake8 --stdin-display-name ${INPUT} -';
    ['lint-stdin'] = true;
    ['lint-formats'] = {[[%f:%l:%c: %m]]};
  }
end

local get_dune = function()
  return {['format-command'] = 'dune format-dune-file'; ['format-stdin'] = true}
end

local get_shellcheck = function()
  return {
    ['lint-command'] = 'shellcheck -f gcc -x';
    ['lint-formats'] = {'%f:%l:%c: %trror: %m'; '%f:%l:%c: %tarning: %m'; '%f:%l:%c: %tote: %m'};
  }
end

local get_luacheck = function()
  return {
    ['lint-command'] = 'luacheck --formatter plain --filename ${INPUT} -';
    ['lint-stdin'] = true;
    ['lint-formats'] = {'%f:%l:%c: %m'};
  }
end

local get_luaformat = function()
  return {['format-command'] = 'lua-format'; ['format-stdin'] = true}
end

local make_if_filename = function(languages)
  return function(fname, cb)
    if vfn.filereadable(fname) == 1 then
      cb(languages)
    end
  end
end

local add_luaformat = function(languages)
  if languages.lua == nil then
    languages.lua = {}
  end
  table.insert(languages.lua, get_luaformat())
end

local add_luacheck = function(languages)
  if languages.lua == nil then
    languages.lua = {}
  end
  table.insert(languages.lua, get_luacheck())
end

local get_config = function()
  local languages = {
    python = {get_flake8(); get_dmypy(); get_black(); get_isort()};
    dune = {get_dune()};
    sh = {get_shellcheck()};
  }

  local if_filename = make_if_filename(languages)
  if_filename('.luacheckrc', add_luacheck)
  if_filename('.lua-format', add_luaformat)

  local cfg = {
    version = 2;
    tools = {
      dmypy = get_dmypy();
      flake8 = get_flake8();
      sort = get_isort();
      black = get_black();
      dune = get_dune();
      shellcheck = get_shellcheck();
      luaformat = get_luaformat();
      luacheck = get_luacheck();
    };
    languages = languages;
  }
  return require('lyaml').dump({cfg}), vim.tbl_keys(languages)
end

function M.gen_config()
  local config_str, fts = get_config()
  local config_file = os.tmpname()
  local h = io.open(config_file, 'w')
  h:write(config_str)
  h:close()
  return config_file, fts
end

return M
