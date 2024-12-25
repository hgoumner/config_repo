-- This file contains all the keymap settings, except for some plugin specific
-- keymaps from plugin configs

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Shorten function name
local imap = function(keys, func, desc)
	vim.keymap.set("i", keys, func, { buffer = bufnr, noremap = true, desc = desc })
end

-- Shorten function name
local nmap = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, desc = desc })
end

-- Shorten function name
local vmap = function(keys, func, desc)
	vim.keymap.set("v", keys, func, { buffer = bufnr, noremap = true, desc = desc })
end

-- Shorten function name
local xmap = function(keys, func, desc)
	vim.keymap.set("x", keys, func, { buffer = bufnr, noremap = true, desc = desc })
end

-- Remap space as leader key
nmap("<Space>", "<Nop>", "Leader key")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Hristo's mappings
-- NORMAL --
nmap("gg", "gg0", "Go to first character in buffer")
nmap("G", "G0", "Go to first character in last line in buffer")
-- nmap('Q',          '<nop>',                         'Disable Ex mode')
nmap("n", "nzz", "Navigate to next search match and center screen")
nmap("N", "Nzz", "Navigate to previous search match and center screen")
nmap("#", "#zz", "Navigate to previous search match and center screen")
nmap("*", "*zz", "Navigate to previous search match and center screen")
nmap("<leader>bd", "<CMD>bd!<CR>", "Close buffer")
nmap("<leader>c", "<CMD>set list!<CR>", "Toggle display of all characters")
nmap("<leader>co", "<CMD>copen<CR>", "Open QuickFix list")
nmap("<leader>cc", "<CMD>cclose<CR>", "Close QuickFix list")
nmap("<leader>cl", "<CMD>%s/\\s\\+$//g<CR>", "Remove spaces in blank lines or trailing spaces")
nmap("<leader>h", "<CMD>set hlsearch!<CR>", "Toggle search highlighting")
nmap("<leader>p", '<CMD>let @+=expand("%:p")<CR>', "Copy full filename to clipboard")
nmap("<leader>q", "<CMD>q!<CR>", "Quit file without saving")
nmap("<leader>w", "<CMD>w!<CR>", "Save file")
nmap("<leader>x", "<CMD>x!<CR>", "Save and quit file")

-- Navigate buffers
nmap("<A-l>", "<CMD>bnext<CR>", "Move to next buffer")
nmap("<A-h>", "<CMD>bprevious<CR>", "Move to previous buffer")

-- Resize with arrows
nmap("<C-Up>", "<CMD>resize +2<CR>", "Grow buffer horizontally")
nmap("<C-Down>", "<CMD>resize -2<CR>", "Shrink buffer horizontally")
nmap("<C-Left>", "<CMD>vertical resize -2<CR>", "Shrink buffer vertically")
nmap("<C-Right>", "<CMD>vertical resize +2<CR>", "Grow buffer vertically")

-- Better window navigation
nmap("<C-h>", "<C-w>h", "Move to left buffer")
nmap("<C-j>", "<C-w>j", "Move to lower buffer")
nmap("<C-k>", "<C-w>k", "Move to upper buffer")
nmap("<C-l>", "<C-w>l", "Move to right buffer")

-- VISUAL --
-- Stay in indent mode
vmap("<", "<gv", "Left indent")
vmap(">", ">gv", "Right indent")

-- Vimgrep --
nmap("<leader>v", "<CMD>vimgrep <cword> % | copen<CR>", "Search in current buffer and open QuickFix list")

-- VISUAL BLOCK --
-- Move text up and down
xmap("<A-j>", "<CMD>move '>+1<CR>gv=gv", "Move line down one line")
xmap("<A-k>", "<CMD>move '<-2<CR>gv=gv", "Move line up one line")
vmap("p", '"_dP', "Paste without overwriting register")

-- Plugins --
-- TELESCOPE --
nmap("<leader>k", "<CMD>Telescope keymaps<CR>", "Search keymaps")
nmap("<leader>b", "<CMD>Telescope buffers<CR>", "Search buffers")
nmap("<leader>f", "<CMD>Telescope find_files<CR>", "Search file in current directory")
nmap("<leader>g", "<CMD>Telescope git_files<CR>", "Search file in git repository")
nmap("<leader>t", "<CMD>lua live_grep_from_project_git_root()<CR>", "Search string in git repository")
nmap("<leader>?", "<CMD>Telescope oldfiles<CR>", "Search recently opened files")
nmap("<leader>/", "<CMD>Telescope current_buffer_fuzzy_find<CR>", "Search in current buffer")
nmap("<leader>sh", "<CMD>Telescope diagnostics<CR>", "Search diagnostics")

-- EASY-ALIGN --
xmap("ga=", ":EasyAlign =<CR>", "Align to =")
xmap("gai", ":EasyAlign /import/<CR>", "Align to import")
nmap("ga=", "vip :EasyAlign =<CR>", "Align to =")
nmap("gai", "vip :EasyAlign /import/<CR>", "Align to import")

-- Git --
nmap("<leader>hs", "<CMD>Gitsigns stage_hunk<CR>", "Stage hunk")
nmap("<leader>hr", "<CMD>Gitsigns reset_hunk<CR>", "Reset hunk")
nmap("<leader>hp", "<CMD>Gitsigns preview_hunk_inline<CR>", "Preview hunk")
nmap("<leader>hb", "<CMD>Gitsigns toggle_current_line_blame<CR>", "Line blame")
nmap("<leader>hd", "<CMD>Gitsigns diffthis<CR>", "Diff this")

-- LSP --
nmap("<leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Actions")

-- Snippets --
-- imap('<C-p>', '<CMD>lua require("luasnip").jump(-1)<CR>)', 'Snippet jump to previous parameter')
imap("<S-Tab>", '<CMD>lua require("luasnip").jump(1)<CR>', "Snippet jump to next parameter")

-- Model --
nmap("<leader>m", "<CMD>Gen<CR>", "Open Model actions")
