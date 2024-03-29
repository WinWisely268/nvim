local actions = require 'telescope.actions'
local trouble = require('trouble.providers.telescope')

require('telescope').setup {
  defaults = {
    prompt_prefix = "➜ ",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    color_devicons = true,
    use_less = true,
    set_env = {
      ['COLORTERM'] = 'truecolor'
    }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
    mappings = {
      i = {
        ["<c-t>"] = trouble.open_with_trouble
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble
      }
    }
  }
}

-- This will load fzy_native and have it override the default file sorter
require('telescope').load_extension('fzy_native')
