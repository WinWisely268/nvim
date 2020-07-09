local M = {}
local vcmd = vim.cmd
-- ==
-- == Package Management commands
function M.packer_cmds()
  vcmd([[command! PkgInstall packadd packer.nvim | lua require('plugin.pkgs').install()]])
  vcmd([[command! PkgUpd packadd packer.nvim | lua require('plugin.pkgs').update()]])
  vcmd([[command! PkgSync packadd packer.nvim | lua require('plugin.pkgs').sync()]])
  vcmd([[command! PkgClean packadd packer.nvim | lua require('plugin.pkgs').clean()]])
  vcmd(
    [[command! PkgCompile packadd packer.nvim | lua require('plugin.pkgs').compile("~/.config/nvim/plugin/packer_load.vim")]])
end

return M
