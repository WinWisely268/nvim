--
-- directory utility
--
local vim = vim

local isdir = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat ~= nil and stat.type == 'directory'
end

local check_create_dir = function(path)
	-- directory permission is set to 0755 by default
	return isdir(path) or vim.fn.mkdir(path, 'p', 0755)
end

return {isdir = isdir; check_create_dir = check_create_dir}
