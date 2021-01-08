-------------------------------------------------------------------------------
--                                  NORD Lazy                                --
-------------------------------------------------------------------------------
local M = {}

-- NORD COLORS
M.black = '#2E3440'
M.red = '#BF616A'
M.green = '#A3BE8C'
M.yellow = '#EBCB8B'
M.blue = '#81A1C1'
M.magenta = '#B48EAD'
M.cyan = '#88C0D0'
M.lightcyan = "#8FBCBB"
M.lightgray = '#E5E9F0'
M.orange = "#D08770"
M.darkgray = '#3B4252'
M.white = '#ECEFF4'
M.fg = '#D8DEE9'
M.bg = '#2E3440'
M.bg2 = '#4C566A'
M.comment = '#616E88'

M.brightened_comments = {
  M.bg2; '#4e586d'; '#505b70'; '#525d73'; '#556076'; '#576279'; '#59647c';
  '#5b677f'; '#5d6982'; '#5f6c85'; '#616e88'; '#63718b'; '#66738e'; '#687591';
  '#6a7894'; '#6d7a96'; '#6f7d98'; '#72809a'; '#75829c'; '#78859e'; '#7b88a1';
	'#8895AE'; '#95A2BB'; '#A1AEC7';
}

-- GUI colors
local nord0_gui = M.bg
local nord1_gui = M.darkgray
local nord2_gui = '#434C5E'
local nord3_gui = M.bg2
local nord4_gui = M.fg
local nord5_gui = M.lightgray
local nord6_gui = M.white
local nord7_gui = M.lightcyan
local nord8_gui = M.cyan
local nord9_gui = M.blue
local nord10_gui = '#5E81AC'
local nord11_gui = M.red
local nord12_gui = M.orange
local nord13_gui = M.yellow
local nord14_gui = M.green
local nord15_gui = M.magenta

-- TTY
local nord1_term = '0'
local nord3_term = '8'
local nord5_term = '7'
local nord6_term = '15'
local nord7_term = '14'
local nord8_term = '6'
local nord9_term = '4'
local nord10_term = '12'
local nord11_term = '1'
local nord12_term = '11'
local nord13_term = '3'
local nord14_term = '2'
local nord15_term = '5'

local keys = {'cterm'; 'ctermbg'; 'ctermfg'; 'gui'; 'guibg'; 'guifg'}
local hi = function(group, opts)
  local cmd_args = {group}
  for _, k in pairs(keys) do
    table.insert(cmd_args, string.format(' %s=%s ', k, opts[k] or 'NONE'))
  end
  vim.api.nvim_command('highlight ' .. table.concat(cmd_args))
end

local hilink = function(group, linkname)
  vim.api.nvim_command('hi link ' .. group .. ' ' .. linkname)
end

