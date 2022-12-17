local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Shorten function name
local nmap = function (keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

-- Shorten function name
local vmap = function (keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end

    vim.keymap.set('v', keys, func, { buffer = bufnr, desc = desc })
end

-- Shorten function name
local xmap = function (keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end

    vim.keymap.set('x', keys, func, { buffer = bufnr, desc = desc })
end

-- Remap space as leader key
nmap('<Space>', '<Nop>', 'Leader key')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Normal --
-- Better window navigation
nmap('<C-h>', '<C-w>h', 'Move to left buffer')
nmap('<C-j>', '<C-w>j', 'Move to lower buffer')
nmap('<C-k>', '<C-w>k', 'Move to upper buffer')
nmap('<C-l>', '<C-w>l', 'Move to right buffer')

-- NvimTreeToggle
nmap('<leader>e', ':NvimTreeToggle<cr>', 'Toggle NvimTree')

-- Show all characters
nmap('<leader>c', ':set list!<cr>', 'Toggle display of all characters')

-- Resize with arrows
nmap('<C-Up>',    ':resize +2<CR>',          'Grow buffer horizontally')
nmap('<C-Down>',  ':resize -2<CR>',          'Shrink buffer horizontally')
nmap('<C-Left>',  ':vertical resize -2<CR>', 'Shrink buffer vertically')
nmap('<C-Right>', ':vertical resize +2<CR>', 'Grow buffer vertically')

-- Navigate buffers
nmap('<A-l>', ':bnext<CR>',     'Move to next buffer')
nmap('<A-h>', ':bprevious<CR>', 'Move to previous buffer')

-- Hristo's mappings
nmap('gg',        'gg0',                'Go to first character in buffer')
nmap('G',         'G0',                 'Go to first character in last line in buffer')
nmap('Q',         '<nop>',              'Disable Ex mode')
nmap('n',         'nzz',                'Navigate to next search match and center screen')
nmap('N',         'Nzz',                'Navigate to previous search match and center screen')
nmap('<leader>w', ':w<cr>',             'Save file')
nmap('<leader>q', ':q!<cr>',            'Quit file without saving')
nmap('<leader>x', ':x<cr>',             'Save and quit file')
nmap('<leader>s', ':set hlsearch!<cr>', 'Toggle search highlighting')

-- Visual --
-- Stay in indent mode
vmap('<', '<gv', 'Left indent')
vmap('>', '>gv', 'Right indent')

-- Visual Block --
-- Move text up and down
xmap('J', ":move '>+1<CR>gv-gv", 'Move line down one line')
xmap('K', ":move '<-2<CR>gv-gv", 'Move line up one line')
vmap('p', '"_dP',                'Paste without overwriting register')

-- TELESCOPE
nmap('<leader>sb',  require('telescope.builtin').buffers,                   'Search buffers')
nmap('<leader>sf',  require('telescope.builtin').find_files,                'Search file')
nmap('<leader>sg',  require('telescope.builtin').live_grep,                 'Search string')
nmap('<leader>?',  require('telescope.builtin').oldfiles,                  'Search recently opened files')
nmap('<leader>/',  require('telescope.builtin').current_buffer_fuzzy_find, 'Search in current buffer')
nmap('<leader>sd', require('telescope.builtin').diagnostics,               'Search diagnostics')

-- NVIM-DAP
nmap('<F6>',       ':lua require("dap").toggle_breakpoint()<CR>',                     'Toggle breakpoint')
nmap('<F7>',       ':lua require("dap").step_into()<CR>',                             'Step into')
nmap('<F8>',       ':lua require("dap").step_over()<CR>',                             'Step over')
nmap('<F10>',      ':lua require("dap").step_out()<CR>',                              'Step out')
nmap('<F9>',       ':lua require("dap").continue()<CR>',                              'Continue')
nmap('<leader>dk', ':lua require("dap").down()<CR>',                                  'Move to lower stack frame')
nmap('<leader>dj', ':lua require("dap").up()<CR>',                                    'Move to upper stack frame')
nmap('<leader>dt', ':lua require("dap").terminate()<CR>',                             'Terminate')
nmap('<leader>dr', ':lua require("dap").repl_open({}, "vsplit")<CR>',                 'Open REPL in new buffer')
nmap('<leader>df', ':lua require("dapui").float_element("scopes", {enter=true})<CR>', 'Floating window for variables in scope')

-- tree hopper
nmap('<leader>h', ':lua require("tsht").nodes()<CR>', 'Hop node trees')
