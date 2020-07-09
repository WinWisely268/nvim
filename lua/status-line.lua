local api = vim.api
local icons = require('cosmetics.devicon')
local color = require('cosmetics.colors')
local M = {}

-- Separators
local left_separator = ''
local right_separator = ''

-- Blank Between Components
local blank = ' '

------------------------------------------------------------------------
--                             StatusLine                             --
------------------------------------------------------------------------

-- Mode Prompt Table
local current_mode = setmetatable({
  ['n'] = 'N',
  ['no'] = 'N·Op Pending',
  ['v'] = 'V',
  ['V'] = 'V·Line',
  ['^V'] = 'V·Block',
  ['s'] = 'S',
  ['S'] = 'S·Line',
  ['^S'] = 'S·Block',
  ['i'] = 'I',
  ['ic'] = 'I',
  ['ix'] = 'I',
  ['R'] = 'R',
  ['Rv'] = 'V·Replace',
  ['c'] = 'C',
  ['cv'] = 'Vim Ex',
  ['ce'] = 'Ex',
  ['r'] = 'Prompt',
  ['rm'] = 'More',
  ['r?'] = 'Confirm',
  ['!'] = 'Shell',
  ['t'] = 'T',
}, {
  -- fix weird issues
  __index = function(_, _)
    return 'V·Block'
  end,
})

-- Default StatusLine
api.nvim_command('hi StatusLine guifg=' .. color.fg .. ' gui=bold')

-- Git Colors
local git_bg = color.darkgray
local git_fg = color.fg
local git_gui = 'bold'
api.nvim_command('hi GitStatus guibg=' .. git_bg .. ' guifg=' .. git_fg .. ' gui=' .. git_gui)
api.nvim_command('hi GitHunkAdd guibg=' .. git_bg .. ' guifg=' .. color.green)
api.nvim_command('hi GitHunkDel guibg=' .. git_bg .. ' guifg=' .. color.red)
api.nvim_command('hi GitHunkChg guibg=' .. git_bg .. ' guifg=' .. color.yellow)

-- LSP Highlight Theme
api.nvim_command('hi DiagInfo guibg=' .. git_bg .. ' guifg=' .. color.blue)
api.nvim_command('hi DiagHint guibg=' .. git_bg .. ' guifg=' .. color.green)
api.nvim_command('hi DiagWarning guibg=' .. git_bg .. ' guifg=' .. color.yellow)
api.nvim_command('hi DiagErr guibg=' .. git_bg .. ' guifg=' .. color.red)

-- Filename Color
local file_bg = color.magenta
local file_fg = color.black
local file_gui = 'bold'
api.nvim_command('hi File guibg=' .. file_bg .. ' guifg=' .. file_fg .. ' gui=' .. file_gui)
api.nvim_command('hi FileSeparator guifg=' .. file_bg)

-- Working directory Color
local dir_bg = color.darkgray
local dir_fg = color.white
local dir_gui = 'bold'
api.nvim_command('hi Directory guibg=' .. dir_bg .. ' guifg=' .. dir_fg .. ' gui=' .. dir_gui)
api.nvim_command('hi DirSeparator guifg=' .. dir_bg)

-- FileType Color
local filetype_bg = 'None'
local filetype_fg = color.magenta
local filetype_gui = 'bold'
api.nvim_command('hi Filetype guibg=' .. filetype_bg .. ' guifg=' .. filetype_fg .. ' gui=' ..
                   filetype_gui)

-- row and column Color
local line_bg = 'None'
local line_fg = color.white
local line_gui = 'bold'
api.nvim_command('hi Line guibg=' .. line_bg .. ' guifg=' .. line_fg .. ' gui=' .. line_gui)

