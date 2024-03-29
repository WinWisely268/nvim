--
-- Provides bindings and options 
-- for plugins
--
local bind = require('lib.bind')
local au = require('lib.au')
local as = require('lib.async')

local function setup_plugin_autocmd()
  local plugin_augroups = {
    VimGo = {
      {'FileType', 'go', 'nmap <buffer> <LEADER>mdb :GoDebugBreakpoint'},
      {'FileType', 'go', 'nmap <buffer> <LEADER>mta :GoTest'},
      {'FileType', 'go', 'nmap <buffer> <LEADER>mtf :GoTestFunc'}
    },
    ChdirAu = {
      {
        'VimEnter,BufReadPost,BufEnter', '*',
        [[:lua require('lspc.util').auto_cd()]]
      }
    },
    FmtWrite = {
      {
        'BufWritePost',
        '*.js,*.rs,*.yaml,*.yml,*.ts,*.tsx,*.jsx,*.md,*.json,*.sh,*.lua',
        [[FormatWrite]]
      }
    }
  }
  au.create_augroups(plugin_augroups)
end

local function setup_plugin_options()
  -- other plugin options
  local plugin_options = {
    -- neoformat
    -- neoformat_lua_luaformatter = {exe = 'lua-format'},
    -- neoformat_rust_rustfmt = {exe = 'rustfmt', args = {'--edition', '2018'}},
    -- Pear tree
    -- pear_tree_map_special_keys = 0,
    -- vim-go
    go_test_timeout = 30,
    go_gopls_enabled = 0,
    go_echo_go_info = 0,
    go_doc_popup_window = 0,
    go_template_autocreate = 1,
    go_textobj_enabled = 0,
    go_auto_type_info = 0,
    go_def_mapping_enabled = 0,
    go_highlight_array_whitespace_error = 0,
    go_highlight_build_constraints = 0,
    go_highlight_chan_whitespace_error = 0,
    go_highlight_extra_types = 0,
    go_highlight_fields = 0,
    go_highlight_format_strings = 0,
    go_highlight_function_calls = 0,
    go_highlight_function_parameters = 0,
    go_highlight_functions = 0,
    go_highlight_generate_tags = 0,
    go_highlight_interfaces = 0,
    go_highlight_methods = 0,
    go_highlight_operators = 0,
    go_highlight_space_tab_error = 0,
    go_highlight_string_spellcheck = 0,
    go_highlight_structs = 0,
    go_highlight_trailing_whitespace_error = 0,
    go_highlight_types = 0,
    go_highlight_variable_assignments = 0,
    go_highlight_variable_declarations = 0,
    go_doc_keywordprg_enabled = 0,
    go_debug_breakpoint_sign_text = 'ᐈ',
    -- vim-markdown-toc
    vmt_cycle_list_item_markers = 1,
    vmt_fence_text = 'TOC',
    vmt_fence_closing_text = '/TOC',
    -- vim-sneak
    -- ['sneak#label'] = 1,
    -- vim-signify
    -- signify_sign_add = '▋';
    -- signify_sign_delete = '▋';
    -- signify_sign_delete_first_line = '▋';
    -- signify_sign_change = '▋';
    -- vim-table-mode
    table_mode_cell_text_object_i_map = 'k<Bar>',
    -- vimtex
    vimtex_view_general_viewer = 'mupdf',
    vimtex_mappings_enabled = 0,
    vimtex_text_obj_enabled = 0,
    vimtex_motion_enabled = 0,
    -- Vista.vim
    -- vista_icon_indent = {'╰─▸ '; '├─▸ '};
    -- vista_default_executive = 'nvim_lsp';
    -- vista_fzf_preview = {'right:70%'};
    -- ['vista#renderer#enable_icon'] = 1;
    -- wiki root
    wiki_root = '~/Notes/',
    wiki_filetypes = {'md'},
    wiki_link_target_type = 'md',
    wiki_link_extension = 'md'
  }

  for k, v in pairs(plugin_options) do vim.g[k] = v end
end

