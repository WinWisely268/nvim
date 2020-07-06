local util = require("util")
local color = require("colors")
local fzf = require('fzf')

local M = {}

function M.setup_plugin_autocmd()
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
		Ultisnips = {
			{'BufEnter,BufRead,BufNewFile', '*', 'silent! unmap <c-r>'},
			{'VimEnter', '*', 'au! UltiSnips_AutoTrigger'},
		},
	}
	util.create_augroups(plugin_augroups)
end

function M.setup_plugin_options()
	-- FZF
	vim.cmd('set rtp+=$XDG_CONFIG_HOME/fzf')

	-- Vimspector signs
	vim.cmd( "sign define vimspectorBP text=☛ texthl=Normal" )
	vim.cmd( "sign define vimspectorBPDisabled text=☞ texthl=Normal" )
	vim.cmd( "sign define vimspectorPC text=🔶 texthl=SpellBad" )

	-- Vim illuminate
	vim.cmd('hi illuminatedWord cterm=undercurl gui=undercurl')

	-- Suda vim
	vim.cmd( 'cnoreabbrev sudowrite w suda://%' )
	vim.cmd( 'cnoreabbrev sw w suda://%' )

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
		-- Bullets
		bullets_enabled_file_types        = {
			'markdown', 'text', 'gitcommit', 'scratch',
		},
		-- Calendar
		calendar_google_calendar          = 1,
		calendar_google_task              = 1,
		-- Editorconfig
		EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'},
		-- Fastfold
		fastfold_savehook                 = 1,
		fastfold_fold_command_suffixes    = {'x','X','a','A','o','O','c','C'},
		fastfold_fold_movement_commands   = {']z', '[z', 'ze', 'zu'},
		markdown_folding                  = 1,
		tex_fold_enabled                  = 1,
		vimsyn_folding                    = 'af',
		xml_syntax_folding                = 1,
		javaScript_fold                   = 1,
		sh_fold_enabled                   = 7,
		ruby_fold                         = 1,
		perl_fold                         = 1,
		perl_fold_blocks                  = 1,
		r_syntax_folding                  = 1,
		rust_fold                         = 1,
		php_folding                       = 1,
		-- FZF
		fzf_preview_window                = 'right:60%',
		fzf_commits_log_options           = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"',
		fzf_layout                        = { window = { width = 0.9, height = 0.7 } },
		-- MarkdownPreview (mkdp)
		mkdp_auto_start                   = 0,
		mkdp_auto_close                   = 1,
		mkdp_refresh_slow                 = 0,
		mkdp_command_for_global           = 0,
		mkdp_open_to_the_world            = 0,
		mkdp_open_ip                      = '',
		mkdp_echo_preview_url             = 0,
		mkdp_browserfunc                  = '',
		mkdp_markdown_css                 = '',
		mkdp_highlight_css                = '',
		mkdp_port                         = '',
		mkdp_page_title                   = '「${name}」',
		mkdp_preview_options              = {
			mkit                            = {},
			katex                           = {},
			uml                             = {},
			maid                            = {},
			disable_sync_scroll             = 0,
			sync_scroll_type                = 'middle',
			hide_yaml_meta                  = 1,
		},
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
		UltiSnipsExpandTrigger            = "<c-e>",
		UltiSnipsJumpForwardTrigger       = "<c-e>",
		UltiSnipsJumpBackwardTrigger      = "<c-n>",
		UltiSnipsSnippetDirectories       = {
			vim.loop.os_homedir()..'/.config/nvim/Ultisnips/',
			vim.loop.os_homedir()..'/.config/nvim/plugged/vim-snippets/UltiSnips/'
		},
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
		-- vim-illuminate
		Illuminate_delay                  = 750,
		-- vim-markdown-toc
		vmt_cycle_list_item_markers       = 1,
		vmt_fence_text                    = 'TOC',
		vmt_fence_closing_text            = '/TOC',
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
		-- vim-table-mode
		table_mode_cell_text_object_i_map = 'k<Bar>',
		-- Vimspector
		vimspector_enable_mappings        = 'HUMAN',
		-- vimtex
		vimtex_view_general_viewer        = 'llpp',
		vimtex_mappings_enabled           = 0,
		vimtex_text_obj_enabled           = 0,
		vimtex_motion_enabled             = 0,
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

function M.setup_plugin_mappings()
	local plugin_mappings = {
		-- Autoformat
		[ 'n\\f' ]         = {':Autoformat<CR>'},
		-- async git push
		[ "ngp" ]          = { ":lua require('tool').async_git_push(false)<CR>" },
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
		-- Ultisnips
		[ 'i<c-n>' ]       = {"<nop>"},
		-- Vim EasyAlign
		["nsga"]           = { "<Plug>(EasyAlign)", { noremap = false, silent = false } },
		["xsga"]           = { "<Plug>(EasyAlign)", { noremap = false, silent = false } },
		-- vim-table
		[ "n<LEADER>tm" ]  = { ":TableModeToggle<CR>", { noremap = true, silent = false }	},
		[ "x<LEADER>tm" ]  = { ":TableModeToggle<CR>", { noremap = true, silent = false }	},
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
	vim.cmd("highlight Sneak guifg="..color.black.." guibg="..color.yellow.." ctermfg=black ctermbg=yellow")
	vim.cmd("highlight SneakScope guifg="..color.black.." guibg="..color.yellow.." ctermfg=black ctermbg=red")
	vim.cmd("highlight SneakLabel guifg="..color.black.." guibg="..color.yellow.." ctermfg=black ctermbg=yellow gui=bold")
end

return M