-- Redraw different colors for different mode
local RedrawColors = function(mode)
  if mode == 'n' then
    api.nvim_command('hi Mode guibg=' .. color.blue .. ' guifg=' .. color.black .. ' gui=bold')
    api.nvim_command('hi ModeSeparator guifg=' .. color.blue)
  end
  if mode == 'i' then
    api.nvim_command('hi Mode guibg=' .. color.cyan .. ' guifg=' .. color.black .. ' gui=bold')
    api.nvim_command('hi ModeSeparator guifg=' .. color.cyan)
  end
  if mode == 'v' or mode == 'V' or mode == '^V' then
    api.nvim_command('hi Mode guibg=' .. color.magenta .. ' guifg=' .. color.black .. ' gui=bold')
    api.nvim_command('hi ModeSeparator guifg=' .. color.magenta)
  end
  if mode == 'c' then
    api.nvim_command('hi Mode guibg=' .. color.yellow .. ' guifg=' .. color.black .. ' gui=bold')
    api.nvim_command('hi ModeSeparator guifg=' .. color.yellow)
  end
  if mode == 't' then
    api.nvim_command('hi Mode guibg=' .. color.red .. ' guifg=' .. color.black .. ' gui=bold')
    api.nvim_command('hi ModeSeparator guifg=' .. color.red)
  end
end

local TrimmedDirectory = function(dir)
  local home = vim.loop.os_homedir()
  local _, index = string.find(dir, home, 1)
  if index ~= nil and index ~= string.len(dir) then
    -- TODO Trimmed Home Directory
    return string.gsub(dir, home, '~')
  end
  return dir
end

local function npcall(fn, ...)
  local ok_or_nil = function(status, ...)
    if not status then
      return
    end
    return ...
  end
  return ok_or_nil(pcall(fn, ...))
end

local function git_summary()
  local hunks = (function()
    return npcall(vim.fn['sy#repo#get_stats']) or {0, 0, 0}
  end)()
  local added = hunks[1] and hunks[1] ~= 0 and '%#GitHunkAdd#' .. '+' .. hunks[1] .. ' ' or ''
  local changed = hunks[2] and hunks[2] ~= 0 and '%#GitHunkChg#' .. '~' .. hunks[2] .. ' ' or ''
  local deleted = hunks[3] and hunks[3] ~= 0 and '%#GitHunkDel#' .. '-' .. hunks[3] .. ' ' or ''
  return added .. changed .. deleted
end

local function git_branch()
  local head = vim.api.nvim_call_function('gina#component#repo#branch', {})
  return head ~= '' and head or ''
end

local function git_status()
  local branch = git_branch()
  local hunks = git_summary()
  return branch ~= '' and ' ' .. branch .. '  ' .. hunks or ''
end

local function get_all_diagnostics()
  local result = {}
  local levels = {errors = 'Error', warnings = 'Warning', info = 'Information', hints = 'Hint'}

  for k, level in pairs(levels) do
    result[k] = vim.lsp.util.buf_diagnostics_count(level)
  end

  return result
end

local function diag_status()
  local buf_diagnostics = get_all_diagnostics()
  local parts = {}
  if buf_diagnostics.errors and buf_diagnostics.errors > 0 then
    table.insert(parts,
                 '%#DiagErr#' .. icons.deviconTable['errors'] .. buf_diagnostics.errors .. ' ')
  end
  if buf_diagnostics.warnings and buf_diagnostics.warnings > 0 then
    table.insert(parts, '%#DiagWarning#' .. icons.deviconTable['warnings'] ..
                   buf_diagnostics.warnings .. ' ')
  end
  if buf_diagnostics.hints and buf_diagnostics.hints > 0 then
    table.insert(parts,
                 '%#DiagHint#' .. icons.deviconTable['hints'] .. buf_diagnostics.hints .. ' ')
  end
  if buf_diagnostics.info and buf_diagnostics.info > 0 then
    table.insert(parts, '%#DiagInfo#' .. icons.deviconTable['info'] .. buf_diagnostics.info .. ' ')
  end
  local errors = parts[1] and parts[1] ~= '' and parts[1] or ''
  local warnings = parts[2] and parts[2] ~= '' and parts[2] or ''
  local hints = parts[3] and parts[3] ~= '' and parts[3] or ''
  local infos = parts[4] and parts[4] ~= '' and parts[4] or ''
  return errors .. warnings .. hints .. infos
end

