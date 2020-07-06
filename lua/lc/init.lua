local vfn = vim.fn
local loop = vim.loop
local lc_opts = require('lc.opts')

local config_dir = vfn.stdpath('config')

local get_local_cmd = function(cmd)
  return string.format('%s/langservers/bin/%s', config_dir, cmd)
end

do
  local if_executable = function(name, cb)
    if vfn.executable(name) == 1 then
      cb()
    end
  end

  local lsp = require('nvim_lsp')
  local vim_node_ls = get_local_cmd('node-lsp')

  if_executable('npx', function()
    lsp.bashls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'bash-language-server'; 'start'};
    }))

    lsp.cssls.setup(
      lc_opts.with_default_opts({cmd = {vim_node_ls; 'css-languageserver'; '--stdio'}}))

    lsp.html.setup(lc_opts.with_default_opts({cmd = {vim_node_ls; 'html-langserver'; '--stdio'}}))

    lsp.jsonls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'vscode-json-languageserver'; '--stdio'};
    }))

    lsp.tsserver.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'typescript-language-server'; '--stdio'};
      filetypes = {'javascript'; 'typescript'; 'typescriptreact'; 'typescript.tsx'};
    }))

    lsp.vimls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'vim-language-server'; '--stdio'};
    }))

    lsp.yamlls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'yaml-language-server'; '--stdio'};
    }))
  end)

  if_executable(get_local_cmd('gopls'), function()
    lsp.gopls.setup(lc_opts.with_default_opts({
      cmd = {get_local_cmd('go-lsp')};
      init_options = {
        deepCompletion = false;
        staticcheck = true;
        analyses = {unusedparams = true; ST1000 = false};
      };
    }))
  end)

  if_executable('dune', function()
    lsp.ocamllsp.setup(lc_opts.with_default_opts({cmd = {get_local_cmd('ocaml-lsp')}}))
  end)

  if_executable('jedi-language-server', function()
    lsp.jedi_language_server.setup(lc_opts.with_default_opts(
                                     {{init_options = {completion = {disableSnippets = true}}}}))
  end)

  local ra = get_local_cmd('rust-analyzer')
  if_executable('ra', function()
    lsp.rust_analyzer.setup(lc_opts.with_default_opts({cmd = {ra}}))
  end)

  local efm = get_local_cmd('efm-langserver')
  if_executable(efm, function()
    local config_file, filetypes = require('lc.efm').gen_config()
    lsp.efm.setup(lc_opts.with_default_opts({
      cmd = {efm; '-c'; config_file};
      filetypes = filetypes;
      root_dir = lc_opts.cwd_root_pattern;
    }))
  end)

  if_executable('ninja', function()
    lsp.sumneko_lua.setup(lc_opts.with_default_opts(
                            {
        cmd = {get_local_cmd('lua-lsp')};
        settings = {
          Lua = {
            runtime = {version = 'LuaJIT'};
            diagnostics = {
              enable = true;
              globals = {
                'vim'; 'describe'; 'it'; 'before_each'; 'after_each'; 'teardown'; 'pending';
              };
            };
          };
        };
      }))
  end)

  local clangd = 'clangd'
  if_executable(clangd, function()
    lsp.clangd.setup(lc_opts.with_default_opts({
      cmd = {clangd; '--background-index'; '--pch-storage=memory'};
    }))
  end)
end
