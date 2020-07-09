local util = require('lib.util')

local M = {}

function M.setup_mappings()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  local global_mappings = {
    -- Save and Quit
    ['Q'] = {':q<CR>--'},
    ['<C-q>'] = {':qa<CR>'},
    ['S'] = {':w<CR>'},
    -- Open vimrc
    ['<LEADER>rc'] = {':e ~/.config/nvim/init.vim<CR>'},
    ['l'] = {'i'},
    ['L'] = {'I'},
    -- Search
    ['<LEADER><CR>'] = {':nohlsearch<CR>'},
    -- Adjacent duplicate words
    ['<LEADER>dw'] = {'^(\\<\\w\\+\\>\\)\\_s*\1'},
    -- Folding
    ['<LEADER>o'] = {'za'},
    -- Open gitui (Rust alternative to lazygit, great)
    ['\\g'] = {':Git'}, -- fugitive
    ['<c-g>'] = {':tabe<CR>:-tabmove<CR>:term gitui<CR>'},
    -- ==
    -- == Cursor Movement (Colemak hnei)
    -- ==
    --     ^
    --     e
    -- < h   i >
    --     n
    --     v
    ['e'] = {'k'},
    ['n'] = {'j'},
    ['i'] = {'l'},
    ['k'] = {'n'},
    ['ge'] = {'gk'},
    ['gn'] = {'gj'},
    ['E'] = {'5k'},
    ['N'] = {'5j'},
    ['H'] = {'0'}, -- H -> go to start of line
    ['I'] = {'$'}, -- I -> go to end of line
    ['W'] = {'5w'},
    ['B'] = {'5b'},
    ['<C-E>'] = {'5<C-y>'}, -- move up page
    ['<C-N>'] = {'5<C-e>'}, -- move down page
    -- ==
    -- == Window management
    -- ==
    -- Use <space> + new arrow keys for moving the cursor around windows
    ['<LEADER>ww'] = {'<C-w>w'},
    ['<LEADER>we'] = {'<C-w>k'},
    ['<LEADER>wn'] = {'<C-w>j'},
    ['<LEADER>wh'] = {'<C-w>h'},
    ['<LEADER>wi'] = {'<C-w>l'},
    -- Disable the default s key
    ['s'] = {'<nop>'},
    -- split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
    ['se'] = {':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>'},
    ['sn'] = {':set splitbelow<CR>:split<CR>'},
    ['sh'] = {':set nosplitright<CR>:vsplit<CR>:set splitright<CR>'},
    ['si'] = {':set splitright<CR>:vsplit<CR>'},
    -- Resize splits with arrow keys
    ['<Leader>w<up>'] = {':res +5<CR>'},
    ['<Leader><down>'] = {':res -5<CR>'},
    ['<Leader><left>'] = {':vertical resize-5<CR>'},
    ['<Leader><right'] = {':vertical resize+5<CR>'},
    ['ss'] = {'<C-w>t<C-w>K'}, -- Place the two screens up and down
    ['sv'] = {'<C-w>t<C-w>H'}, -- Place the two screens side by side
    ['srh'] = {'<C-w>b<C-w>K'}, -- Rotate screens
    ['srv'] = {'<C-w>b<C-w>H'},
    ['<LEADER>q'] = {'<C-w>j:q<CR> '}, -- Press <SPACE> + q to close the window below the current window
    -- ==
    -- == Tab management
    -- ==
    ['tu'] = {':tabe<CR>'},
    ['th'] = {':-tabnext<CR>'},
    ['ti'] = {':+tabnext<CR>'},
    ['tmh'] = {':-tabmove<CR>'},
    ['tmi'] = {':+tabmove<CR>'},
    -- Opening a terminal window
    ['<LEADER>/'] = {':set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>'},
    -- Press space twice to jump to the next '' and edit it
    ['<LEADER><LEADER>'] = {'<Esc>/<++><CR>:nohlsearch<CR>c4l'},
    -- Spelling Check with <space>sc
    ['<LEADER>sc'] = {':set spell!<CR>'},
    -- Press ` to change case (instead of ~)
    ['`'] = {'~'},
    ['<C-c>'] = {'zz'},
    -- Call figlet
    ['tx'] = {':r !figlet'},
    ['<LEADER>-'] = {':lN<CR>'},
    ['<LEADER>='] = {':lne<CR>'},
    -- find and replace
    ['\\s'] = {':%s//g<left><left>'},
    -- set wrap
    ['<LEADER>sw'] = {':set wrap<CR>'},
  }
  util.noremap_key(global_mappings)

  local other_global_mappings = {
    -- Clipboard
    ['nY'] = {'y$', {noremap = true, silent = false}}, -- copy to end of line
    ['vY'] = {'+y', {noremap = true, silent = false}}, -- copy to system clipboard
    -- Indentation
    ['n<'] = {'<<'},
    ['n>'] = {'>>'},
    -- Space to Tab
    ['n<LEADER>tt'] = {':%s/    /\t/g'},
    ['v<LEADER>tt'] = {':s/    /\t/g'},
    -- Insert mode cursor movement
    ['i<C-a>'] = {'<ESC>H'},
    ['i<C-e>'] = {'<ESC>I'},
    -- Command mode cursor movement
    ['c<C-a>'] = {'<Home>'},
    ['c<C-e>'] = {'<End>'},
    ['c<C-p>'] = {'<Up>'},
    ['c<C-n>'] = {'<Down>'},
    ['c<C-b>'] = {'<Left>'},
    ['c<C-f>'] = {'<Right>'},
    ['c<M-b>'] = {'<S-Left>'},
    ['c<M-w>'] = {'<S-Right>'},
    -- Open kitty terminal
    ['n\\t'] = {':tabe<CR>:-tabmove<CR>:term sh -c \'kitty\'<CR><C-\\><C-N>:q<CR>'},
    -- Move next character to the end of the line with ctrl+u
    ['i<C-u>'] = {'<ESC>lx$p'},
    -- Terminal behavior
    ['t<C-N>'] = {'<C-\\><C-N>'},
    ['t<C-O>'] = {'<C-\\><C-N><C-O>'},

  }
  util.bind_key(other_global_mappings)
end

return M