function M.activeLine()
  local statusline = ''
  -- Component: Mode
  local mode = api.nvim_get_mode()['mode']
  RedrawColors(mode)
  statusline = statusline .. '%#ModeSeparator#' .. left_separator .. '%#Mode# ' ..
                 current_mode[mode] .. ' %#ModeSeparator#' .. right_separator
  statusline = statusline .. blank

  -- Component: Working Directory
  local dir = api.nvim_call_function('getcwd', {})
  statusline = statusline .. '%#DirSeparator#' .. left_separator .. '%#Directory# ' ..
                 TrimmedDirectory(dir) .. ' %#DirSeparator#' .. right_separator
  statusline = statusline .. blank

  -- Component: Git
  statusline =
    statusline .. '%#DirSeparator#' .. left_separator .. '%#GitStatus# ' .. git_status() ..
      '%#DirSeparator#' .. right_separator
  statusline = statusline .. blank

  -- Alignment to left
  statusline = statusline .. '%='

  local lsp_function = vim.b.lsp_current_function
  if lsp_function ~= nil then
    statusline = statusline .. '%#Function# ' .. lsp_function
    statusline = statusline .. blank
  end

  -- Component: Errors Warnings and Hints from LSP
  local dstatus = function()
    local ds = diag_status()
    return ds ~= '' and ds or ''
  end
  statusline = statusline .. '%#DirSeparator#' .. left_separator .. '%#GitStatus#' .. dstatus() ..
                 '%#DirSeparator#' .. right_separator
  statusline = statusline .. blank

  local filetype = api.nvim_buf_get_option(0, 'filetype')
  statusline = statusline .. '%#Filetype#' .. filetype
  statusline = statusline .. blank

  -- Component: FileType
  -- Component: row and col
  local line = api.nvim_call_function('line', {'.'})
  local col = vim.fn.col('.')
  while string.len(line) < 3 do
    line = line .. ' '
  end
  while string.len(col) < 3 do
    col = col .. ' '
  end
  statusline = statusline .. '%#Line# ℓ ' .. line .. ' 𝚌 ' .. col

  return statusline
end

local InactiveLine_bg = color.bg2
local InactiveLine_fg = color.white
api.nvim_command('hi InActive guibg=' .. InactiveLine_bg .. ' guifg=' .. InactiveLine_fg)

function M.inActiveLine()
  local file_name = api.nvim_call_function('expand', {'%F'})
  return '%#InActive# ' .. file_name
end

------------------------------------------------------------------------
--                              TabLine                               --
------------------------------------------------------------------------

local getTabLabel = function(n)
  local current_win = api.nvim_tabpage_get_win(n)
  local current_buf = api.nvim_win_get_buf(current_win)
  local file_name = api.nvim_buf_get_name(current_buf)
  if string.find(file_name, 'term://') ~= nil then
    return ' ' .. api.nvim_call_function('fnamemodify', {file_name, ':p:t'})
  end
  file_name = api.nvim_call_function('fnamemodify', {file_name, ':p:t'})
  if file_name == '' then
    return 'No Name'
  end
  local icon = icons.deviconTable[file_name]
  if icon ~= nil then
    return icon .. ' ' .. file_name
  end
  return file_name
end

api.nvim_command('hi TabLineSel gui=Bold guibg=' .. color.cyan .. ' guifg=' .. color.black .. '')
api.nvim_command('hi TabLineSelSeparator gui=bold guifg=' .. color.cyan .. '')
api.nvim_command('hi TabLine guibg=' .. color.bg .. ' guifg=' .. color.fg .. ' gui=None')
api.nvim_command('hi TabLineSeparator guifg=' .. color.bg .. '')
api.nvim_command('hi TabLineFill guibg=None gui=None')

function M.TabLine()
  local tabline = ''
  local tab_list = api.nvim_list_tabpages()
  local current_tab = api.nvim_get_current_tabpage()
  for _, val in ipairs(tab_list) do
    local file_name = getTabLabel(val)
    if val == current_tab then
      tabline = tabline .. '%#TabLineSelSeparator# ' .. left_separator
      tabline = tabline .. '%#TabLineSel# ' .. file_name
      tabline = tabline .. ' %#TabLineSelSeparator#' .. right_separator
    else
      tabline = tabline .. '%#TabLineSeparator# ' .. left_separator
      tabline = tabline .. '%#TabLine# ' .. file_name
      tabline = tabline .. ' %#TabLineSeparator#' .. right_separator
    end
  end
  return tabline
end
return M
