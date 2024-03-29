-- This file contains all the neovim options and settings

-- help options
local options = {
    autochdir = true,
    backup = false,                                                                     -- creates a backup file
    clipboard = 'unnamedplus',                                                          -- allows neovim to access the system clipboard
    cmdheight = 2,                                                                      -- more space in the neovim command line for displaying messages
    completeopt = { 'menuone', 'noselect' },                                            -- mostly just for cmp
    conceallevel = 0,                                                                   -- so that `` is visible in markdown files
    cursorline = true,                                                                  -- highlight the current line
    encoding = 'utf-8',
    expandtab = true,                                                                   -- convert tabs to spaces
    fileencoding = 'utf-8',                                                             -- the encoding written to a file
    hlsearch = true,                                                                   -- highlight all matches on previous search pattern
    ignorecase = true,                                                                  -- ignore case in search patterns
    laststatus = 3,
    listchars = { eol='¬', tab='>·', trail='~', extends='>', precedes='<', space='␣' },
    mouse = 'a',                                                                        -- allow the mouse to be used in neovim
    number = true,                                                                      -- set numbered lines
    numberwidth = 4,                                                                    -- set number column width to 2 {default 4}
    pumheight = 10,                                                                     -- pop up menu height
    relativenumber = false,                                                             -- set relative numbered lines
    scrolloff = 8,                                                                      -- is one of my fav
    shiftwidth = 4,                                                                     -- the number of spaces inserted for each indentation
    showmode = false,                                                                   -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2,                                                                    -- always show tabs
    sidescrolloff = 8,
    signcolumn = 'yes',                                                                 -- always show the sign column, otherwise it would shift the text each time
    smartcase = true,                                                                   -- smart case
    smartindent = true,                                                                 -- make indenting smarter again
    splitbelow = true,                                                                  -- force all horizontal splits to go below current window
    splitright = true,                                                                  -- force all vertical splits to go to the right of current window
    swapfile = false,                                                                   -- creates a swapfile,,,
    tabstop = 4,                                                                        -- insert 2 spaces for a tab
    termguicolors = true,                                                               -- set term gui colors (most terminals support this)
    textwidth = 80,
    timeoutlen = 1000,                                                                  -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,                                                                    -- enable persistent undo
    updatetime = 1000,                                                                   -- faster completion (4000ms default)
    wrap = false,                                                                       -- display lines as one long line
    writebackup = false,                                                                -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.formatoptions:remove('cro')
vim.opt.iskeyword:append('-')
vim.opt.shortmess:append('c')
vim.opt.whichwrap:append('<,>,[,],h,l')

vim.opt.scrollopt:append('hor')

vim.scriptencoding = 'utf-8'
vim.wo.colorcolumn = '80'

-- change breakpoint icon
-- debugBreakpoint xxx ctermfg=236 ctermbg=167 guifg=#32302f guibg=#ea6962
vim.api.nvim_set_hl(0, 'HGbreak', { ctermfg=236, ctermbg=167, fg='#32302F', bg='#EA6962' })
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='debugBreakpoint', numhl=''})

vim.api.nvim_create_autocmd(
    'BufEnter',
    {
        buffer = bufnr,
        pattern = 'py',
        command = 'require("swenv.api").get_current_venv()'
    }
)

vim.api.nvim_create_autocmd(
    {'Cursorhold', 'CursorHoldI'},
        {
          buffer = bufnr,
          callback = function()
            local opts = {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = 'rounded',
              source = 'always',
              prefix = ' ',
              scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
          end
        }
)
