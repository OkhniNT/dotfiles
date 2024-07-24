return {
    { 'neovim/nvim-lspconfig', config = function ()
        local lspconfig = require('lspconfig')
        lspconfig.clangd.setup {}
        lspconfig.pyright.setup {}
        lspconfig.rust_analyzer.setup {}
    end },
    { 'hrsh7th/cmp-nvim-lsp' },

    { 'hrsh7th/nvim-cmp', config = function ()
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function (args)
                    require('snippy').expand_snippet(args.body)
                end
            },
            view = {
                entries = { name = 'custom', selection_order = 'near_cursor' },
            },
            formatting = {
                format = function (entry, vim_item)
                    vim_item.abbr = string.sub(vim_item.abbr, 1, 60)
                    return vim_item
                end
            },
            mapping = cmp.mapping.preset.insert({
                [ '<c-space>' ] = cmp.mapping.complete(),
                [ '<c-e>' ] = cmp.mapping.abort(),
                [ '<tab>' ] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                [ '<c-a>' ] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                [ '<s-tab>' ] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                [ '<cr>' ] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = 'snippy' },
                { name = 'nvim_lsp' },
                -- { name = 'buffer' },
            }),
            experimental = { ghost_text = true },
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require('lspconfig')['clangd'].setup {
            capabilities = capabilities
        }
        require('lspconfig')['pyright'].setup {
            capabilities = capabilities
        }
        require('lspconfig')['rust_analyzer'].setup {
            capabilities = capabilities
        }

        vim.keymap.set('n', '<leader>cd', function () cmp.setup.buffer({ enabled = false }) vim.print('Completion disabled') end)
        vim.keymap.set('n', '<leader>ce', function () cmp.setup.buffer({ enabled = true }) vim.print('Completion enabled') end)
    end },
    -- { 'hrsh7th/cmp-buffer' },

    { 'dcampos/nvim-snippy', opts = {
        choice_delay = 500,
        mappings = {
            is = {
                ['<tab>'] = 'next',
            },
        },
    }},
    { 'dcampos/cmp-snippy' },
}
