local api = vim.api
local util = vim.lsp.util
local protocol = vim.lsp.protocol
local highlight = require('vim.highlight')

local M = {}

local diagnostics_by_buf = {}

local underline_highlight_name = 'LspDiagnosticsUnderline'

local sign_namespaces = {}

local diagnostic_namespaces = {}

local sign_ns = function(client_id)
  if sign_namespaces[client_id] == nil then
    sign_namespaces[client_id] = string.format('lsp-sign-%d', client_id)
  end
  return sign_namespaces[client_id]
end

local diagnostic_ns = function(client_id)
  if diagnostic_namespaces[client_id] == nil then
    diagnostic_namespaces[client_id] = api.nvim_create_namespace(
                                         string.format('lsp-diagnostic-%d', client_id))
  end
  return diagnostic_namespaces[client_id]
end

local buf_clear_diagnostics = function(bufnr, client_id)
  vim.fn.sign_unplace(sign_ns(client_id), {buffer = bufnr})
  api.nvim_buf_clear_namespace(bufnr, diagnostic_ns(client_id), 0, -1)
end

local buf_diagnostics_underline = function(bufnr, client_id, diagnostics)
  for _, diagnostic in ipairs(diagnostics) do
    local start = diagnostic.range['start']
    local finish = diagnostic.range['end']

    local hlmap = {
      [protocol.DiagnosticSeverity.Error] = 'Error';
      [protocol.DiagnosticSeverity.Warning] = 'Warning';
      [protocol.DiagnosticSeverity.Information] = 'Information';
      [protocol.DiagnosticSeverity.Hint] = 'Hint';
    }

    highlight.range(bufnr, diagnostic_ns(client_id),
                    underline_highlight_name .. hlmap[diagnostic.severity],
                    {start.line; start.character}, {finish.line; finish.character})
  end
end

local buf_diagnostics_virtual_text = function(bufnr, client_id, diagnostics)
  if not diagnostics then
    return
  end
  local buffer_line_diagnostics = util.diagnostics_group_by_line(diagnostics)
  for line, line_diags in pairs(buffer_line_diagnostics) do
    local virt_texts = {}
    for _ = 1, #line_diags - 1 do
      table.insert(virt_texts, {'■'; 'LspDiagnostics'})
    end
    local last = line_diags[#line_diags]
    table.insert(virt_texts,
                 {'■ ' .. last.message:gsub('\r', ''):gsub('\n', '  '); 'LspDiagnostics'})
    api.nvim_buf_set_virtual_text(bufnr, diagnostic_ns(client_id), line, virt_texts, {})
  end
end

local buf_diagnostics_signs = function(bufnr, client_id, diagnostics)
  local diagnostic_severity_map = {
    [protocol.DiagnosticSeverity.Error] = 'LspDiagnosticsErrorSign';
    [protocol.DiagnosticSeverity.Warning] = 'LspDiagnosticsWarningSign';
    [protocol.DiagnosticSeverity.Information] = 'LspDiagnosticsInformationSign';
    [protocol.DiagnosticSeverity.Hint] = 'LspDiagnosticsHintSign';
  }

  for _, diagnostic in ipairs(diagnostics) do
    vim.fn.sign_place(0, sign_ns(client_id), diagnostic_severity_map[diagnostic.severity], bufnr,
                      {lnum = (diagnostic.range.start.line + 1)})
  end
end

local save_all_positions = function(bufnr, client_id, diagnostics)
  if not diagnostics_by_buf[bufnr] then
    diagnostics_by_buf[bufnr] = {}
    api.nvim_buf_attach(bufnr, false, {
      on_detach = function(b)
        diagnostics_by_buf[b] = nil
      end;
    })
  end
  diagnostics_by_buf[bufnr][client_id] = diagnostics

  local all_diagnostics = {}
  for _, diagnostic_list in pairs(diagnostics_by_buf[bufnr]) do
    for _, d in ipairs(diagnostic_list) do
      table.insert(all_diagnostics, d)
    end
  end
  util.buf_diagnostics_save_positions(bufnr, all_diagnostics)
end

function M.buf_clear_diagnostics(bufnr)
  if bufnr == 0 then
    bufnr = api.nvim_get_current_buf()
  end
  for _, ns in pairs(diagnostic_namespaces) do
    api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  end
  diagnostic_namespaces = {}

  for _, ns in pairs(sign_namespaces) do
    vim.fn.sign_unplace(ns, {buffer = bufnr})
  end
  sign_namespaces = {}
end

function M.publishDiagnostics(_, _, result, client_id)
  if not result then
    return
  end
  local uri = result.uri
  local bufnr = vim.uri_to_bufnr(uri)
  if not bufnr then
    return
  end
  if not api.nvim_buf_is_loaded(bufnr) then
    return
  end

  buf_clear_diagnostics(bufnr, client_id)
  for _, diagnostic in ipairs(result.diagnostics) do
    if diagnostic.severity == nil then
      diagnostic.severity = protocol.DiagnosticSeverity.Error
    end
  end

  save_all_positions(bufnr, client_id, result.diagnostics)
  buf_diagnostics_underline(bufnr, client_id, result.diagnostics)
  buf_diagnostics_virtual_text(bufnr, client_id, result.diagnostics)
  buf_diagnostics_signs(bufnr, client_id, result.diagnostics)
  vim.api.nvim_command('doautocmd User LspDiagnosticsChanged')
end

return M
