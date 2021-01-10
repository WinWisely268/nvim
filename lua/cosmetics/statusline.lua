local icons = require('cosmetics.devicon')
local status_ok, el = pcall(require, 'el')
if status_ok then
    local el_segments = {}
    local el_sect = require('el.sections')
    local el_subscribe = require('el.subscribe')
    local el_helper = require('el.helper')
    local el_builtin = require('el.builtin')
    local luvjob = require('luvjob')
    ------------------------------------------------------------------------
    -- StatusLine                             --
    ------------------------------------------------------------------------
    -- Mode Prompt Table
    local modes = {
        n = {' Ⓝ ', 'N', 'NormalMode'},
        no = {' Ⓝ .Ⓞ Ⓟ  ', '?', 'OpPending'},
        v = {' Ⓥ ', 'V', 'VisualMode'},
        V = {' Ⓥ Ⓛ ', 'Vl', 'VisualLineMode'},
        [''] = {'  Ⓥ Ⓑ', 'Vb'},
        s = {' Ⓢ ', 'S'},
        S = {' Ⓢ Ⓛ ', 'Sl'},
        [''] = {' Ⓢ Ⓑ ', 'Sb'},
        i = {' Ⓘ ', 'I', 'InsertMode'},
        ic = {' Ⓘ Ⓒ ', 'Ic', 'ComplMode'},
        R = {' Ⓡ ⓟ ', 'R', 'ReplaceMode'},
        Rv = {' Ⓡ Ⓥ ', 'Rv'},
        c = {' Ⓒ ', 'C', 'CommandMode'},
        cv = {' Ⓥ .Ⓔ ⓧ ', 'E'},
        ce = {' Ⓔ ⓧ ', 'E'},
        r = {' Ⓟ ', 'P'},
        rm = {' Ⓜ ', 'M'},
        ['r?'] = {' Ⓒ ⓝ ', 'Cn'},
        ['!'] = {' Ⓢ ⓗ  ', 'S'},
        t = {' Ⓣ ', 'T', 'TerminalMode'}
    }

    local mode_highlights = {
        n = 'ElNormal',
        no = 'ElNormalOperatorPending',
        v = 'ElVisual',
        V = 'ElVisualLine',
        [''] = 'ElVisualBlock',
        s = 'ElSelect',
        S = 'ElSLine',
        [''] = 'ElSBlock',
        i = 'ElInsert',
        ic = 'ElInsertCompletion',
        R = 'ElReplace',
        Rv = 'ElVirtualReplace',
        c = 'ElCommand',
        cv = 'ElCommandCV',
        ce = 'ElCommandEx',
        r = 'ElPrompt',
        rm = 'ElMore',
        ['r?'] = 'ElConfirm',
        ['!'] = 'ElShell',
        t = 'ElTerm'
    }

    local separator_highlights = {
        n = 'ElNormalSep',
        no = 'ElNormalSep',
        v = 'ElVisualSep',
        V = 'ElVisualSep',
        [''] = 'ElVisualSep',
        s = 'ElSelectSep',
        S = 'ElSelectSep',
        [''] = 'ElSelectSep',
        i = 'ElInsertSep',
        ic = 'ElInsertSep',
        R = 'ElReplaceSep',
        Rv = 'ElReplaceSep',
        c = 'ElCommandSep',
        cv = 'ElCommandSep',
        ce = 'ElCommandSep',
        r = 'ElPromptSep',
        rm = 'ElPromptSep',
        ['r?'] = 'ElPromptSep',
        ['!'] = 'ElTermSep',
        t = 'ElTermSep'
    }

    -- ==
    -- == Mode segment
    -- ==
    local set_mode = function(_, _)
        local mode = vim.api.nvim_get_mode().mode
        local higroup = mode_highlights[mode]
        local display_name = modes[mode][1]
        return el_sect.highlight(higroup, display_name)
    end
    --
    local set_mode_sep = function(_, _)
        local mode = vim.api.nvim_get_mode().mode
        local higroup = separator_highlights[mode]
        return el_sect.highlight(higroup, icons.deviconTable['right_separator'])
    end
    --
    table.insert(el_segments, set_mode())
    table.insert(el_segments, set_mode_sep())
    table.insert(el_segments, icons.deviconTable['blanks'])

    -- ==
    -- == File Name
    -- ==
    table.insert(el_segments, el_builtin.shortened_file)
    table.insert(el_segments, icons.deviconTable['blanks'])

    -- ==
    -- == Git Branch
    -- ==
    local git_branch = function(_, _)
        local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):sub(0,
                                                                            -2)
        local not_git = branch:match('fatal')

        if not_git then return '' end

        return '%#StGitBranch#' .. icons.deviconTable['git_branch'] ..
                   icons.deviconTable['blanks'] .. branch
    end

    table.insert(el_segments, el_subscribe.buf_autocmd('el_git_branch',
                                                       'BufWinEnter', git_branch))
    table.insert(el_segments, icons.deviconTable['blanks'])

    -- ==
    -- == Git Summary
    -- ==
    local git_changed = vim.regex([[\(\d\+\)\( file changed\)\@=]])
    local git_insertions = vim.regex([[\(\d\+\)\( insertions\)\@=]])
    local git_deletions = vim.regex([[\(\d\+\)\( deletions\)\@=]])

    local parse_shortstat_output = function(s)
        local result = {}

        local changed = {git_changed:match_str(s)}
        if not vim.tbl_isempty(changed) then
            changed = '%#SignifySignChange# +' ..
                          string.sub(s, changed[1] + 1, changed[2])
            table.insert(result, changed)
        end

        local insert = {git_insertions:match_str(s)}
        if not vim.tbl_isempty(insert) then
            local added = '%#SignifySignAdd# ~' ..
                              string.sub(s, insert[1] + 1, insert[2])
            table.insert(result, added)
        end

        local delete = {git_deletions:match_str(s)}
        if not vim.tbl_isempty(delete) then
            local deleted = '%#SignifySignDelete# -' ..
                                string.sub(s, delete[1] + 1, delete[2])
            table.insert(result, deleted)
        end

        if vim.tbl_isempty(result) then return nil end

        return result[1] and result[2] and result[3] and '%#StGitBranch#[' ..
                   result[1] .. result[2] .. result[3] .. ' %#StGitBranch#]' or
                   ''
    end

    local git_changes = function(_, buffer)
        local buftype = vim.api.nvim_buf_get_option(buffer.bufnr, 'buftype')
        if vim.api.nvim_buf_get_option(buffer.bufnr, 'bufhidden') ~= '' or
            buftype == 'nofile' or buftype == 'terminal' then return end

        local j = luvjob:new({
            command = 'git',
            args = {'diff', '--shortstat', buffer.name},
            cwd = vim.fn.fnamemodify(buffer.name, ':h')
        })

        local ok, result = pcall(function()
            return
                parse_shortstat_output(vim.trim(j:start():wait()._raw_output))
        end)

        if ok then return result end

        return ''
    end

    table.insert(el_segments, el_helper.async_buf_setter(win_id, 'el_git_stat',
                                                         git_changes, 3000))
    table.insert(el_segments, '%=')

    -- ==
    -- == LSP function
    -- ==
    -- local get_lsp_func = function(_, _)
    --   local lsp_function = vim.b.lsp_current_function
    --   if lsp_function ~= nil then
    --     return '%#StFunctionIndicator#' .. icons.deviconTable['func'] ..
    --              ' %#StFunctionName#' .. lsp_function
    --   end
    --   return ''
    -- end
    -- table.insert(el_segments, get_lsp_func)
    -- table.insert(el_segments, icons.deviconTable['blanks'])
    -- table.insert(el_segments, icons.deviconTable['blanks'])

    -- ==
    -- == LSP Diagnostic Status
    -- ==
    local function get_all_diagnostics(bufnr)
        local result = {}
        local levels = {
            errors = 'Error',
            warnings = 'Warning',
            info = 'Information',
            hints = 'Hint'
        }

        for k, level in pairs(levels) do
            result[k] = vim.lsp.diagnostic.get_count(bufnr, level)
        end

        return result
    end
    ---------
    local function diag_status(bufnr)
        bufnr = bufnr or 0
        if #vim.lsp.buf_get_clients(bufnr) == 0 then return '' end
        local buf_diagnostics = get_all_diagnostics(bufnr)
        local parts = {}
        if buf_diagnostics.errors and buf_diagnostics.errors > 0 then
            table.insert(parts,
                         '%#LspDiagnosticsError#' ..
                             icons.deviconTable['errors'] ..
                             buf_diagnostics.errors .. ' ')
        end
        if buf_diagnostics.warnings and buf_diagnostics.warnings > 0 then
            table.insert(parts,
                         '%#LspDiagnosticsWarning#' ..
                             icons.deviconTable['warnings'] ..
                             buf_diagnostics.warnings .. ' ')
        end
        if buf_diagnostics.hints and buf_diagnostics.hints > 0 then
            table.insert(parts,
                         '%#LspDiagnosticsHint#' .. icons.deviconTable['hints'] ..
                             buf_diagnostics.hints .. ' ')
        end
        if buf_diagnostics.info and buf_diagnostics.info > 0 then
            table.insert(parts,
                         '%#LspDiagnosticsInfo#' .. icons.deviconTable['info'] ..
                             buf_diagnostics.info .. ' ')
        end
        local errors = parts[1] and parts[1] ~= '' and parts[1] or ''
        local warnings = parts[2] and parts[2] ~= '' and parts[2] or ''
        local hints = parts[3] and parts[3] ~= '' and parts[3] or ''
        local infos = parts[4] and parts[4] ~= '' and parts[4] or ''
        return errors .. warnings .. hints .. infos
    end

    local dstatus = function(_, buffer)
        local ds = diag_status(buffer.bufnr)
        return ds ~= '' and ds or ''
    end

    table.insert(el_segments, dstatus)
    table.insert(el_segments, icons.deviconTable['blanks'])
    ------

    -- ==
    -- == Builtin lines and columns
    -- ==
    local line_function = function(_, _)
        local line = vim.api.nvim_call_function('line', {'.'})
        local col = vim.fn.col('.')
        while string.len(line) < 3 do line = line .. ' ' end
        while string.len(col) < 3 do col = col .. ' ' end
        return '%#StLine# ' .. icons.deviconTable['linum'] .. line ..
                   icons.deviconTable['column'] .. col
    end

    table.insert(el_segments, line_function)

    local set_status = function() return el_segments end

    -- return el.set_statusline_generator(set_status)
    el.setup {generator = set_status}
end
