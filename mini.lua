--- __  ____   __  _   ___     _____ __  __ ____   ____
--- |  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
--- | |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
--- | |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
--- |_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|
---
---  Author: @winwisely268
---  Adapted from @theniceboy, @haorenW1025, @wbthomason, @mfussenegger,
---  @theHamsta configs
-- ==
-- == Neovim init.lua
-- ==
local bind = require('lib.bind')
local as = require('lib.async')

local function setup_global_mappings()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ','
  local global_mappings = {
    -- Open vimrc
    ['Q'] = ':Quit<CR>';
    ['l'] = 'i';
    ['L'] = 'I';
    -- Search
    ['<LEADER><CR>'] = ':set hls! | set hls?<CR>';
    -- ==
    -- == Cursor Movement (Colemak hnei)
    -- ==
    --     ^
    --     e
    -- < h   i >
    --     n
    --     v
    ['e'] = 'k';
    ['n'] = 'j';
    ['i'] = 'l';
    ['k'] = 'n';
    ['ge'] = 'gk';
    ['gn'] = 'gj';
    ['E'] = '5k';
    ['N'] = '5j';
    ['H'] = '0'; -- H -> go to start of line
    ['I'] = '$'; -- I -> go to end of line
    ['W'] = '5w';
    ['B'] = '5b';
    ['<C-E>'] = '5<C-y>'; -- move up page
    ['<C-N>'] = '5<C-e>'; -- move down page
    -- ==
    -- == Window management
    -- ==
    -- split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
    ['<LEADER>se'] = ':<C-u>Split<CR>';
    ['<LEADER>sn'] = ':<C-u>Split<CR>';
    ['<LEADER>sh'] = ':Vsplit<CR>';
    ['<LEADER>si'] = ':Vsplit<CR>';
    -- Resize splits with arrow keys
    ['<LEADER>srh'] = '<C-w>b<C-w>K'; -- Rotate screens
    ['<LEADER>srv'] = '<C-w>b<C-w>H';
    ['<LEADER>q'] = '<C-w>j:q<CR> '; -- Press <SPACE> + q to close the window below the current window
    ['<LEADER>ww'] = [[:<C-u>call VSCodeNotify('workbench.action.focusNextGroup')<CR>]];
    ['<LEADER>wh'] = [[:<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>]];
    ['<LEADER>wn'] = [[:<C-u>call VSCodeNotify('workbench.action.focusBottomGroup')<CR>]];
    ['<LEADER>we'] = [[:<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>]];
    ['<LEADER>wi'] = [[:<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>]];
    ['<LEADER>w>'] = [[:<C-w>+]];
    ['<LEADER>w<'] = [[:<C-w>-]];
    -- ==
    -- == Tab management
    -- ==
    ['<LEADER>tu'] = ':Tabedit ';
    ['<LEADER>th'] = ':Tabnext';
    ['<LEADER>ti'] = ':Tabprevious';
    -- Press ` to change case (instead of ~)
    ['`'] = '~';
    ['<C-c>'] = 'zz';
    ['<LEADER>-'] = ':lN<CR>';
    ['<LEADER>='] = ':lne<CR>';
    -- find and replace
    ['\\s'] = ':%s//g<left><left>';
    -- set wrap
    ['<LEADER>sw'] = ':set wrap<CR>'
  }

  local normal_mappings = {
    -- Clipboard
    ['Y'] = 'y$'; -- copy to end of line
    -- Indentation
    ['<'] = '<<';
    ['>'] = '>>';
    -- Space to Tab
    ['<LEADER>tt'] = ':%s/    /\t/g';
    -- Open kitty terminal
    ['\\t'] = {
      ':tabe<CR>:-tabmove<CR>:term sh -c \'kitty\'<CR><C-\\><C-N>:q<CR>'
    }
  }

  local terminal_mappings = {
    -- Terminal behavior
    ['t<C-N>'] = '<C-\\><C-N>';
    ['t<C-O>'] = '<C-\\><C-N><C-O>'
  }

  local command_mappings = {
    -- Command mode cursor movement
    ['<C-a>'] = '<Home>';
    ['<C-e>'] = '<End>';
    ['<C-p>'] = '<Up>';
    ['<C-n>'] = '<Down>';
    ['<C-b>'] = '<Left>';
    ['<C-f>'] = '<Right>';
    ['<M-b>'] = '<S-Left>';
    ['<M-w>'] = '<S-Right>'
  }
  local bind_allmodes = function()
    for k, v in pairs(global_mappings) do
      bind.map.nov(k, v, {noremap = true})
    end
  end

  local bind_normals = function()
    for k, v in pairs(normal_mappings) do bind.map.n(k, v, {noremap = true}) end
  end

  local bind_inserts = function()
    bind.map.i('<C-a>', '<ESC>H', {noremap = true})
    bind.map.i('<C-e>', '<ESC>I', {noremap = true})
    -- Move next character to the end of the line with ctrl+u
    bind.map.i('<C-u>', '<ESC>lx$p', {noremap = true})
  end

  local bind_terminals = function()
    for k, v in pairs(terminal_mappings) do
      bind.map.t(k, v, {noremap = true})
    end
  end

  local bind_commands = function()
    for k, v in pairs(command_mappings) do bind.map.c(k, v, {noremap = true}) end
  end
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  -- vim.schedule(function()
  bind_allmodes()
  bind_normals()
  bind_inserts()
  bind_terminals()
  bind_commands()
  -- end)
end

local function setup_plugin_mappings()
  local plugin_mappings = {
    ['<LEADER>sga'] = '<Plug>(EasyAlign)';
    -- Vim Sneak
    ['s'] = '<Plug>Sneak_s';
    ['S'] = '<Plug>Sneak_S';
    ['f'] = '<Plug>Sneak_f';
    ['F'] = '<Plug>Sneak_F';
    ['t'] = '<Plug>Sneak_t';
    ['T'] = '<Plug>Sneak_T';
  }
  for k, v in pairs(plugin_mappings) do bind.map.nov(k, v, {noremap = true}) end
end

vim.schedule(function()
-- global mappings
setup_global_mappings()
local go = require('globals.options')
-- global options
go.setup_options()
-- global autocmd
go.setup_global_autocmd()
-- plugin mappings
setup_plugin_mappings()
end)

