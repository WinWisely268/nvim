local builtin = require('telescope.builtin')

local function get_workspace_folder ()
  return vim.lsp.buf.list_workspace_folders()[1] or vim.fn.systemlist('git rev-parse --show-toplevel')[1]
end

return require('telescope').register_extension {
  setup = function()
      defaults = {
          prompt_position = "top",
          prompt_prefix = "➜ ",
          selection_strategy = "reset",
          sorting_strategy = "descending",
          layout_strategy = "horizontal",
          file_sorter = require 'telescope.sorters'.get_fuzzy_file,
          generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
          shorten_path = true,
          winblend = 0,
          width = 0.75,
          preview_cutoff = 120,
          results_height = 1,
          results_width = 0.8,
          border = {},
          color_devicons = true,
          use_less = true,
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
      }

    builtin.live_grep_workspace = function(opts)
      opts.cwd = get_workspace_folder()
      builtin.live_grep(opts)
    end

    builtin.find_files_workspace = function(opts)
      opts.cwd = get_workspace_folder()
      builtin.find_files(opts)
    end

    builtin.grep_string_workspace = function(opts)
      opts.cwd = get_workspace_folder()
      builtin.grep_string(opts)
    end

  end;
}
