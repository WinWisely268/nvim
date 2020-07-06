local vcmd = vim.cmd
local vfn = vim.fn
local util = require('lib.util')
local color = require('colors')

local config_path = vfn.stdpath('config')
local helpers = require('lib.nvim_helpers')

local plugins = {

  {repo = 'arcticicestudio/nord-vim'};
  {repo = 'junegunn/fzf.vim';};
  {repo = 'tjdevries/luvjob.nvim' };
  {repo = 'tjdevries/plenary.nvim' };
  {repo = 'justinmk/vim-sneak'; opts = {on = {'<Plug>Sneak_s'; '<Plug>Sneak_;'; '<Plug>Sneak_,'}}};
  {repo = 'liuchengxu/vista.vim'; opts = {on = {'Vista!!'}}};
  {repo = 'neovim/nvim-lsp'; opts = {as = 'nvim-lsp'}; eager = true};
  {repo = 'nvim-lua/completion-nvim'};
  {repo = 'nvim-treesitter/nvim-treesitter'; opts = {as = 'nvim-treesitter'; on = 'TSManual'}};
  {
    repo = config_path .. '/lazy-ts';
    opts = {
      as = 'lazy-ts';
      on = {
        '<Plug>(ts-init-selection)'; '<Plug>(ts-node-incremental)'; '<Plug>(ts-node-decremental)';
        '<Plug>(ts-scope-incremental)'; '<Plug>(ts-goto-definition)';
        '<Plug>(ts-list-definitions)'; '<Plug>(ts-rename)';
      };
    };
  };
  {repo = 'sheerun/vim-polyglot'};
  {repo = 'steelsojka/completion-buffers'};
  {repo = 'lambdalisue/gina.vim'};
  {repo = 'mhinz/vim-signify'};
  {
    repo = 'tpope/vim-surround';
    opts = {
      on = {
        '<Plug>Dsurround'; '<Plug>Csurround'; '<Plug>CSurround'; '<Plug>Ysurround';
        '<Plug>YSurround'; '<Plug>Yssurround'; '<Plug>YSsurround'; '<Plug>VSurround';
        '<Plug>VgSurround';
      };
    };
  };
  {repo = 'kyazdani42/nvim-tree.lua', opts = { on = 'LuaTreeToggle' }};
  {repo = 'kyazdani42/nvim-web-devicons', opts = { on = 'LuaTreeToggle' }};
  {repo = 'junegunn/vim-after-object'};
  {repo = 'junegunn/vim-easy-align'};
  {repo = 'lambdalisue/suda.vim'};
  {repo = 'mbbill/undotree', opts = { on = 'UndotreeToggle' }};
  {repo = 'airblade/vim-rooter'};
  {repo = 'itchyny/calendar.vim'};
}

local ts_mappings = function()
  local plugin_ts = require('plugin.ts')
  plugin_ts.set_mappings()

  vcmd([[augroup ts_mappings]])
  vcmd([[autocmd!]])
  vcmd(string.format([[autocmd FileType %s lua require('plugin.ts').set_mappings()]],
                     table.concat(vim.tbl_flatten(plugin_ts.fts), ',')))
  vcmd([[augroup END]])
end

-- manually setup some mappings so lazy loading can work.
local manual_mappings = function()
  local vim_commentary = {lhs = 'gc'; rhs = '<Plug>Commentary'}
  local mappings = {
    n = {
      vim_commentary; {lhs = 'gcc'; rhs = '<Plug>CommentaryLine'};
      {lhs = 'gS'; rhs = '<Plug>VgSurround'}; {lhs = 'ds'; rhs = '<Plug>Dsurround'};
      {lhs = 'cs'; rhs = '<Plug>Csurround'}; {lhs = 'cS'; rhs = '<Plug>CSurround'};
      {lhs = 'ys'; rhs = '<Plug>Ysurround'}; {lhs = 'yS'; rhs = '<Plug>YSurround'};
      {lhs = 'yss'; rhs = '<Plug>Yssurround'}; {lhs = 'ySs'; rhs = '<Plug>YSsurround'};
      {lhs = '\''; rhs = '<Plug>Sneak_s'}; {lhs = '\"'; rhs = '<Plug>Sneak_s'};
    };
    x = {
      vim_commentary; {lhs = 'S'; rhs = '<Plug>VSurround'}; {lhs = 'gS'; rhs = '<Plug>VgSurround'};
    };
  }
  helpers.create_mappings(mappings)
