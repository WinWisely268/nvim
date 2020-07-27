local icon = require('cosmetics.devicon')
local nvim_lsp = require('nvim_lsp')
local bind = require('lib.bind')

local diagnostic = require('diagnostic')
local completion = require('completion')

-- LSP option
vim.o.completeopt = 'menuone,noinsert,noselect'

-- Global option
local lsp_options = {
  --- LSP
  completion_enable_snippets = 'vim-vsnip';
  completion_trigger_on_delete = 1;
  completion_enable_auto_hover = 1;
  completion_ignore_case = 1;
  completion_chain_complete_list = {
    default = {
      default = {
        {complete_items = {'lsp'; 'snippet'}};
        {complete_items = {'path'}; triggered_only = {'/'}}
      };
      string = {{complete_items = {'path'}; triggered_only = {'/'}}};
      comment = {{complete_items = {'path'}; triggered_only = {'/'}}}
    }
  };
  completion_customize_lsp_label = {
    Function = icon.deviconTable['function'];
    Method = icon.deviconTable['method'];
    Reference = icon.deviconTable['reference'];
    Enum = icon.deviconTable['enum'];
    Field = icon.deviconTable['field'];
    Keyword = icon.deviconTable['keyword'];
    Variable = icon.deviconTable['variable'];
    Folder = icon.deviconTable['folder'];
    Snippet = icon.deviconTable['snippet'];
    Operator = icon.deviconTable['operator'];
    Module = icon.deviconTable['module'];
    Text = icon.deviconTable['text'];
    Class = icon.deviconTable['class'];
    Interface = icon.deviconTable['interface'];
    Constant = icon.deviconTable['constant'];
    Struct = icon.deviconTable['struct']
  }
}

for k, v in pairs(lsp_options) do vim.g[k] = v end

local lsp_mappings = {
  -- Use <Tab> and <S-Tab> to navigate through popup menu
  ['i<Tab>'] = 'pumvisible() ? \'<C-n>\' : \'<Tab>\'';
  ['i<S-Tab>'] = 'pumvisible() ? \'<C-e>\' : \'<S-Tab>\''
}
for k, v in pairs(lsp_mappings) do
  bind.map.i(k, v, {noremap = true; expr = true})
end

local function sign_define()
  vim.fn.sign_define('LspDiagnosticsErrorSign', {
    text = icon.deviconTable['errors'];
    texthl = 'LspDiagnosticsError';
    linehl = ''
  })
  vim.fn.sign_define('LspDiagnosticsWarningSign', {
    text = icon.deviconTable['warnings'];
    texthl = 'LspDiagnosticsWarning';
    linehl = '';
    numhl = ''
  })
  vim.fn.sign_define('LspDiagnosticsInformationSign', {
    text = icon.deviconTable['info'];
    texthl = 'LspDiagnosticsInformation';
    linehl = '';
    numhl = ''
  })
  vim.fn.sign_define('LspDiagnosticsHintSign', {
    text = icon.deviconTable['hints'];
    texthl = 'LspDiagnosticsHint';
    linehl = '';
    numhl = ''
  })
end

local function on_attach(_)
  diagnostic.on_attach()
  completion.on_attach({
    sorting = 'alphabet';
    matching_strategy_list = {'exact'; 'fuzzy'}
  })
  local mapping = {
    ['K'] = ':lua vim.lsp.buf.hover()<CR>';
    ['jv'] = ':lua vim.lsp.util.show_line_diagnostics()<CR>';
    ['je'] = ':PrevDiagnosticCycle<CR>';
    ['jn'] = ':NextDiagnosticCycle<CR>';
    ['ge'] = ':lua vim.lsp.buf.declaration()<CR>';
    ['gd'] = ':lua vim.lsp.buf.definition()<CR>';
    ['gi'] = ':lua vim.lsp.buf.implementation()<CR>';
    ['gl'] = ':lua vim.lsp.buf.signature_help()<CR>';
    ['1gD '] = ':lua vim.lsp.buf.type_definition()<CR>';
    ['gr'] = ':lua vim.lsp.buf.references()<CR>';
    ['gs'] = ':lua vim.lsp.buf.document_symbol()<CR>'
  }
  for k, v in pairs(mapping) do
    bind.map.n(k, v, {noremap = true; buffer = true})
  end
end

local lua_dir = os.getenv('XDG_CACHE_HOME') ..
                  '/nvim/nvim_lsp/sumneko_lua/lua-language-server/'
local lua_bin = lua_dir .. 'bin/linux/lua-language-server'
local lua_main = lua_dir .. 'main.lua'

-- SERVERS
local configs = {
  -- Bash
  bashls = {};
  -- CSS
  cssls = {};
  -- GO
  gopls = {};
  -- Lua
  sumneko_lua = {
    cmd = {lua_bin; '-E'; lua_main};
    settings = {
      Lua = {
        runtime = {version = 'LuaJIT'};
        diagnostics = {
          globals = {
            'vim'; 'c'; 'g'; 's'; 'describe'; 'it'; 'before_each'; 'after_each'
          };
        }
      }
    }
  };
  -- HTML
  html = {};
  -- Rust
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        highlighting = {semanticTokens = false};
        highlightingOn = false;
        rainbowHighlightingOn = false
      }
    }
  };
  -- Vim
  vimls = {}

}

for server, config in pairs(configs) do
  config.on_attach = on_attach
  nvim_lsp[server].setup(config)
end

sign_define()
