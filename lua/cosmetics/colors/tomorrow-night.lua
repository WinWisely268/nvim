-------------------------------------------------------------------------------
--                                  Tomorrow Night Lazy                                --
-------------------------------------------------------------------------------
local M = {}
M.black = '#1d1f21'
M.red = '#cc6666'
M.green = '#b5bd68'
M.yellow = '#f0c674'
M.blue = '#81a2be'
M.purple = '#b294bb'
M.cyan = '#8abeb7'
M.brown = '#a3685a'
M.orange = '#de935f'
M.lightgray = '#b4b7b4'
M.darkgray = '#282A2E'
M.white = '#ffffff'
M.fg = '#C5C8C6'
M.fg2 = '#E0E0E0'
M.bg = '#1d1f21'
M.bg1 = '#282a2e'
M.bg2 = '#373b41'
M.bg3 = '#969896'

local bg0 = {M.black; '235'}
local bg1 = {M.bg1; '236'}
local bg2 = {M.bg2; '236'}
local bg3 = {M.bg3; '237'}
local bg_statusline1 = {M.bg1; '236'}
local bg_statusline2 = {M.bg2; '236'}
local bg_statusline3 = {M.bg3; '240'}
local bg_diff_green = {'#34381b'; '22'}
local bg_diff_red = {'#402120'; '52'}
local bg_diff_blue = {'#0e363e'; '17'}
local fg0 = {M.fg; '223'}
local fg1 = {M.fg2; '223'}
local red = {M.red; '1'}
local brown = {M.brown; '208'}
local yellow = {M.yellow; '3'}
local green = {M.green; '2'}
local cyan = {M.cyan; '6'}
local blue = {M.blue; '4'}
local purple = {M.purple; '5'}
local orange = {M.orange, '9'}
local grey0 = {'#969896'; '7'}
local grey1 = {'#B4B7B4'; '248'}
local grey2 = {M.fg; '250'}

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
  hi('Conceal', {guifg = blue[1]; ctermfg = blue[2]})
  hi('Cursor', {guifg = fg0[1]; guibg = blue[1]; ctermfg = fg0[2]; ctermbg = blue[2]})
  hi('CursorLine', {guibg = bg1[1]; ctermbg = bg1[2]})
  hilink('iCursor', 'Cursor')
  hi('LineNr', {guifg = grey0[1]; guibg = bg1[1]; ctermfg = grey0[2]; ctermbg = bg1[2]})
  hi('MatchParen', {guibg = bg3[1]; ctermbg = bg3[2]})
  hi('Normal', {guifg = fg0[1]; guibg = fg0[2]})
  hi('Pmenu', {guifg = fg1[1]; guibg = bg1[1]; ctermbg = bg1[2]})
  hi('PmenuSbar', {guifg = 'NONE'; guibg = bg3[1]; ctermbg = bg3[2]})
  hi('PmenuSel',
     {guifg = bg1[1]; guibg = fg1[1]; ctermfg = bg1[2]; ctermbg = fg1[2]})
  hi('PmenuThumb', {guibg = grey0[1]; ctermbg = grey0[2]})
  hi('SpecialKey', {guifg = bg3[1]; ctermfg = bg3[2]})
  hi('SpellBad', {guifg = red[1]; ctermfg = red[2]; gui = 'undercurl'})
  hi('SpellCap', {guifg = blue[1]; ctermfg = blue[2]; gui = 'undercurl'})
  hi('SpellLocal', {guifg = cyan[1]; ctermfg = cyan[2]; gui = 'undercurl'})
  hi('SpellRare', {guifg = purple[1]; ctermfg = purple[2]; gui = 'undercurl'})
  hi('Visual', {guibg = bg2[1]; ctermbg = bg2[2]})
  hilink('VisualNOS', 'Visual')
  hi('healthError',
     {guifg = red[1]; guibg = bg1[1]; ctermfg = red[2]; ctermbg = bg1[2]})
  hi('healthSuccess',
     {guifg = green[1]; guibg = bg1[1]; ctermfg = green[2]; ctermbg = bg1[2]})
  hi('healthWarning',
     {guifg = yellow[1]; guibg = bg1[1]; ctermfg = yellow[2]; ctermbg = bg1[2]})
  hilink('TermCursor', 'Cursor')
  hilink('TermCursorNC', 'Cursor')
	hilink('PMenu', 'Pmenu')
	hilink('PMenuSel', 'PMenuSel')
end

