" Automatically generated packer.nvim plugin loader code

lua << END
local plugins = {
  ["completion-nvim"] = {
    load_after = {
      ["nvim-lsp"] = true
    },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/completion-nvim"
  },
  ["diagnostic-nvim"] = {
    load_after = {
      ["nvim-lsp"] = true
    },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/diagnostic-nvim"
  },
  ["expressline.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/expressline.nvim"
  },
  ["findr.vim"] = {
    commands = { "Findr", "FindrLocList" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/findr.vim"
  },
  firenvim = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/firenvim"
  },
  ["fzf.vim"] = {
    commands = { "Files", "Rg", "History", "Commands", "Help", "Lines", "Buffers", "Commits", "Tags", "BTags" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/fzf.vim"
  },
  ["git-messenger.vim"] = {
    commands = { "GitMessenger" },
    keys = { { "", "(gitmessenger" } },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/git-messenger.vim"
  },
  ["luvjob.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/luvjob.nvim"
  },
  neoformat = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/neoformat"
  },
  ["nvim-colorizer.lua"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-lsp"] = {
    after = { "vim-vsnip", "diagnostic-nvim", "vim-vsnip-integ", "completion-nvim" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/nvim-lsp"
  },
  ["nvim-luadev"] = {
    commands = { "Luadev" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/nvim-luadev"
  },
  ["nvim-treesitter"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/plenary.nvim"
  },
  ["vim-go"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/vim-go"
  },
  ["vim-markdown-composer"] = {
    commands = { "ComposerStart", "ComposerUpdate", "ComposerOpen" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/vim-markdown-composer"
  },
  ["vim-mundo"] = {
    commands = { "MundoToggle" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/vim-mundo"
  },
  ["vim-signify"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/vim-signify"
  },
  ["vim-table-mode"] = {
    commands = { "TableModeToggle" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/vim-table-mode"
  },
  ["vim-vsnip"] = {
    load_after = {
      ["nvim-lsp"] = true
    },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    load_after = {
      ["nvim-lsp"] = true
    },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  },
  vimtex = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/vimtex"
  },
  ["vista.vim"] = {
    commands = { "Vista" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/vista.vim"
  },
  ["wiki.vim"] = {
    commands = { "WikiJournal", "WikiOpen", "WikiFzfPages", "WikiFzfToc", "WikiEnable", "WikiIndex", "WikiFzfTags" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/alex/.local/share/nvim/site/pack/packer/opt/wiki.vim"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

_packer_load = nil

local function handle_after(name, before)
  local plugin = plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    _packer_load({name}, {})
  end
end

_packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if plugins[name].commands then
      for _, cmd in ipairs(plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if plugins[name].keys then
      for _, key in ipairs(plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      vim._update_package_paths()
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    -- NOTE: I'm not sure if the below substitution is correct; it might correspond to the literal
    -- characters \<Plug> rather than the special <Plug> key.
    vim.fn.feedkeys(string.gsub(cause.keys, '^<Plug>', '\\<Plug>') .. extra)
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Pre-load configuration
-- Post-load configuration
-- Conditional loads
vim._update_package_paths()
END

function! s:load(names, cause) abort
  call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction

" Runtimepath customization

" Load plugins in order defined by `after`

" Command lazy-loads
command! -nargs=* -range -bang -complete=file TableModeToggle call s:load(['vim-table-mode'], { "cmd": "TableModeToggle", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file MundoToggle call s:load(['vim-mundo'], { "cmd": "MundoToggle", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file ComposerOpen call s:load(['vim-markdown-composer'], { "cmd": "ComposerOpen", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file WikiIndex call s:load(['wiki.vim'], { "cmd": "WikiIndex", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Findr call s:load(['findr.vim'], { "cmd": "Findr", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file WikiOpen call s:load(['wiki.vim'], { "cmd": "WikiOpen", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Vista call s:load(['vista.vim'], { "cmd": "Vista", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Commits call s:load(['fzf.vim'], { "cmd": "Commits", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file WikiFzfTags call s:load(['wiki.vim'], { "cmd": "WikiFzfTags", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Lines call s:load(['fzf.vim'], { "cmd": "Lines", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file WikiFzfToc call s:load(['wiki.vim'], { "cmd": "WikiFzfToc", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file WikiEnable call s:load(['wiki.vim'], { "cmd": "WikiEnable", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file WikiFzfPages call s:load(['wiki.vim'], { "cmd": "WikiFzfPages", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file FindrLocList call s:load(['findr.vim'], { "cmd": "FindrLocList", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file WikiJournal call s:load(['wiki.vim'], { "cmd": "WikiJournal", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Tags call s:load(['fzf.vim'], { "cmd": "Tags", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Luadev call s:load(['nvim-luadev'], { "cmd": "Luadev", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Rg call s:load(['fzf.vim'], { "cmd": "Rg", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Files call s:load(['fzf.vim'], { "cmd": "Files", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file ComposerStart call s:load(['vim-markdown-composer'], { "cmd": "ComposerStart", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Commands call s:load(['fzf.vim'], { "cmd": "Commands", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file BTags call s:load(['fzf.vim'], { "cmd": "BTags", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file ComposerUpdate call s:load(['vim-markdown-composer'], { "cmd": "ComposerUpdate", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Help call s:load(['fzf.vim'], { "cmd": "Help", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file GitMessenger call s:load(['git-messenger.vim'], { "cmd": "GitMessenger", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Buffers call s:load(['fzf.vim'], { "cmd": "Buffers", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file History call s:load(['fzf.vim'], { "cmd": "History", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })

" Keymap lazy-loads
noremap <silent> (gitmessenger <cmd>call <SID>load(['git-messenger.vim'], { "keys": "(gitmessenger", "prefix": "" })<cr>

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType lua ++once call s:load(['neoformat'], { "ft": "lua" })
  au FileType html ++once call s:load(['neoformat'], { "ft": "html" })
  au FileType fish ++once call s:load(['neoformat'], { "ft": "fish" })
  au FileType go ++once call s:load(['vim-go'], { "ft": "go" })
  au FileType xml ++once call s:load(['neoformat'], { "ft": "xml" })
  au FileType c ++once call s:load(['neoformat'], { "ft": "c" })
  au FileType json ++once call s:load(['neoformat'], { "ft": "json" })
  au FileType wiki ++once call s:load(['vim-table-mode'], { "ft": "wiki" })
  au FileType markdown ++once call s:load(['neoformat'], { "ft": "markdown" })
  au FileType md ++once call s:load(['vim-table-mode'], { "ft": "md" })
  au FileType rust ++once call s:load(['neoformat'], { "ft": "rust" })
  au FileType yaml ++once call s:load(['neoformat'], { "ft": "yaml" })
  au FileType tex ++once call s:load(['vimtex'], { "ft": "tex" })
  " Event lazy-loads
  au BufReadPre ~/Notes/**/*.md ++once call s:load(['wiki.vim'], { "event": "BufReadPre ~/Notes/**/*.md" })
  au BufNewFile ~/Notes/**/*.md ++once call s:load(['wiki.vim'], { "event": "BufNewFile ~/Notes/**/*.md" })
augroup END
