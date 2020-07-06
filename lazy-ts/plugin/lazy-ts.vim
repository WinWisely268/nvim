" This is a hack for lazily loading nvim-treesitter with vim-plug.

call plug#load('nvim-treesitter')
lua require('plugin/ts').setup()

command! <buffer> <Plug>(ts-init-selection) lua require'nvim-treesitter.incremental_selection'.init_selection()
command! <buffer> <Plug>(ts-node-incremental) lua require'nvim-treesitter.incremental_selection'.node_incremental()
command! <buffer> <Plug>(ts-node-decremental) lua require'nvim-treesitter.incremental_selection'.node_decremental()
command! <buffer> <Plug>(ts-scope-incremental) lua require'nvim-treesitter.incremental_selection'.scope_incremental()

command! <buffer> <Plug>(ts-goto-definition) lua require'nvim-treesitter.refactor.navigation'.goto_definition(1)
command! <buffer> <Plug>(ts-list-definitions) lua require'nvim-treesitter.refactor.navigation'.list_definitions(1)

command! <buffer> <Plug>(ts-rename) lua require'nvim-treesitter.refactor.smart_rename'.smart_rename(1)
