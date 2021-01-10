-- shfmt
local shfmt_func = function()
	return {
		exe = 'shfmt',
		args = {'-s', '-ln', 'posix'}
	}
end
-- luafmt
local luafmt_func = function()
    return {
        exe = "lua-format",
        -- args = {"--indent-count", 2, "--stdin"},
        stdin = true
    }
end
local rustfmt_func = function()
    return {exe = "rustfmt", args = {"--emit=stdout", '--edition=2018'}, stdin = true}
end

local prettier_func = function()
    return {
        exe = "prettier",
        args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'
        },
        stdin = true
    }
end

require('formatter').setup({
    logging = false,
    filetype = {
        javascript = {prettier_func},
        javascriptreact = {prettier_func},
        typescript = {prettier_func},
        typescriptreact = {prettier_func},
        yaml = {prettier_func},
        markdown = {prettier_func},
        json = {prettier_func},
        bash = {shfmt_func},
				sh = {shfmt_func},
        rust = {rustfmt_func},
        lua = {luafmt_func}
    }
})