-- basic schemes
local basic_scheme = function()
  hi('ColorColumn', {guibg = nord1_gui; ctermbg = nord1_term})
  hi('Cursor', {guifg = nord0_gui; guibg = nord4_gui})
  hi('CursorLine', {guibg = nord1_gui; ctermbg = nord1_term})
  hi('iCursor', {guifg = nord0_gui; guibg = nord4_gui})
  hi('LineNr', {guifg = M.brightened_comments[11]; ctermfg = nord3_term})
  hi('MatchParen', {
    guifg = nord8_gui;
    guibg = nord3_gui;
    ctermfg = nord8_term;
    ctermbg = nord3_term
  })
  hi('Normal', {guifg = nord4_gui; guibg = nord0_gui})
  hi('Pmenu', {guifg = nord4_gui; guibg = nord1_gui; ctermbg = nord1_term})
  hi('PmenuSbar', {guifg = nord4_gui; guibg = nord2_gui; ctermbg = nord1_term})
  hi('PmenuSel', {
    guifg = nord6_gui;
    guibg = nord2_gui;
    ctermfg = nord6_term;
    ctermbg = nord3_term
  })
  hi('PmenuThumb', {guifg = nord8_gui; guibg = nord3_gui; ctermbg = nord3_term})
  hi('SpecialKey', {guifg = nord3_gui; ctermfg = nord3_term})
  hi('SpellBad', {
    guifg = nord11_gui;
    guibg = nord0_gui;
    ctermfg = nord11_term;
    gui = 'undercurl'
  })
  hi('SpellCap', {
    guifg = nord13_gui;
    guibg = nord0_gui;
    ctermfg = nord13_term;
    gui = 'undercurl'
  })
  hi('SpellLocal', {
    guifg = nord5_gui;
    guibg = nord0_gui;
    ctermfg = nord5_term;
    gui = 'undercurl'
  })
  hi('SpellRare', {
    guifg = nord6_gui;
    guibg = nord0_gui;
    ctermfg = nord6_term;
    gui = 'undercurl'
  })
  hi('Visual', {guibg = nord2_gui; ctermbg = nord1_term})
  hi('VisualNOS', {guibg = nord2_gui; ctermbg = nord1_term})
  hi('healthError', {
    guifg = nord11_gui;
    guibg = nord1_gui;
    ctermfg = nord11_term;
    ctermbg = nord1_term
  })
  hi('healthSuccess', {
    guifg = nord14_gui;
    guibg = nord1_gui;
    ctermfg = nord14_term;
    ctermbg = nord1_term
  })
  hi('healthWarning', {
    guifg = nord13_gui;
    guibg = nord1_gui;
    ctermfg = nord13_term;
    ctermbg = nord1_term
  })
  hi('TermCursorNC', {guibg = nord1_gui; ctermbg = nord1_term})
end

-- local nohighlights = function()
--   local nohighlights = {
--     'Boolean', 'Character', 'Conceal', 'Conditional', 'Constant', 'Debug', 'Define', 'Delimiter',
--     'Exception', 'Float', 'Function', 'Identifier', 'Ignore', 'Include', 'Keyword', 'Label',
--     'Macro', 'NonText', 'Number', 'Operator', 'Question', 'Search', 'PreCondit', 'PreProc',
--     'Repeat', 'Special', 'SpecialChar', 'SpecialComment', 'Statement', 'StorageClass', 'String',
--     'Structure', 'Tag', 'Todo', 'Type', 'Typedef', 'Underlined', 'htmlBold',
--   }
--   for _, group in pairs(nohighlights) do
--     hi(group, {})
--   end
-- end

local setup_terminal = function()
  local terminal_colors = {
    terminal_color_0 = nord1_gui;
    terminal_color_1 = nord11_gui;
    terminal_color_2 = nord14_gui;
    terminal_color_3 = nord13_gui;
    terminal_color_4 = nord9_gui;
    terminal_color_5 = nord15_gui;
    terminal_color_6 = nord8_gui;
    terminal_color_7 = nord5_gui;
    terminal_color_8 = nord3_gui;
    terminal_color_9 = nord11_gui;
    terminal_color_10 = nord14_gui;
    terminal_color_11 = nord13_gui;
    terminal_color_12 = nord9_gui;
    terminal_color_13 = nord15_gui;
    terminal_color_14 = nord7_gui;
    terminal_color_15 = nord6_gui
  }
  for k, v in pairs(terminal_colors) do vim.g[k] = v end
end