end

-- plugin_autocmd
local setup_plugin_cmd = function()
	local plugin_augroups = {
		VimCalendar = {
			{ 'FileType', 'calendar', 'nmap <buffer> e <Plug>(calendar_up)'                },
			{ 'FileType', 'calendar', 'nmap <buffer> h <Plug>(calendar_left)'              },
			{ 'FileType', 'calendar', 'nmap <buffer> n <Plug>(calendar_down)'              },
			{ 'FileType', 'calendar', 'nmap <buffer> i <Plug>(calendar_right)'             },
			{ "FileType", "calendar",  'nmap <buffer> <c-e> <Plug>(calendar_move_up)'       },
			{ "FileType", "calendar",  'nmap <buffer> <c-h> <Plug>(calendar_move_left)'     },
			{ "FileType", "calendar",  'nmap <buffer> <c-n> <Plug>(calendar_move_down)'     },
			{ "FileType", "calendar",  'nmap <buffer> <c-i> <Plug>(calendar_move_right)'    },
			{ "FileType", "calendar",  'nmap <buffer> k <Plug>(calendar_start_insert)'      },
			{ "FileType", "calendar",  'nmap <buffer> K <Plug>(calendar_start_insert_head)' },
			{ "FileType", "calendar",  'nunmap <buffer> <C-n>' },
			{ "FileType", "calendar",  'nunmap <buffer> <C-p>' },
		},
	}
	util.create_augroups(plugin_augroups)
end

