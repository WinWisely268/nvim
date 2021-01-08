local vcmd = vim.cmd

local config_path = vim.api.nvim_call_function('stdpath', { 'config' }):gsub('\\',
    '/')

local root = function()
    return vim.api.nvim_call_function('stdpath', { 'data' }):gsub('\\', '/') ..
            '/site/pack/packer'
end

local download = function()
    local path = root() .. '/opt/packer.nvim/'
    local url = 'https://github.com/wbthomason/packer.nvim'
    if vim.api.nvim_call_function('filereadable', { path .. 'LICENSE' }) ~= 1 then
        vim.api.nvim_command(string.format('!git clone %q %q', url, path))
    end
end

local create_machine_specific_file = function()
    local specific_file_path = vim.api.nvim_call_function('filereadable', {
        config_path .. '/machine_specific.vim'
    })
    if specific_file_path ~= 1 then
        vim.api.nvim_command(string.format('!cp %q %q', config_path ..
                '/_machine_specific.vim.example',
            config_path .. '/machine_specific.vim'))
    end
    vcmd([[source ]] .. config_path .. '/machine_specific.vim')
end

local function loadpkg(pkg) return vcmd('packadd ' .. pkg) end

local function load_extras()
    -- ==
    -- == Load optional packages when vscode-neovim is not active.
    local extra_pkgs = {
        'vim-signify'; -- git
        'completion-nvim'; 'diagnostic-nvim'; -- LSP Stuff
        'vim-vsnip'; 'vim-vsnip-integ'; -- snippets
        'nvim-lspconfig'; -- builtin LSP
        'nvim-colorizer.lua'; -- fastest colorizer
        'plenary.nvim';
        'luvjob.nvim'; -- lib uv job
        'express_line.nvim' -- expressline
    }
    for _, pkg in ipairs(extra_pkgs) do loadpkg(pkg) end
end

local setup = function()
    download()
    create_machine_specific_file()
    require('plugin.pkgs')
    if vim.g.vscode == nil then
        load_extras()
        --        vcmd [[packadd! nvim-treesitter]]
    end
end

return {
    setup = setup;
    download = download;
    create_machine_specific_file = create_machine_specific_file;
    loadpkg = loadpkg;
    root = root;
}
