local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

local dashboard_ok, dashboard = pcall(require, "alpha.themes.dashboard")
if not dashboard_ok then
    return
end

local fortune_ok, fortune = pcall(require, "alpha.fortune")
if not fortune_ok then
    return
end

vim.api.nvim_set_hl(0, 'BGtop', { fg = 'white' })
vim.api.nvim_set_hl(0, 'BGmid', { fg = 'green' })
vim.api.nvim_set_hl(0, 'BGbot', { fg = 'red' })

local header = {
    [[██████╗ ██╗   ██╗██╗      ██████╗  █████╗ ██████╗ ██╗ █████╗ ]],
    [[██╔══██╗██║   ██║██║     ██╔════╝ ██╔══██╗██╔══██╗██║██╔══██╗]],
    [[██████╔╝██║   ██║██║     ██║  ███╗███████║██████╔╝██║███████║]],
    [[██╔══██╗██║   ██║██║     ██║   ██║██╔══██║██╔══██╗██║██╔══██║]],
    [[██████╔╝╚██████╔╝███████╗╚██████╔╝██║  ██║██║  ██║██║██║  ██║]],
    [[╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝]],
}

-- Colorize header
local function colorize_header()
    local lines  = {}
    local ind    = 1
    local cur    = 1
    local length = #header
    local ldiv3  = length / 3
    local hlcur  = {'BGtop', 'BGmid', 'BGbot'}
    for i, chars in pairs(header) do
        if (i > cur*ldiv3) then
            cur = cur + 1
            ind = ind + 1
        end
        local hlcurselection = hlcur[ind]
        local line = {
            type = "text",
            val = chars,
            opts = {
                hl = hlcurselection,
                shrink_margin = false,
                position = "center",
            },
        }
        table.insert(lines, line)
    end
    return lines
end

dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("c", "  nvim config", ":e ~/.config/nvim/init.lua <CR>"),
    dashboard.button('u', '  Update plugins', '<Cmd>PackerSync<CR>'),
    dashboard.button('a', '力 LSP servers', '<Cmd>Mason<CR>'),
    dashboard.button("z", "  zsh config", ":e $ZDOTDIR/.zshrc <CR>"),
    dashboard.button('q', '  Quit', '<Cmd>qa!<CR>'),
}

dashboard.section.footer.val = fortune()
dashboard.section.footer.opts.hl = 'TSEmphasis'

-- Setup
alpha.setup({
    layout = {
        { type = "padding", val = 4 },
        { type = "group", val = colorize_header() },
        { type = "padding", val = 4 },
        dashboard.section.buttons,
        { type = "padding", val = 4 },
        dashboard.section.footer,
    },
    opts = { margin = 5 },
})


