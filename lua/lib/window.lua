--
-- Floating window
--
local M = {}
local api = vim.api
local au = require('lib.au')

function M.centered(options)
    local cols, lines = (function()
        local ui = api.nvim_list_uis()[1]
        return ui.width, ui.height
    end)()
    local width = math.min(math.floor(cols * options.width), cols - 24)
    local height = math.min(math.floor(lines * options.height), lines - 10)
    local top = ((lines - height) / 2) - 1
    local left = (cols - width) / 2
    return {
        relative = "editor",
        row = top,
        col = left,
        width = width,
        height = height,
        style = "minimal"
    }
end

function M.floating_window(options)
    local win_opts = M.centered(options)
    -- Create border buffer, window
    local border_buf = api.nvim_create_buf(false, true)
    -- Add border lines
    if options.border then
        local border_top = "╭" .. string.rep("─", win_opts.width - 2) ..
                               "╮"
        local border_mid = "│" .. string.rep(" ", win_opts.width - 2) .. "│"
        local border_bot = "╰" .. string.rep("─", win_opts.width - 2) ..
                               "╯"
        local border_lines = {}
        table.insert(border_lines, border_top)
        vim.list_extend(border_lines, vim.split(
                            string.rep(border_mid, win_opts.height - 2, "\n"),
                            "\n"))
        table.insert(border_lines, border_bot)
        api.nvim_buf_set_lines(border_buf, 0, -1, true, border_lines)
    end
    local border_win = api.nvim_open_win(border_buf, true, win_opts)
    -- Create text buffer, window
    win_opts.row = win_opts.row + 1
    win_opts.height = win_opts.height - 2
    win_opts.col = win_opts.col + 2
    win_opts.width = win_opts.width - 4
    local text_buf = api.nvim_create_buf(false, true)
    local text_win = api.nvim_open_win(text_buf, true, win_opts)
    local augroup = {
        floatingAugroup = {
            {
                'WinClosed', '*', string.format(
                    '++once if winnr() == %d | :bd! | endif | call nvim_win_close(%d, v:true)',
                    text_win, border_win)
            }, {'WinClosed', '*', '++once doautocmd BufDelete'}
        }
    }
    au.create_augroups(augroup)
end

return M
