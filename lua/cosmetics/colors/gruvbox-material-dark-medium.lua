-------------------------------------------------------------------------------
--                                  Gruvbox Lazy                                --
-------------------------------------------------------------------------------
local M = {}
M.black = '#282828'
M.red = '#EA6962'
M.green = '#A9B665'
M.yellow = '#D8A657'
M.blue = '#7DAEA3'
M.purple = '#D3869B'
M.aqua = '#89B482'
M.orange = '#e78a4e'
M.lightgray = '#DDC7A1'
M.darkgray = '#32302F'
M.white = '#DDC7A1'
M.fg = '#D4BE98'
M.fg2 = '#DDC7A1'
M.bg = '#282828'
M.bg1 = '#32302F'
M.bg2 = '#45403d'
M.bg3 = '#5A524C'

local bg0 = {M.black; '235'}
local bg1 = {M.bg1; '236'}
local bg2 = {M.bg1; '236'}
local bg3 = {M.bg2; '237'}
local bg4 = {M.bg2; '237'}
local bg5 = {M.bg3; '239'}
local bg_statusline1 = {'#32302f'; '236'}
local bg_statusline2 = {'#3a3735'; '236'}
local bg_statusline3 = {'#504945'; '240'}
local bg_diff_green = {'#34381b'; '22'}
-- local bg_visual_green =  {'#3b4439',   '22'}
local bg_diff_red = {'#402120'; '52'}
-- local bg_visual_red =    {'#4c3432',   '52'}
local bg_diff_blue = {'#0e363e'; '17'}
local bg_visual_blue = {'#374141'; '17'}
-- local bg_visual_yellow = {'#4f422e',   '94'}
-- local bg_current_word =  {'#3c3836',   '237'}
local fg0 = {M.fg; '223'}
local fg1 = {M.fg2; '223'}
local red = {M.red; '167'}
local orange = {M.orange; '208'}
local yellow = {M.yellow; '214'}
local green = {M.green; '142'}
local aqua = {M.aqua; '108'}
local blue = {M.blue; '109'}
local purple = {M.purple; '175'}
-- local bg_red =           {M.red,   '167'}
-- local bg_green =         {M.green,   '142'}
-- local bg_yellow =        {M.yellow,   '214'}
local grey0 = {'#7c6f64'; '243'}
local grey1 = {'#928374'; '245'}
local grey2 = {'#a89984'; '246'}

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
  hi('ColorColumn', {guibg = bg2[1]; ctermbg = bg2[2]})
  hi('Conceal', {guifg = grey0[1]; ctermfg = grey0[2]})
  hi('Cursor', {guifg = fg1[1]; guibg = bg3[1]})
  hi('CursorLine', {guibg = bg1[1]; ctermbg = bg1[2]})
  hilink('iCursor', 'Cursor')
  hi('LineNr', {guifg = grey0[1]; ctermfg = grey0[2]})
  hi('MatchParen', {guibg = bg4[1]; ctermbg = bg4[2]})
  hi('Normal', {guifg = fg0[1]; guibg = fg0[2]})
  hi('Pmenu', {guifg = fg1[1]; guibg = bg3[1]; ctermbg = bg3[2]})
  hi('PmenuSbar', {guifg = 'NONE'; guibg = bg3[1]; ctermbg = bg3[2]})
  hi('PmenuSel',
     {guifg = bg3[1]; guibg = red[1]; ctermfg = bg3[2]; ctermbg = red[2]})
  hi('PmenuThumb', {guibg = grey0[1]; ctermbg = grey0[2]})
  hi('SpecialKey', {guifg = bg5[1]; ctermfg = bg5[2]})
  hi('SpellBad', {guifg = red[1]; ctermfg = red[2]; gui = 'undercurl'})
  hi('SpellCap', {guifg = blue[1]; ctermfg = blue[2]; gui = 'undercurl'})
  hi('SpellLocal', {guifg = aqua[1]; ctermfg = aqua[2]; gui = 'undercurl'})
  hi('SpellRare', {guifg = purple[1]; ctermfg = purple[2]; gui = 'undercurl'})
  hi('Visual', {guibg = bg_visual_blue[1]; ctermbg = bg_visual_blue[2]})
  hilink('VisualNOS', 'Visual')
  hi('healthError',
     {guifg = red[1]; guibg = bg1[1]; ctermfg = red[2]; ctermbg = bg1[2]})
  hi('healthSuccess',
     {guifg = green[1]; guibg = bg1[1]; ctermfg = green[2]; ctermbg = bg1[2]})
  hi('healthWarning',
     {guifg = yellow[1]; guibg = bg1[1]; ctermfg = yellow[2]; ctermbg = bg1[2]})
  hilink('TermCursor', 'Cursor')
  hilink('TermCursorNC', 'Cursor')
