local nvim_lsp = require('nvim_lsp')
local diagnostic = require('diagnostic')
local completion = require('completion')
local util = require('lib.util')
local lsp_status = require('lsp-status')

local M = {}

function M.setup_lsp_cfg()
  -- LSP option
  vim.cmd('set completeopt=menuone,noinsert,noselect')
  vim.cmd('set shortmess+=c')

  local lsp_options = {
    --- LSP
    completion_enable_snippets = 'vim-vsnip',
    completion_trigger_on_delete = 1,
    completion_enable_auto_hover = 1,
    completion_ignore_case = 1,
    completion_chain_complete_list = {
      default = {
        {complete_items = {'lsp', 'snippets'}},
        {complete_items = {{'path'}, {triggered_only = {'/'}}}}, {complete_items = {'buffers'}},
      },
      typescript = {{complete_items = {'lsp'}}, {complete_items = {'buffers'}}},
      javascript = {{complete_items = {'lsp'}}, {complete_items = {'buffers'}}},
      markdown = {{mode = 'spel'}},
    },
  }

  for k, v in pairs(lsp_options) do
    vim.g[k] = v
  end

  local lsp_mappings = {
    -- Use <Tab> and <S-Tab> to navigate through popup menu
    ['i<Tab>'] = {'pumvisible() ? \'<C-n>\' : \'<Tab>\'', {noremap = true, expr = true}},
    ['i<S-Tab>'] = {'pumvisible() ? \'<C-e>\' : \'<S-Tab>\'', {noremap = true, expr = true}},
  }
  util.bind_key(lsp_mappings)

  local function sign_define()
    vim.fn.sign_define('LspDiagnosticsErrorSign',
                       {text = '✗', texthl = 'LspDiagnosticsError', linehl = ''})
    vim.fn.sign_define('LspDiagnosticsWarningSign',
                       {text = '❗', texthl = 'LspDiagnosticsWarning', linehl = '', numhl = ''})
    vim.fn.sign_define('LspDiagnosticsInformationSign', {
      text = 'ℹ',
      texthl = 'LspDiagnosticsInformation',
      linehl = '',
      numhl = '',
    })
    vim.fn.sign_define('LspDiagnosticsHintSign',
                       {text = '', texthl = 'LspDiagnosticsHint', linehl = '', numhl = ''})
  end

  local function on_attach(client)
    diagnostic.on_attach()
    completion.on_attach({sorter = 'alphabet', matcher = {'exact', 'fuzzy'}})
    lsp_status.on_attach(client)
    local mapping = {
      ['nK'] = {':lua vim.lsp.buf.hover()<CR>'},
      ['njv'] = {':lua vim.lsp.util.show_line_diagnostics()<CR>'},
      ['nje'] = {':PrevDiagnosticCycle<CR>'},
      ['njn'] = {':NextDiagnosticCycle<CR>'},
      ['njd'] = {':lua require(\'lib.loclist\').toggle()<CR>'},
      ['nge'] = {':lua vim.lsp.buf.declaration()<CR>'},
      ['ngd'] = {':lua vim.lsp.buf.definition()<CR>'},
      ['ngi'] = {':lua vim.lsp.buf.implementation()<CR>'},
      ['ngl'] = {':lua vim.lsp.buf.signature_help()<CR>'},
      ['n1gD '] = {':lua vim.lsp.buf.type_definition()<CR>'},
      ['ngr'] = {':lua vim.lsp.buf.references()<CR>'},
      ['ngs'] = {':lua vim.lsp.buf.document_symbol()<CR>'},
    }
    util.bind_key(mapping)
  end

  local lua_dir = os.getenv('XDG_CACHE_HOME') .. '/nvim/nvim_lsp/sumneko_lua/lua-language-server/'
  local lua_bin = lua_dir .. 'bin/linux/lua-language-server'
  local lua_main = lua_dir .. 'main.lua'

  -- SERVERS
  local configs = {
    -- Bash
    bashls = {},
    -- CSS
    cssls = {},
    -- GO
    gopls = {},
    -- Lua
    sumneko_lua = {
      cmd = {lua_bin, '-E', lua_main},
      settings = {
        Lua = {
          runtime = {version = 'LuaJIT'},
          diagnostics = {
            globals = {
              'vim', 'Color', 'c', 'Group', 'g', 's', 'describe', 'it', 'before_each',
              'after_each',
            },
            disable = {'redefined-local'},
          },
        },
      },
    },
    -- HTML
    html = {},
    -- Rust
    rust_analyzer = {
      settings = {
        ['rust-analyzer'] = {
          highlighting = {semanticTokens = true},
          highlightingOn = true,
          rainbowHighlightingOn = true,
        },
      },
    },
    -- Python MS
    pyls_ms = {cmd = {'pyls_ms'}},
    -- Typescript
    tsserver = {},
    -- Vue
    vuels = {},
    -- Vim
    vimls = {},
  }

  for server, config in pairs(configs) do
    config.on_attach = on_attach
    nvim_lsp[server].setup(config)
  end

  sign_define()
end

return M
