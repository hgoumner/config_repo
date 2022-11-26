local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- NvimTreeToggle
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Show all characters
keymap("n", "<leader>c", ":set list!<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-l>", ":bnext<CR>", opts)
keymap("n", "<A-h>", ":bprevious<CR>", opts)

-- Hristo's mappings
keymap("n", "gg", "gg0", opts)
keymap("n", "G", "G0", opts)
keymap("n", "Q", "<nop>", opts)
keymap("n", "<leader>w", ":w<cr>", opts)
keymap("n", "<leader>q", ":q!<cr>", opts)
keymap("n", "<leader>x", ":x<cr>", opts)
keymap("n", "<leader>s", ":set hlsearch!<cr>", opts)
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- TELESCOPE
-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown())<cr>", opts)
keymap("n", "<leader>b", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>g", "<cmd>Telescope live_grep<cr>", opts)

-- NVIM-DAP
keymap("n", "<F6>", ":lua require('dap').toggle_breakpoint()<CR>", opts)
keymap("n", "<F7>", ":lua require('dap').step_into()<CR>", opts)
keymap("n", "<F8>", ":lua require('dap').step_over()<CR>", opts)
keymap("n", "<F10>", ":lua require('dap').step_out()<CR>", opts)
keymap("n", "<F9>", ":lua require('dap').continue()<CR>", opts)
keymap("n", "<leader>dt", ":lua require('dap').terminate()<CR>", opts)
keymap("n", "<leader>dr", ":lua require('dap').repl_open({}, 'vsplit')<CR>", opts)

-- tree hopper
keymap("n", "<leader>h", ":lua require('tsht').nodes()<CR>", opts)
