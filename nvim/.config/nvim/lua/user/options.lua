-- This file contains all the neovim options and settings

-- help options
local options = {
    autochdir = true,
    backup = false,                          -- creates a backup file
    clipboard = 'unnamedplus',               -- allows neovim to access the system clipboard
    cmdheight = 1,                           -- more space in the neovim command line for displaying messages
    completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
    conceallevel = 0,                        -- so that `` is visible in markdown files
    cursorline = true,                       -- highlight the current line
    encoding = 'utf-8',
    expandtab = true,                        -- convert tabs to spaces
    fileencoding = 'utf-8',                  -- the encoding written to a file
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    hlsearch = false,  -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    laststatus = 3,
    listchars = { eol = '¬', tab = '>·', trail = '~', extends = '>', precedes = '<', space = '␣' },
    mouse = 'a',           -- allow the mouse to be used in neovim
    number = true,         -- set numbered lines
    numberwidth = 4,       -- set number column width to 2 {default 4}
    pumheight = 10,        -- pop up menu height
    relativenumber = true, -- set relative numbered lines
    scrolloff = 2,         -- is one of my fav
    shiftwidth = 4,        -- the number of spaces inserted for each indentation
    showmode = false,      -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2,       -- always show tabs
    sidescrolloff = 2,
    signcolumn = 'yes',    -- always show the sign column, otherwise it would shift the text each time
    smartcase = true,      -- smart case
    smartindent = true,    -- make indenting smarter again
    splitbelow = true,     -- force all horizontal splits to go below current window
    splitright = true,     -- force all vertical splits to go to the right of current window
    swapfile = false,      -- creates a swapfile,,,
    tabstop = 4,           -- insert 2 spaces for a tab
    termguicolors = true,  -- set term gui colors (most terminals support this)
    textwidth = 120,
    timeoutlen = 1000,     -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,       -- enable persistent undo
    updatetime = 500,      -- faster completion (4000ms default)
    wrap = true,           -- display lines as one long line
    writebackup = false,   -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.formatoptions:remove('cro')
vim.opt.iskeyword:remove('_')
vim.opt.shortmess:append('c')
vim.opt.whichwrap:append('<,>,[,],h,l')

vim.opt.scrollopt:append('hor')

vim.scriptencoding = 'utf-8'
vim.wo.colorcolumn = '120'