local setup_misc = function()
  hi('CursorColumn', {guibg = nord1_gui; ctermbg = nord1_term})
  hi('CursorLineNr',
     {guifg = nord7_gui; guibg = nord1_gui; ctermfg = nord7_term; ctermbg = nord1_term})
  hi('Folded', {
    guifg = M.brightened_comments[21];
    guibg = nord1_gui;
    ctermfg = nord5_term;
    ctermbg = nord1_term;
    gui = 'bold'
  })
  hi('FoldColumn', {guifg = nord3_gui; guibg = nord0_gui; ctermfg = nord3_term})
  hi('SignColumn', {guifg = nord1_gui; guibg = nord0_gui; ctermfg = nord1_term})
  hi('Directory', {guifg = nord8_gui; ctermfg = nord8_term})
  hi('EndOfBuffer', {guifg = nord1_gui; ctermfg = nord1_term})
  hi('Error', {})
  hi('ErrorMsg', {guifg = nord4_gui; guibg = nord11_gui; ctermbg = nord11_term})
  hi('ModeMsg', {guifg = nord4_gui})
  hi('MoreMsg', {guifg = nord8_gui; ctermfg = nord8_term})
  hi('Question', {guifg = nord4_gui})
  hi('StatusLine', {guifg = nord8_gui; ctermfg = nord8_term})
  hi('StatusLineNC', {guifg = nord4_gui})
  hi('StatusLineTerm',
     {guifg = nord8_gui; ctermfg = nord8_term; ctermbg = nord3_term})
  hi('StatusLineTermNC', {guifg = nord4_gui; ctermbg = nord3_term})
  hi('WarningMsg', {
    guifg = nord0_gui;
    guibg = nord13_gui;
    ctermfg = nord1_term;
    ctermbg = nord13_term
  })
  hi('WildMenu', {
    guifg = nord8_gui;
    guibg = nord1_gui;
    ctermfg = nord8_term;
    ctermbg = nord1_term
  })
  hi('IncSearch', {
    guifg = nord6_gui;
    guibg = nord10_gui;
    ctermfg = nord6_term;
    ctermbg = nord10_term;
    gui = 'underline'
  })
  hi('Search', {
    guifg = nord1_gui;
    guibg = nord8_gui;
    ctermfg = nord1_term;
    ctermbg = nord8_term
  })
  hi('TabLine', {guifg = nord4_gui; guibg = nord1_gui; ctermbg = nord1_term})
  hi('TabLineFill', {guifg = nord4_gui; guibg = nord1_gui; ctermbg = nord1_term})
  hi('TabLineSel', {
    guifg = nord1_gui;
    guibg = nord8_gui;
    ctermfg = nord1_term;
    ctermbg = nord8_term;
    gui = 'bold'
  })
  hi('TabLineSelSeparator', {gui = 'bold'; guifg = nord8_gui})
  hi('TabLineSeparator', {gui = 'bold'; guifg = nord1_gui})
  hi('Title', {guifg = nord4_gui})
  hi('VertSplit', {
    guifg = nord2_gui;
    guibg = nord1_gui;
    ctermfg = nord3_term;
    ctermbg = nord1_term
  })
  hi('DiffAdd', {
    guifg = nord14_gui;
    guibg = nord1_gui;
    ctermfg = nord14_term;
    ctermbg = nord1_term
  })
  hi('DiffChange', {
    guifg = nord13_gui;
    guibg = nord1_gui;
    ctermfg = nord13_term;
    ctermbg = nord1_term
  })
  hi('DiffDelete', {
    guifg = nord11_gui;
    guibg = nord1_gui;
    ctermfg = nord11_term;
    ctermbg = nord1_term
  })
  hi('DiffText', {
    guifg = nord9_gui;
    guibg = nord1_gui;
    ctermfg = nord9_term;
    ctermbg = nord1_term
  })
end