-- plugin_options
local setup_plugin_options = function()
	vcmd('set rtp+=$XDG_CONFIG_HOME/fzf')

	-- Vimspector signs
	vcmd( "sign define vimspectorBP text=☛ texthl=Normal" )
	vcmd( "sign define vimspectorBPDisabled text=☞ texthl=Normal" )
	vcmd( "sign define vimspectorPC text=🔶 texthl=SpellBad" )

	-- Suda vim
	vcmd( 'cnoreabbrev sudowrite w suda://%' )
	vcmd( 'cnoreabbrev sw w suda://%' )

	local plugin_options = {
		-- Bookmarks
		bookmark_no_default_key_mappings  = 1,
		bookmark_auto_save                = 1,
		bookmark_highlight_lines          = 1,
		bookmark_manage_per_buffer        = 1,
		bookmark_save_per_working_dir     = 1,
		bookmark_center                   = 1,
		bookmark_auto_close               = 1,
		bookmark_location_list            = 1,
		-- Calendar
		calendar_google_calendar          = 1,
		calendar_google_task              = 1,
		-- FZF
		fzf_preview_window                = 'right:60%',
		fzf_commits_log_options           = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"',
		fzf_layout                        = { window = { width = 0.9, height = 0.7 } },
		-- nvim-tree.lua
		lua_tree_size                     = 40,
		lua_tree_ignore                   = { '.git', 'node_modules', '.cache' },
		lua_tree_auto_open                = 0,
		lua_tree_auto_close               = 1,
		lua_tree_follow                   = 0,
		lua_tree_indent_markers           = 1,
		lua_tree_show_icons               = {
			git                             = 1,
			folders                         = 1,
			files                           = 1,
		},
		lua_tree_bindings                 = {
			edit                            = '<CR>',
			edit_vsplit                     = '<C-v>',
			edit_split                      = '<C-h>',
			edit_tab                        = '<C-t>',
			preview                         = '<Tab>',
			cd                              = '<C-o>',
		},
		-- tcomment
		tcomment_textobject_inlinecomment = '',
		-- Ultisnips
		tex_flavor                        = "latex",
		-- Undotree
		undotree_DiffAutoOpen             = 1,
		undotree_SetFocusWhenToggle       = 1,
		undotree_ShortIndicator           = 1,
		undotree_WindowLayout             = 2,
		undotree_DiffpanelHeight          = 8,
		undotree_SplitWidth               = 28,
		-- vim-go
		go_gopls_enabled                       = 0,
		go_echo_go_info                        = 0,
		go_doc_popup_window                    = 0,
		go_template_autocreate                 = 1,
		go_textobj_enabled                     = 0,
		go_auto_type_info                      = 0,
		go_def_mapping_enabled                 = 0,
		go_highlight_array_whitespace_error    = 1,
		go_highlight_build_constraints         = 1,
		go_highlight_chan_whitespace_error     = 1,
		go_highlight_extra_types               = 1,
		go_highlight_fields                    = 1,
		go_highlight_format_strings            = 1,
		go_highlight_function_calls            = 1,
		go_highlight_function_parameters       = 1,
		go_highlight_functions                 = 1,
		go_highlight_generate_tags             = 1,
		go_highlight_methods                   = 1,
		go_highlight_operators                 = 1,
		go_highlight_space_tab_error           = 1,
		go_highlight_string_spellcheck         = 1,
		go_highlight_structs                   = 1,
		go_highlight_trailing_whitespace_error = 1,
		go_highlight_types                     = 1,
		go_highlight_variable_assignments      = 0,
		go_highlight_variable_declarations     = 0,
		go_doc_keywordprg_enabled              = 0,
		-- vim-multiple-cursors
		multi_cursor_use_default_mapping  = 0,
		multi_cursor_start_word_key       = '<c-k>',
		multi_cursor_select_all_word_key  = '<a-k>',
		multi_cursor_start_key            = 'g<c-k>',
		multi_cursor_select_all_key       = 'g<a-k>',
		multi_cursor_next_key             = '<c-k>',
		multi_cursor_prev_key             = '<c-p>',
		multi_cursor_skip_key             = '<C-s>',
		multi_cursor_quit_key             = '<Esc>',
		-- vim-rooter
		rooter_patterns                   = {'__vim_project_root', '.git/'},
		-- vim-sneak
		[ 'sneak#label' ]                 = 1,
		-- vim-signify
		signify_sign_add                  = '▋',
		signify_sign_delete               = '▋',
		signify_sign_delete_first_line    = '▋',
		signify_sign_change               = '▋',
		-- Vista.vim
		vista_icon_indent                 = {"╰─▸ ", "├─▸ "},
		vista_default_executive           = 'nvim_lsp',
		vista_fzf_preview                 = {'right:50%'},
		[ 'vista#renderer#enable_icon' ]  = 1,
	}

	for k, v in pairs(plugin_options) do
		vim.g[k] = v
	end

end

