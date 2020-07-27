--
-- find project root
-- and cd to it.
--
local util = require('nvim_lsp.util')

local maybe_ancestor = function(p)
  return util.search_ancestors(p, function(path)
    if util.path.is_dir(util.path.join(path, ".git")) then return path end
  end)
end

local auto_cd = function()
  local maybe = maybe_ancestor(vim.fn.getcwd(0))
  local ancestor = maybe ~= "" and maybe or vim.fn.getcwd(0)
  vim.cmd([[lcd ]] .. ancestor)
end

return {auto_cd = auto_cd}