-- local setup_hl_treesitter = function()
--   hi('TSConditional', {guifg = nord9_gui, ctermfg = nord9_term})
--   hi('TSPunctDelimiter', {guifg = nord6_gui, ctermfg = nord6_term})
--   hi('TSException', {guifg = nord9_gui, ctermfg = nord9_term})
--   hi('TSFunction', {guifg = nord8_gui, ctermfg = nord8_term})
--   hi('TSKeyword', {guifg = nord9_gui, ctermfg = nord9_term})
--   hi('TSLabel', {guifg = nord9_gui, ctermfg = nord9_term})
--   hi('TSOperator', {guifg = nord9_gui, ctermfg = nord9_term})
--   hi('TSIdentifier', {guifg = nord4_gui, ctermfg = 'NONE'})
--   hi('TSRepeat', {guifg = nord9_gui, ctermfg = nord9_term})
--   hi('TSConstant', {guifg = nord4_gui, ctermfg = 'NONE'})
--   hi('TSConstBuiltin', {guifg = nord4_gui, ctermfg = 'NONE'})
--   hi('TSConstMacro', {guifg = nord9_gui, ctermfg = nord9_term})
--   hi('TSString', {guifg = nord14_gui, ctermfg = nord14_term})
--   hi('TSStringRegex', {guifg = nord13_gui, ctermfg = nord14_term})
--   hi('TSStringEscape', {guifg = nord13_gui, ctermfg = nord14_term})
--   hi('TSNumber', {guifg = nord15_gui, ctermfg = nord15_term})
--   hi('TSBoolean', {guifg = nord9_gui, ctermfg = nord9_term})
--   hi('TSCharacter', {guifg = nord14_gui, ctermfg = nord14_term})
--   hi('TSFloat', {guifg = nord15_gui, ctermfg = nord15_term})
--   hi('Comment', {guifg = M.brightened_comments[19], ctermfg = nord3_term, gui = 'italic'})
--   hi('TSStructure', {guifg = nord9_gui, ctermfg = nord9_term})
--   hi('TSType', {guifg = nord9_gui, ctermfg = nord9_term})
--   hi('TSTypeBuiltin', {guifg = nord7_gui, ctermfg = nord7_term})
--   hi('TSInclude', {guifg = nord9_gui, ctermfg = nord9_term})
--   -- others
--   hilink('TSPunctBracket', 'TSPunctDelimiter')
--   hilink('TSPunctSpecial', 'TSPunctDelimiter')
--   hilink('TSFuncBuiltin', 'TSTypeBuiltin')
--   hilink('TSFuncMacro', 'TSFunction')
--   hilink('TSMethod', 'TSIdentifier')
--   hilink('TSProperty', 'TSIdentifier')
--   hilink('TSField', 'Normal')
--   hilink('TSConstructor', 'TSIdentifier')
--   hilink('TSError', 'Normal')
-- end

