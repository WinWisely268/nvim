local M = {}

local lsp = vim.lsp
local lap_util = require('vim.lsp.util')
local parsers = require('nvim-treesitter.parsers')
local ts_utils = require('nvim-treesitter.ts_utils')

local ts_range = function(loc)
  if not loc.uri then
    return loc
  end

  local lang = parsers.ft_to_lang(vim.bo.filetype)
  if not lang or lang == '' then
    return loc
  end
  if not parsers.has_parser(lang) then
    return loc
  end

  local bufnr = vim.uri_to_bufnr(loc.uri)
  vim.api.nvim_buf_set_option(bufnr, 'buflisted', true)
  vim.api.nvim_buf_set_option(bufnr, 'filetype', vim.bo.filetype)

  local start_pos = loc.range.start
  local end_pos = loc.range['end']

  local parser = parsers.get_parser(bufnr, lang)
  local root = parser.tree:root()
  local node = root:named_descendant_for_range(start_pos.line, start_pos.character, end_pos.line,
                                               end_pos.character)
  local scope = ts_utils.containing_scope(node)
  if scope:type() == 'function_declaration' or scope:type() == 'method_declaration' then
    local sl, sc, el, ec = scope:range()
    loc.range.start.line = sl
    loc.range.start.character = sc
    loc.range['end'].line = el
    loc.range['end'].character = ec
  end
  return loc
end

local preview_location_callback = function(_, _, result)
  if not result or vim.tbl_isempty(result) then
    return
  end

  local loc = ts_range(result[1])
  lap_util.preview_location(loc)
end

function M.preview_definition()
  local params = lap_util.make_position_params()
  lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

function M.preview_declaration()
  local params = lap_util.make_position_params()
  lsp.buf_request(0, 'textDocument/declaration', params, preview_location_callback)
end

function M.preview_implementation()
  local params = lap_util.make_position_params()
  lsp.buf_request(0, 'textDocument/implementation', params, preview_location_callback)
end

function M.preview_type_definition()
  local params = lap_util.make_position_params()
  lsp.buf_request(0, 'textDocument/typeDefinition', params, preview_location_callback)
end

return M
