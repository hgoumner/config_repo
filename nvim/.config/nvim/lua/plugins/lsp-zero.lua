return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = false,
    dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',

        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local lsp = require('lsp-zero')

        lsp.set_preferences({
          suggest_lsp_servers = true,
          setup_servers_on_start = true,
          set_lsp_keymaps = false,
          configure_diagnostics = true,
          cmp_capabilities = true,
          manage_nvim_cmp = true,
          call_servers = 'local',
          sign_icons = {
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = ''
          }
        })
        -- lsp.preset('recommended')
        -- lsp.nvim_workspace()
        lsp.setup()
    end,
}