local setup_plugin_mappings = function()
	local plugin_mappings = {
		-- bookmarks
		[ 'nmt' ]          = { '<Plug>BookmarkToggle', { noremap = false, silent = false } },
		[ 'nma' ]          = { '<Plug>BookmarkAnnotate', { noremap = false, silent = false } },
		[ 'nml' ]          = { '<Plug>BookmarkShowAll', { noremap = false, silent = false } },
		[ 'nmi' ]          = { '<Plug>BookmarkNext' , { noremap = false, silent = false } },
		[ 'nmh' ]          = { '<Plug>BookmarkPrev', { noremap = false, silent = false } },
		[ 'nmC' ]          = { '<Plug>BookmarkClear' , { noremap = false, silent = false } },
		[ 'nmX' ]          = { '<Plug>BookmarkClearAll', { noremap = false, silent = false } },
		[ 'nme' ]          = { '<Plug>BookmarkMoveUp', { noremap = false, silent = false } },
		[ 'nmn' ]          = { '<Plug>BookmarkMoveDown', { noremap = false, silent = false } },
		[ 'n<Leader>g' ]   = { '<Plug>BookmarkMoveToLine', { noremap = false, silent = false } },
		-- Gina
		[ 'ngb' ]          = { ":Gina blame<CR>" },
		-- goyo.vim
		[ 'n<LEADER>gy' ]  = { ":Goyo<CR>" },
		-- nvim-tree.lua
		[ "n<LEADER>tt" ]  = { ":LuaTreeToggle<CR>", { noremap = true, silent = false } },
		[ "ntt" ]          = { ":LuaTreeToggle<CR>", { noremap = true, silent = false } },
		[ "n<LEADER>tr"  ] = { ":LuaTreeRefresh<CR>", { noremap = true, silent = false } },
		[ "n<LEADER>ff"  ] = { ":LuaTreeFindFile<CR>", { noremap = true, silent = false } },
		-- tcomment
		['nci']            = { "cl", { noremap = true, silent = false } },
		['vci']            = { "cl", { noremap = true, silent = false } },
		['oci']            = { "cl", { noremap = true, silent = false } },
		[ 'n<LEADER>cn' ]  = { "g>c", { noremap = false, silent = false } },
		[ 'v<LEADER>cn' ]  = { "g>", { noremap = false, silent = false }  },
		[ 'n<LEADER>cu' ]  = { "g<c", { noremap = false, silent = false }  },
		[ 'v<LEADER>cu' ]  = { "g<", { noremap = false, silent = false }  },
		-- Vim EasyAlign
		["nsga"]           = { "<Plug>(EasyAlign)", { noremap = false, silent = false } },
		["xsga"]           = { "<Plug>(EasyAlign)", { noremap = false, silent = false } },
	}

	util.bind_key(plugin_mappings)

	local plugin_noremap_mappings = {
		-- Calendar
		[ '\\\\' ]      = {':Calendar -position=here<CR>'},
		-- FZF
		[ '<C-p>' ]     = { ':Files<CR>' },
		[ '<C-f>' ]     = { ':Rg<CR>' },
		[ '<C-h>' ]     = { ':History<CR>' },
		[ ',h' ]        = { ':Help<CR>' },
		[ ',<C-l>' ]    = { ':Lines<CR>' },
		[ '<C-w>' ]     = { ':Buffers<CR>' },
		[ '<leader>;' ] = { ':History:<CR>' },
		[ '<C-d>' ]     = { ':BD<CR>' },
		-- Undotree
		['U']           = { ":UndotreeToggle<CR>" },
		-- Vim Sneak
		["'"]           = { "<Plug>Sneak_s", { noremap = false, silent = false } },
		["\""]          = { "<Plug>Sneak_S", { noremap = false, silent = false } },
		["f"]           = { "<Plug>Sneak_f", { noremap = false, silent = false } },
		["F"]           = { "<Plug>Sneak_F", { noremap = false, silent = false } },
		-- Vista.vim
		[ '<c-t>' ]     = { ':Vista finder<CR>' },
	}

	util.noremap_key(plugin_noremap_mappings)

	-- Vim sneak colors
	vcmd("highlight Sneak guifg="..color.black.." guibg="..color.yellow.." ctermfg=black ctermbg=yellow")
	vcmd("highlight SneakScope guifg="..color.black.." guibg="..color.yellow.." ctermfg=black ctermbg=red")
	vcmd("highlight SneakLabel guifg="..color.black.." guibg="..color.yellow.." ctermfg=black ctermbg=yellow gui=bold")

end


do
  local path = vfn.stdpath('cache') .. '/vim-plug'
  local empty_dict = vim.empty_dict()

  vfn['plug#begin'](path)
  local plug = vfn['plug#']
  local load = vfn['plug#load']
  for _, plugin in pairs(plugins) do
    plug(plugin.repo, plugin.opts or empty_dict)
    if plugin.eager and plugin.opts and plugin.opts.as then
      load(plugin.opts.as)
    end
  end
  vfn['plug#end']()

  vim.schedule(function()
    manual_mappings()
    ts_mappings()
    setup_plugin_cmd()
    setup_plugin_options()
    setup_plugin_mappings()
    vcmd([[doautocmd User PluginReady]])
  end)
end