local setup_langbase = function()

  hi('Boolean', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('Character', {guifg = nord14_gui; ctermfg = nord14_term})
  hi('Comment',
     {guifg = M.brightened_comments[23]; ctermfg = nord3_term; gui = 'italic'})
  hi('Conditional', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('Constant', {guifg = nord4_gui; gui = 'bold'})
  hi('Define', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('Delimiter', {guifg = nord6_gui; ctermfg = nord6_term})
  hi('Exception', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('Float', {guifg = nord15_gui; ctermfg = nord15_term})
  hi('Function', {guifg = nord8_gui; ctermfg = nord8_term})
  hi('Identifier', {guifg = nord5_gui; ctermfg = nord5_term; gui = 'italic'})
  hi('Include', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('Keyword', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('Label', {guifg = nord13_gui; ctermfg = nord13_term})
  hi('Number', {guifg = nord15_gui; ctermfg = nord15_term})
  hi('Operator', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('PreProc', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('Repeat', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('Special', {guifg = nord4_gui})
  hi('SpecialChar', {guifg = nord14_gui; ctermfg = nord13_term})
  hi('SpecialComment', {guifg = nord8_gui; ctermfg = nord8_term; gui = 'italic'})
  hi('Statement', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('StorageClass', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('String', {guifg = nord14_gui; ctermfg = nord14_term})
  hi('Structure', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('Tag', {guifg = nord4_gui})
  hi('Todo', {guifg = nord12_gui; ctermfg = nord13_term})
  hi('Type', {guifg = nord7_gui; ctermfg = nord7_term })
  hi('Typedef', {guifg = nord9_gui; ctermfg = nord9_term})
  hi('NonText', {guifg = nord3_gui; ctermfg = nord3_term})

  hilink('Macro', 'Define')
  hilink('PreCondit', 'PreProc')
  -- others
  -- hilink('TSPunctBracket', 'Delimiter')
  -- hilink('TSPunctSpecial', 'Delimiter')
  -- hilink('TSFuncBuiltin', 'Special')
  -- hilink('TSFuncMacro', 'Macro')
  hilink('TSMethod', 'Function')
  -- hilink('TSProperty', 'Identifier')
  -- hilink('TSField', 'Identifier')
  -- hilink('TSConstructor', 'Type')
end

local setup_markdown = function()
  hi('markdownBold', {gui = 'bold'})
  hi('markdownItalic', {gui = 'italic'})
  hi('markdownBlockquote', {guifg = nord7_gui; ctermfg = nord7_term})
  hi('markdownCode', {guifg = nord7_gui; ctermfg = nord7_term})
  hi('markdownCodeDelimiter', {guifg = nord7_gui; ctermfg = nord7_term})
  hi('markdownFootnote', {guifg = nord7_gui; ctermfg = nord7_term})
  hi('markdownId', {guifg = nord7_gui; ctermfg = nord7_term})
  hi('markdownIdDeclaration', {guifg = nord7_gui; ctermfg = nord7_term})
  hi('markdownH1', {guifg = nord8_gui; ctermfg = nord8_term})
  hi('markdownLinkText', {guifg = nord8_gui; ctermfg = nord8_term})
  hi('markdownUrl', {guifg = nord4_gui; ctermfg = 'NONE'})

  hilink('markdownBoldDelimiter', 'TSKeyword')
  hilink('markdownFootnoteDefinition', 'markdownFootnote')
  hilink('markdownH2', 'markdownH1')
  hilink('markdownH3', 'markdownH1')
  hilink('markdownH4', 'markdownH1')
  hilink('markdownH5', 'markdownH1')
  hilink('markdownH6', 'markdownH1')
  hilink('markdownIdDelimiter', 'TSKeyword')
  hilink('markdownItalicDelimiter', 'TSKeyword')
  hilink('markdownLinkDelimiter', 'TSKeyword')
  hilink('markdownLinkTextDelimiter', 'TSKeyword')
  hilink('markdownListMarker', 'TSKeyword')
  hilink('markdownRule', 'TSKeyword')
  hilink('markdownHeadingDelimiter', 'TSKeyword')
end

local setup_plugin_colors = function()
  hi('LSPDiagnosticsWarning', {guifg = nord13_gui; ctermfg = nord13_term})
  hi('LSPDiagnosticsError', {guifg = nord11_gui; ctermfg = nord11_term})
  hi('LSPDiagnosticsInformation', {guifg = nord8_gui; ctermfg = nord8_term})
  hi('LSPDiagnosticsHint', {guifg = nord10_gui; ctermfg = nord10_term})
  hi('SignifySignAdd', {guifg = nord14_gui; ctermfg = nord14_term})
  hi('SignifySignChange', {guifg = nord13_gui; ctermfg = nord13_term})
  hi('SignifySignChangeDelete', {guifg = nord11_gui; ctermfg = nord11_term})
  hi('SignifySignDelete', {guifg = nord11_gui; ctermfg = nord11_term})

  hi('Sneak', {
    guifg = nord0_gui;
    guibg = nord13_gui;
    ctermbg = nord13_term;
    gui = 'bold'
  })
  hi('SneakScope', {
    guifg = nord0_gui;
    guibg = nord13_gui;
    ctermbg = nord13_term;
    gui = 'bold'
  })
  hi('SneakLabel', {
    guifg = nord0_gui;
    guibg = nord13_gui;
    ctermbg = nord13_term;
    gui = 'bold'
  })
  hi('StNormal', {guibg = nord9_gui; guifg = nord0_gui; gui = 'bold'})
  hi('StVisual', {guibg = nord15_gui; guifg = nord0_gui; gui = 'bold'})
  hi('StSelect', {guibg = nord14_gui; guifg = nord0_gui; gui = 'bold'})
  hi('StInsert', {guibg = nord8_gui; guifg = nord0_gui; gui = 'bold'})
  hi('StReplace', {guibg = nord11_gui; guifg = nord0_gui; gui = 'bold'})
  hi('StCommand', {guibg = nord13_gui; guifg = nord0_gui; gui = 'bold'})
  hi('StPrompt', {guibg = nord14_gui; guifg = nord0_gui; gui = 'bold'})
  hi('StTerm', {guibg = nord11_gui; guifg = nord4_gui; gui = 'bold'})
  hi('StNormalSep', {guifg = nord9_gui; guibg = nord1_gui})
  hi('StVisualSep', {guifg = nord15_gui; guibg = nord1_gui})
  hi('StSelectSep', {guifg = nord14_gui; guibg = nord1_gui})
  hi('StInsertSep', {guifg = nord8_gui; guibg = nord1_gui})
  hi('StReplaceSep', {guifg = nord11_gui; guibg = nord1_gui})
  hi('StCommandSep', {guifg = nord13_gui; guibg = nord1_gui})
  hi('StPromptSep', {guifg = nord14_gui; guibg = nord1_gui})
  hi('StTermSep', {guifg = nord11_gui; guibg = nord1_gui})
  hi('StLine', {guifg = M.brightened_comments[23]; gui = 'bold'})
  hi('StFunctionIndicator', {guifg = nord8_gui; gui = 'bold'})
  hi('StFunctionName', {guifg = M.brightened_comments[21]; gui = 'italic'})
  hi('StFileName', {guifg = M.brightened_comments[16]; gui = 'bold'})
  hi('StGitBranch', {guifg = M.brightened_comments[19]})

  hilink('ElNormal', 'StNormal')
  hilink('ElNormalOperatorPending', 'StNormal')
  hilink('ElVisual', 'StVisual')
  hilink('ElVisualLine', 'StVisual')
  hilink('ElVisualBlock', 'StVisual')
  hilink('ElSelect', 'StSelect')
  hilink('ElSLine', 'StSelect')
  hilink('ElSBlock', 'StSelect')
  hilink('ElInsert', 'StInsert')
  hilink('ElInsertCompletion', 'StInsert')
  hilink('ElReplace', 'StReplace')
  hilink('ElVirtualReplace', 'StReplace')
  hilink('ElCommand', 'StCommand')
  hilink('ElCommandCV', 'StCommand')
  hilink('ElCommandEx', 'StCommand')
  hilink('ElPrompt', 'StPrompt')
  hilink('ElMore', 'StPrompt')
  hilink('ElConfirm', 'StPrompt')
  hilink('ElShell', 'StTerm')
  hilink('ElTerm', 'StTerm')
  hilink('ElNormalSep', 'StNormalSep')
  hilink('ElVisualSep', 'StVisualSep')
  hilink('ElSelectSep', 'StSelectSep')
  hilink('ElInsertSep', 'StInsertSep')
  hilink('ElReplaceSep', 'StReplaceSep')
  hilink('ElCommandSep', 'StCommandSep')
  hilink('ElPromptSep', 'StPromptSep')
  hilink('ElTermSep', 'StTermSep')
  hilink('FindrNormal', 'Pmenu')
  hilink('FindrBorder', 'Comment')
  hilink('FindrMatch', 'Keyword')
  hilink('FindrSelected', 'PmenuSel')
  hilink('FindrDir', 'Directory')
end

return {
  basic_scheme = basic_scheme;
  setup_terminal = setup_terminal;
  setup_misc = setup_misc;
  setup_langbase = setup_langbase;
  setup_markdown = setup_markdown;
  setup_plugin_colors = setup_plugin_colors
}