local function setup_plugin_mappings()
  local xmappings = {
    -- ['gS'] = '<Plug>VgSurround',
    -- ['S'] = '<Plug>VSurround',
    ['sga'] = '<Plug>(EasyAlign)',
    ['f'] = ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<CR>",
    ['F'] = ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<CR>"

  }

  for k, v in pairs(xmappings) do
    bind.map.x(k, v, {
      noremap = false,
      silent = true
    })
  end

  local imappings = {
    -- Pear-tree
    -- ['<c-b>'] = '<Plug>(PearTreeBackspace)',
    -- ['<c-<CR>>'] = '<Plug>(PearTree)',
    -- ['<c-j>'] = '<Plug>(PearTreeBackspace)'
  }
  for k, v in pairs(imappings) do
    bind.map.i(k, v, {
      noremap = false,
      silent = true
    })
  end

  local nmappings = {
    -- async git push
    ['<LEADER>gp'] = ':lua require(\'lib.tool\').async_git_push(true)<CR>',
    -- Git Messenger
    ['<LEADER>gm'] = ':GitMessenger<CR>',
    -- goyo.vim
    ['<LEADER>mgy'] = ':Goyo<CR>',
    -- -- surround
    -- ['gS'] = '<Plug>VgSurround',
    -- ['ds'] = '<Plug>Dsurround',
    -- ['cs'] = '<Plug>Csurround',
    -- ['cS'] = '<Plug>CSurround',
    -- ['ys'] = '<Plug>Ysurround',
    -- ['yS'] = '<Plug>YSurround',
    -- ['yss'] = '<Plug>Yssurround',
    -- ['ysS'] = '<Plug>YsSurround',
    -- Vim EasyAlign
    ['sga'] = '<Plug>(EasyAlign)',
    -- vim-table
    ['<LEADER>tm'] = ':TableModeToggle<CR>',
    -- wiki.vim
    [',ww'] = '<plug>(wiki-index)',
    [',wo'] = '<plug>(wiki-open)',
    [',wj'] = '<plug>(wiki-journal)',
    [',wr'] = '<plug>(wiki-reload)',
    [',wR'] = '<plug>(wiki-rename)',
    [',wc'] = '<plug>(wiki-code-run)',
    [',wb'] = '<plug>(wiki-graph-find-backlinks)',
    [',wg'] = '<plug>(wiki-graph-in)',
    [',wG'] = '<plug>(wiki-graph-out)',
    [',wd'] = '<plug>(wiki-page-delete)',
    [',wt'] = '<plug>(wiki-page-toc)',
    -- sessions
    ['<LEADER>ss'] = ':SessSave',
    -- ['<LEADER>sl'] = [[:lua require('plugin.extra.fzf').load_sessions()<CR>]];
    -- Telescope
    ['<LEADER>ot'] = [[:lua require('telescope.builtin').find_files({previewer = false})<CR>]],
    -- ['<LEADER>ff'] = ':Files<CR>';
    ['<LEADER>ff'] = ':Telescope find_files_workspace<CR>',
    -- Grep with ripgrep
    ['<LEADER>fg'] = ':Telescope live_grep_workspace<CR>',
    ['<LEADER>f/'] = ':Telescope find_files_workspace<CR>',
    ['<LEADER>fh'] = ':Telescope help_tags<CR>',
    ['<LEADER>fl'] = ':Telescope current_buffer_fuzzy_find<CR>',
    ['<LEADER>fb'] = [[:lua require('telescope.builtin').buffers({show_all_buffers = true})<CR>]],
    ['<leader>f:'] = ':Telescope commands<CR>',
    -- Project wide tags
    ['<LEADER>fp'] = [[:lua require'telescope'.extensions.project.project{}<CR>]],
    ['<LEADER>fgc'] = ':Telescope commits<CR>',
    ['<LEADER>fgb'] = ':Telescope git_branch<CR>',
    -- Current buffer tags
    ['<leader>ft'] = ':Telescope treesitter<CR>',
    ['<LEADER>fjl'] = ':Telescope loclist<CR>',
    ['<LEADER>fjq'] = ':Telescope quickfix<CR>',
    -- Formatter.nvim
    [',g='] = ':FormatWrite<CR>',
    -- Trouble.nvim
    ['<leader>xx'] = ':TroubleToggle<CR>',
    ['<leader>xw'] = ':TroubleToggle lsp_workspace_diagnostics<CR>',
    ['<leader>xd'] = ':TroubleToggle lsp_document_diagnostics<CR>',
    ['<leader>xl'] = ':TroubleToggle loclist<CR>',
    -- Suda
    ['<LEADER>sw'] = ':w suda://%',
    -- Mundo
    ['U'] = ':MundoToggle<CR>',
    -- fzf others
    -- ['<LEADER>fk'] = [[:lua require('plugin.extra.fzf').kill_buffers()<CR>]];
    -- Hop.nvim
    ['s'] = ":lua require'hop'.hint_char2({current_line_only = false})<CR>",
    ['f'] = ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<CR>",
    ['F'] = ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<CR>"
  }

  for k, v in pairs(nmappings) do
    bind.map.n(k, v, {
      noremap = false,
      silent = true
    })
  end
end

as.async(function()
  require('plugin.extra.telescope')
  require'telescope'.load_extension 'project'
  require'telescope'.load_extension 'fzy_native'
  require'telescope'.load_extension 'builtin_extras'
  require('plugin.extra.wiki')
  require('plugin.extra.gitsigns')
  require('plugin.extra.formatter')
  setup_plugin_options()
  setup_plugin_mappings()
  setup_plugin_autocmd()
  local lua_ft = require('plugin.langs.lua.init')
  lua_ft.setup_lua_autocmd()
  require('lib.sessions').save()
end)()
