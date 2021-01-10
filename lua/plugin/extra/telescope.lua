local actions = require 'telescope.actions'

require('telescope').setup {
    defaults = {
        prompt_position = "bottom",
        prompt_prefix = "➜ ",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
        mappings = {
            n = {
                ['<CR>'] = actions.goto_file_selection_edit + actions.center,
                s = actions.goto_file_selection_split,
                v = actions.goto_file_selection_vsplit,
                t = actions.goto_file_selection_tabedit,
                j = actions.move_selection_next,
                k = actions.move_selection_previous,
                u = actions.preview_scrolling_up,
                d = actions.preview_scrolling_down
            }
        }
    }
}
