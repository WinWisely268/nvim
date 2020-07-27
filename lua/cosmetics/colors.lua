local selected_color = require('cosmetics.colors.tomorrow-night')
local M = {}

function M.setup()
  vim.o.background = 'dark'
  vim.api.nvim_command('highlight clear')
  vim.api.nvim_command('syntax reset')
  vim.wo.number = true
  vim.wo.relativenumber = true
  vim.o.termguicolors = true
  vim.g.colors_name = 'none'
  selected_color.basic_scheme()
  selected_color.setup_terminal()
  selected_color.setup_misc()
  selected_color.setup_langbase()
  selected_color.setup_markdown()
  selected_color.setup_plugin_colors()
  vim.schedule(function()
    vim.api.nvim_command(
      [[command! ResetColors lua require('cosmetics.colors').setup()]])
  end)
end

return M