local setup_terminal = function()
  local terminal_colors = {
    terminal_color_0 = bg0[1];
    terminal_color_1 = red[1];
    terminal_color_2 = green[1];
    terminal_color_3 = yellow[1];
    terminal_color_4 = blue[1];
    terminal_color_5 = purple[1];
    terminal_color_6 = cyan[1];
    terminal_color_7 = fg0[1];
    terminal_color_8 = bg3[1];
    terminal_color_9 = red[1];
    terminal_color_10 = green[1];
    terminal_color_11 = yellow[1];
    terminal_color_12 = blue[1];
    terminal_color_13 = purple[1];
    terminal_color_14 = cyan[1];
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
  hi('FoldColumn', {guifg = cyan[1]; guibg = bg2[1]; ctermfg = cyan[2]})
  hi('SignColumn',
     {guifg = bg3[1]; guibg = bg0[1]; ctermfg = bg3[2]; ctermbg = bg0[2]})
  hi('Directory', {guifg = blue[1]; ctermfg = blue[2]})
  hi('EndOfBuffer', {guifg = bg0[1]; ctermfg = bg0[2]})
  hi('Error', {})
  hi('ErrorMsg', {guifg = red[1]; ctermfg = red[2]; gui = 'bold,underline'})
  hi('ModeMsg', {guifg = fg0[1]; gui = 'bold'; ctermfg = fg0[2]})
  hi('MoreMsg', {guifg = green[1]; ctermfg = green[2]})
  hi('Question', {guifg = blue[1]})
  hi('StatusLine',
     {guifg = grey0[1]; guibg = bg0[1]; ctermfg = fg1[2]})
  hi('StatusLineNC',
     {guifg = grey0[1]; guibg = bg0[1]; ctermfg = grey2[2]})
  hilink('StatusLineTerm', 'StatusLine')
  hilink('StatusLineTermNC', 'StatusLineNC')
  hi('WarningMsg',
     {guifg = bg0[1]; guibg = yellow[1]; ctermfg = bg0[2]; ctermbg = yellow[2]})
  hilink('WildMenu', 'PmenuSel')
  hi('IncSearch', {
    guifg = bg0[1];
    guibg = yellow[1];
    ctermfg = bg0[2];
    ctermbg = yellow[2];
    gui = 'underline'
  })
  hi('Search',
     {guifg = bg0[1]; guibg = yellow[1]; ctermfg = bg0[2]; ctermbg = yellow[2]})
  hi('TabLine', {
    guifg = bg3[1];
    guibg = bg_statusline2[1];
    ctermbg = bg_statusline2[2];
    ctermfg = bg3[2]
  })
  hi('TabLineFill', {
    guifg = bg3[1];
    guibg = bg_statusline2[1];
    ctermfg = bg3[2];
    ctermbg = bg_statusline2[2]
  })
  hi('TabLineSel', {
    guifg = bg1[1];
    guibg = blue[1];
    ctermfg = bg1[2];
    ctermbg = blue[2];
    gui = 'bold'
  })
  hi('TabLineSeparator',
     {guifg = bg_statusline2[1]; ctermfg = bg_statusline2[2]})
  hi('TabLineSelSeparator', {guifg = blue[1]; ctermfg = blue[2]})
  hi('Title', {guifg = blue[1]; ctermfg = blue[2]})
  hi('VertSplit', {guifg = bg2[1]; ctermfg = bg2[2]})
  hi('DiffAdd', {guifg = green[1]; ctermfg = bg_diff_green[2]})
  hi('DiffChange', {guifg = yellow[1]; ctermfg = bg_diff_blue[2]})
  hi('DiffDelete', {guifg = red[1]; ctermfg = bg_diff_red[2]})
  hi('DiffText',
     {guifg = blue[1]; ctermfg = blue[2]})
end


local setup_langbase = function()
  hi('Boolean', {guifg = orange[1]; ctermfg = orange[2]})
  hi('Character', {guifg = red[1]; ctermfg = red[2]})
  hi('Comment', {guifg = grey0[1]; ctermfg = grey0[2]; gui = 'italic'})
  hi('Conditional', {guifg = purple[1]; ctermfg = purple[2]})
  hi('Constant', {guifg = fg0[1]; ctermfg = fg0[2]; gui = 'italic'})
  hi('Define', {guifg = purple[1]; ctermfg = purple[2]})
  hi('Delimiter', {guifg = fg1[1]; ctermfg = fg1[2]})
  hi('Exception', {guifg = red[1]; ctermfg = red[2]})
  hi('Float', {guifg = orange[1]; ctermfg = orange[2]})
  hi('Function', {guifg = blue[1]; ctermfg = blue[2]})
  hi('Identifier', {guifg = fg1[1]; ctermfg = fg1[2]})
  hi('Include', {guifg = blue[1]; ctermfg = blue[2]})
  hi('Keyword', {guifg = purple[1]; ctermfg = purple[2]})
  hi('Label', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('Number', {guifg = orange[1]; ctermfg = orange[2]})
  hi('Operator', {guifg = fg0[1]; ctermfg = fg0[2]})
  hi('PreProc', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('Repeat', {guifg = red[1]; ctermfg = red[2]})
  hi('Special', {guifg = cyan[1]; ctermfg = cyan[2]})
  hi('SpecialChar', {guifg = brown[1]; ctermfg = brown[2]})
  hi('SpecialComment', {guifg = grey0[1]; ctermfg = grey0[2]; gui = 'italic'})
  hi('Statement', {guifg = red[1]; ctermfg = red[2]})
  hi('StorageClass', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('String', {guifg = green[1]; ctermfg = green[2]})
  hi('Structure', {guifg = purple[1]; ctermfg = purple[2]})
  hi('Tag', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('Todo', {guifg = yellow[1]; guibg = bg1[1]; ctermfg = yellow[2]; ctermbg = bg1[2]; gui = 'bold,italic'})
  hi('Type', {guifg = fg0[1]; ctermfg = fg0[2]; gui='bold'})
  hi('Typedef', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('NonText', {guifg = bg3[1]; ctermfg = bg3[2]})

  hi('Macro', {guifg = blue[1]; ctermfg = blue[2]})
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
  hi('TSTypeBuiltin', {guifg = fg0[1]; ctermfg = fg0[2]; gui = 'bold,italic'})
end

local setup_markdown = function()
  hi('markdownBold', {gui = 'bold'})
  hi('markdownItalic', {gui = 'italic'})
  hi('markdownBlockquote', {guifg = grey1[1]; ctermfg = grey1[2]})
  hi('markdownCode', {guifg = green[1]; ctermfg = green[2]})
  hi('markdownCodeDelimiter', {guifg = cyan[1]; ctermfg = cyan[2]})
	hi('markdownCodeBlock', {guifg = green[1]; ctermfg = green[2]})
  hi('markdownId', {guifg = orange[1]; ctermfg = orange[2]})
  hi('markdownIdDeclaration', {guifg = purple[1]; ctermfg = purple[2]})
  hi('markdownH1', {guifg = purple[1]; ctermfg = purple[2]})
  hi('markdownLinkText', {guifg = fg1[1]; ctermfg = fg1[2]})
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
  hi('LspDiagnosticsInformation', {guifg = bg3[1]; ctermfg = bg3[2]})
  hi('LspDiagnosticsHint', {guifg = blue[1]; ctermfg = blue[2]})
  hi('SignifySignAdd', {guifg = green[1]; ctermfg = green[2]})
  hi('SignifySignChange', {guifg = yellow[1]; ctermfg = yellow[2]})
  hi('SignifySignChangeDelete', {guifg = brown[1]; ctermfg = brown[2]})
  hi('SignifySignDelete', {guifg = red[1]; ctermfg = red[2]})
  hilink('Sneak', 'Search')
  hilink('SneakLabel', 'Search')
  hilink('SneakScope', 'DiffText')
  hi('StNormal', {guibg = blue[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StVisual', {guibg = purple[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StSelect', {guibg = orange[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StInsert', {guibg = green[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StReplace', {guibg = orange[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StCommand', {guibg = yellow[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StPrompt', {guibg = cyan[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StTerm', {guibg = red[1]; guifg = bg_statusline2[1]; gui = 'bold'})
  hi('StNormalSep', {guifg = blue[1]; guibg = bg_statusline2[1]})
  hi('StVisualSep', {guifg = purple[1]; guibg = bg_statusline2[1]})
  hi('StSelectSep', {guifg = orange[1]; guibg = bg_statusline2[1]})
  hi('StInsertSep', {guifg = green[1]; guibg = bg_statusline2[1]})
  hi('StReplaceSep', {guifg = orange[1]; guibg = bg_statusline2[1]})
  hi('StCommandSep', {guifg = yellow[1]; guibg = bg_statusline2[1]})
  hi('StPromptSep', {guifg = cyan[1]; guibg = bg_statusline2[1]})
  hi('StTermSep', {guifg = red[1]; guibg = bg_statusline2[1]})
  hi('StLine', {guifg = grey0[1]; gui = 'bold'})
  hi('StFunctionIndicator', {guifg = cyan[1]; gui = 'bold'})
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
  hilink('FindrNormal', 'TabLine')
  hilink('FindrBorder', 'TabLineSeparator')
  hilink('FindrMatch', 'Keyword')
  hilink('FindrSelected', 'Keyword')
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
