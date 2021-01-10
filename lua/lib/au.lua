-- Create augroup
local create_augroups = function(definitions)
    for group_name, definition in pairs(definitions) do
        vim.cmd('augroup ' .. group_name)
        vim.cmd('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
            vim.cmd(command)
        end
        vim.cmd('augroup END')
    end
end

return {create_augroups = create_augroups}
