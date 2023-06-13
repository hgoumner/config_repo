return {
    -- alpha start up
    'goolord/alpha-nvim',
    lazy = false,
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
        local alpha     = require('alpha')
        local dashboard = require('alpha.themes.dashboard')
        local fortune   = require('alpha.fortune')

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
        -- local header = {
        --     [[⠀⢰⣷⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣶⣤⣄⣀⠀⠀⠀⠀]],
        --     [[⠀⢿⣿⣷⣶⣦⣤⣤⣤⣤⣤⣤⣤⣀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⡄]],
        --     [[⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠃]],
        --     [[⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀]],
        --     [[⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀]],
        --     [[⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀]],
        --     [[⠀⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠻⡿⠿⠀⠀⠀]],
        --     [[⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀]],
        --     [[⠀⠀⠀⠛⠛⠋⠉⠉⠁⠀⠉⠻⢿⣿⣿⠿⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        -- }

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
            dashboard.button("e", "  New file",       "<CMD>ene <BAR> startinsert <CR>"),
            dashboard.button("f", "  Find file",      "<CMD>Telescope find_files <CR>"),
            dashboard.button("r", "  Recent files",   "<CMD>Telescope oldfiles <CR>"),
            dashboard.button("t", "  Find text",      "<CMD>Telescope live_grep <CR>"),
            dashboard.button("c", "  nvim config",    "<CMD>e ~/.config/nvim/init.lua <CR>"),
            dashboard.button('u', '  Update plugins', '<CMD>Lazy update<CR>'),
            dashboard.button('l', '力 LSP servers',    '<CMD>Mason<CR>'),
            dashboard.button("z", "  zsh config",     "<CMD>e $ZDOTDIR/.zshrc <CR>"),
            dashboard.button('q', '  Quit',           '<CMD>qa!<CR>'),
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

    end,
}
