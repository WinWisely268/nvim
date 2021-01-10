local plugins = require('plugin.init')

do
    local all_installed = false
    local hererocks_done = false

    plugins.download()
    plugins.create_machine_specific_file()
    local done_processing_pkgs = 0
    local done_compiling_pkgs = 0
    vim.schedule(function()
        require('plugin.pkgs')
        done_processing_pkgs = 1
        print('done loading packages')
    end)
    if done_processing_pkgs then
        vim.schedule(function()
            vim.cmd('PackerInstall')
            vim.cmd('PackerCompile')
            done_compiling_pkgs = true
            all_installed = true
            print('all packages installed')
        end)
        if all_installed then
            vim.schedule(function()

                local nrock = require('plenary.neorocks')
                nrock.setup_hererocks()
                nrock.ensure_installed('luacheck')
                nrock.ensure_installed(
                    '--server=https://luarocks.org/dev luaformatter')
                hererocks_done = true
            end)
        end
    end
    vim.wait(5000, function()
        return all_installed and done_compiling_pkgs and hererocks_done
    end, 25)
end