end

local setup_terminal = function()
  local terminal_colors = {
    terminal_color_0 = bg0[1];
    terminal_color_1 = red[1];
    terminal_color_2 = green[1];
    terminal_color_3 = yellow[1];
    terminal_color_4 = blue[1];
    terminal_color_5 = purple[1];
    terminal_color_6 = aqua[1];
    terminal_color_7 = fg0[1];
    terminal_color_8 = bg1[1];
    terminal_color_9 = red[1];
    terminal_color_10 = green[1];
    terminal_color_11 = yellow[1];
    terminal_color_12 = blue[1];
    terminal_color_13 = purple[1];
    terminal_color_14 = aqua[1];
    terminal_color_15 = fg1[1]
  }
  for k, v in pairs(terminal_colors) do vim.g[k] = v end
end

local setup_misc = function()
  hi('CursorColumn', {guibg = bg1[1]; ctermbg = bg1[2]})
  hi('CursorLineNr',
     {guifg = orange[1]; guibg = bg1[1]; ctermfg = orange[2]; ctermbg = bg1[2]})
  hi('Folded', {
    guifg = grey1[1];
    guibg = bg2[1];
    ctermfg = grey2[2];
    ctermbg = bg2[2];
    gui = 'bold'
  })
  hi('FoldColumn', {guifg = grey0[1]; guibg = bg2[1]; ctermfg = grey0[2]})
  hi('SignColumn',
     {guifg = fg0[1]; guibg = bg2[1]; ctermfg = fg0[2]; ctermbg = bg2[2]})
  hi('Directory', {guifg = green[1]; ctermfg = green[2]})
  hi('EndOfBuffer', {guifg = bg0[1]; ctermfg = bg0[2]})
  hi('Error', {})
  hi('ErrorMsg', {guifg = red[1]; ctermfg = red[2]; gui = 'bold,underline'})
  hi('ModeMsg', {guifg = fg0[1]; gui = 'bold'; ctermfg = fg0[2]})
  hi('MoreMsg', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('Question', {guifg = yellow[1]})
  hi('StatusLine',
     {guifg = grey2[1]; guibg = bg_statusline2[1]; ctermfg = fg1[2]})
  hi('StatusLineNC',
     {guifg = grey2[1]; guibg = bg_statusline2[1]; ctermfg = grey2[2]})
  hilink('StatusLineTerm', 'StatusLine')
  hilink('StatusLineTermNC', 'StatusLineNC')
  hi('WarningMsg',
     {guifg = bg0[1]; guibg = yellow[1]; ctermfg = bg0[2]; ctermbg = yellow[2]})
  hilink('WildMenu', 'PmenuSel')
  hi('IncSearch', {
    guifg = bg0[1];
    guibg = red[1];
    ctermfg = bg0[2];
    ctermbg = red[2];
    gui = 'underline'
  })
  hi('Search',
     {guifg = bg0[1]; guibg = green[1]; ctermfg = bg0[2]; ctermbg = green[2]})
  hi('TabLine', {
    guifg = fg1[1];
    guibg = bg_statusline3[1];
    ctermbg = bg_statusline3[2];
    ctermfg = fg1[2]
  })
  hi('TabLineFill', {
    guifg = fg0[1];
    guibg = bg_statusline1[1];
    ctermfg = fg0[2];
    ctermbg = bg_statusline1[2]
  })
  hi('TabLineSel', {
    guifg = bg0[1];
    guibg = grey2[1];
    ctermfg = bg0[2];
    ctermbg = grey2[2];
    gui = 'bold'
  })
  hi('TabLineSeparator',
     {guifg = bg_statusline3[1]; ctermfg = bg_statusline3[2]})
  hi('TabLineSelSeparator', {guifg = grey2[1]; ctermfg = grey2[2]})
  hi('Title', {guifg = orange[1]; ctermfg = orange[2]})
  hi('VertSplit', {guifg = bg5[1]; ctermfg = bg5[2]})
  hi('DiffAdd', {guibg = bg_diff_green[1]; ctermbg = bg_diff_green[2]})
  hi('DiffChange', {guibg = bg_diff_blue[1]; ctermbg = bg_diff_blue[2]})
  hi('DiffDelete', {guibg = bg_diff_red[1]; ctermbg = bg_diff_red[2]})
  hi('DiffText',
     {guifg = bg0[1]; guibg = fg0[1]; ctermfg = bg0[2]; ctermbg = fg0[2]})
end

-- local setup_hl_treesitter = function()
--   hi('TSConditional', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
--   hi('TSPunctDelimiter', {guifg = gbdm6_gui, ctermfg = gbdm6_term})
--   hi('TSException', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
--   hi('TSFunction', {guifg = gbdm8_gui, ctermfg = gbdm8_term})
--   hi('TSKeyword', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
--   hi('TSLabel', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
--   hi('TSOperator', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
--   hi('TSIdentifier', {guifg = gbdm4_gui, ctermfg = 'NONE'})
--   hi('TSRepeat', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
--   hi('TSConstant', {guifg = gbdm4_gui, ctermfg = 'NONE'})
--   hi('TSConstBuiltin', {guifg = gbdm4_gui, ctermfg = 'NONE'})
--   hi('TSConstMacro', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
--   hi('TSString', {guifg = gbdm14_gui, ctermfg = gbdm14_term})
--   hi('TSStringRegex', {guifg = gbdm13_gui, ctermfg = gbdm14_term})
--   hi('TSStringEscape', {guifg = gbdm13_gui, ctermfg = gbdm14_term})
--   hi('TSNumber', {guifg = gbdm15_gui, ctermfg = gbdm15_term})
--   hi('TSBoolean', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
--   hi('TSCharacter', {guifg = gbdm14_gui, ctermfg = gbdm14_term})
--   hi('TSFloat', {guifg = gbdm15_gui, ctermfg = gbdm15_term})
--   hi('Comment', {guifg = M.brightened_comments[19], ctermfg = gbdm3_term, gui = 'italic'})
--   hi('TSStructure', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
--   hi('TSType', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
--   hi('TSTypeBuiltin', {guifg = gbdm7_gui, ctermfg = gbdm7_term})
--   hi('TSInclude', {guifg = gbdm9_gui, ctermfg = gbdm9_term})
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

  hi('Boolean', {guifg = purple[1]; ctermfg = purple[2]})
  hi('Character', {guifg = green[1]; ctermfg = green[2]})
  hi('Comment', {guifg = grey1[1]; ctermfg = grey1[2]; gui = 'italic'})
  hi('Conditional', {guifg = red[1]; ctermfg = red[2]})
  hi('Constant', {guifg = fg0[1]; ctermfg = fg0[2]; gui = 'italic'})
  hi('Define', {guifg = purple[1]; ctermfg = purple[2]})
  hi('Delimiter', {guifg = fg0[1]; ctermfg = fg0[2]})
  hi('Exception', {guifg = red[1]; ctermfg = red[2]})
  hi('Float', {guifg = purple[1]; ctermfg = purple[2]})
  hi('Function', {guifg = green[1]; ctermfg = green[2]})
  hi('Identifier', {guifg = fg1[1]; ctermfg = fg1[2]})
  hi('Include', {guifg = purple[1]; ctermfg = purple[2]})
  hi('Keyword', {guifg = red[1]; ctermfg = red[2]})
  hi('Label', {guifg = orange[1]; ctermfg = orange[2]})
  hi('Number', {guifg = purple[1]; ctermfg = purple[2]})
  hi('Operator', {guifg = orange[1]; ctermfg = orange[2]})
  hi('PreProc', {guifg = purple[1]; ctermfg = purple[2]})
  hi('Repeat', {guifg = red[1]; ctermfg = red[2]})
  hi('Special', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('SpecialChar', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('SpecialComment', {guifg = grey1[1]; ctermfg = grey1[2]; gui = 'italic'})
  hi('Statement', {guifg = red[1]; ctermfg = red[2]})
  hi('StorageClass', {guifg = orange[1]; ctermfg = orange[2]})
  hi('String', {guifg = green[1]; ctermfg = green[2]})
  hi('Structure', {guifg = orange[1]; ctermfg = orange[2]})
  hi('Tag', {guifg = orange[1]; ctermfg = orange[2]})
  hi('Todo', {guifg = purple[1]; ctermfg = purple[2]; gui = 'bold,italic'})
  hi('Type', {guifg = aqua[1]; ctermfg = aqua[2]})
  hi('Typedef', {guifg = red[1]; ctermfg = red[2]})
  hi('NonText', {guifg = bg5[1]; ctermfg = bg5[2]})

  hi('Macro', {guifg = aqua[1]; ctermfg = aqua[2]})
  hilink('PreCondit', 'PreProc')
  -- others
  -- hilink('TSPunctBracket', 'Delimiter')
  -- hilink('TSPunctSpecial', 'Delimiter')
  -- hilink('TSFuncBuiltin', 'Special')
  -- hilink('TSFuncMacro', 'Macro')
  hilink('TSMethod', 'Function')
  hilink('TSProperty', 'Identifier')
  hilink('TSField', 'Identifier')
  -- hilink('TSConstructor', 'Type')
  hi('TSTypeBuiltin', {guifg = blue[1]; ctermfg = blue[2]; gui = 'bold,italic'})
end

local setup_markdown = function()
  hi('markdownBold', {gui = 'bold'})
  hi('markdownItalic', {gui = 'italic'})
  hi('markdownBlockquote', {guifg = grey1[1]; ctermfg = grey1[2]})
  hi('markdownCode', {guifg = green[1]; ctermfg = green[2]})
  hi('markdownCodeDelimiter', {guifg = aqua[1]; ctermfg = aqua[2]})
  hi('markdownId', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('markdownIdDeclaration', {guifg = purple[1]; ctermfg = purple[2]})
  hi('markdownH1', {guifg = aqua[1]; ctermfg = aqua[2]})
  hi('markdownLinkText', {guifg = purple[1]; ctermfg = purple[2]})
  hi('markdownUrl', {guifg = blue[1]; ctermfg = blue[2]})

  hilink('markdownBoldDelimiter', 'Keyword')
  hilink('markdownFootnoteDefinition', 'markdownFootnote')
  hilink('markdownH2', 'markdownH1')
  hilink('markdownH3', 'markdownH1')
  hilink('markdownH4', 'markdownH1')
  hilink('markdownH5', 'markdownH1')
  hilink('markdownH6', 'markdownH1')
  hilink('markdownIdDelimiter', 'Keyword')
  hilink('markdownItalicDelimiter', 'Keyword')
  hilink('markdownLinkDelimiter', 'Keyword')
  hilink('markdownLinkTextDelimiter', 'Keyword')
  hilink('markdownListMarker', 'Keyword')
  hilink('markdownRule', 'Keyword')
  hilink('markdownHeadingDelimiter', 'Keyword')
end

local setup_plugin_colors = function()
  hi('LspDiagnosticsWarning', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('LspDiagnosticsError', {guifg = red[1]; ctermfg = red[2]})
  hi('LspDiagnosticsInformation', {guifg = bg5[1]; ctermfg = bg5[2]})
  hi('LspDiagnosticsHint', {guifg = blue[1]; ctermfg = blue[2]})
  hi('SignifySignAdd', {guifg = green[1]; ctermfg = green[2]})
  hi('SignifySignChange', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('SignifySignChangeDelete', {guifg = orange[1]; ctermfg = orange[2]})
  hi('SignifySignDelete', {guifg = red[1]; ctermfg = red[2]})
  hilink('Sneak', 'Search')
  hilink('SneakLabel', 'Search')
  hilink('SneakScope', 'DiffText')
  hi('StNormal', {guibg = yellow[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StVisual', {guibg = purple[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StSelect', {guibg = orange[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StInsert', {guibg = aqua[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StReplace', {guibg = red[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StCommand', {guibg = blue[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StPrompt', {guibg = green[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StTerm', {guibg = red[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StNormalSep', {guifg = yellow[1]; guibg = bg_statusline3[1]})
  hi('StVisualSep', {guifg = purple[1]; guibg = bg_statusline3[1]})
  hi('StSelectSep', {guifg = orange[1]; guibg = bg_statusline3[1]})
  hi('StInsertSep', {guifg = aqua[1]; guibg = bg_statusline3[1]})
  hi('StReplaceSep', {guifg = red[1]; guibg = bg_statusline3[1]})
  hi('StCommandSep', {guifg = blue[1]; guibg = bg_statusline3[1]})
  hi('StPromptSep', {guifg = green[1]; guibg = bg_statusline3[1]})
  hi('StTermSep', {guifg = red[1]; guibg = bg_statusline3[1]})
  hi('StLine', {guifg = grey2[1]; gui = 'bold'})
  hi('StFunctionIndicator', {guifg = aqua[1]; gui = 'bold'})
  hi('StFunctionName', {guifg = grey2[1]; gui = 'italic'})
  hi('StFileName', {guifg = grey2[1]; gui = 'bold'})
  hi('StGitBranch', {guifg = grey1[1]})

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
