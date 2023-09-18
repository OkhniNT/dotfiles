return {
    { 'hrsh7th/nvim-cmp', config = function ()
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function (args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            view = {
                entries = { name = 'custom', selection_order = 'near_cursor' },
            },
            mapping = cmp.mapping.preset.insert({
                [ '<c-space>' ] = cmp.mapping.complete(),
                [ '<c-e>' ] = cmp.mapping.abort(),
                [ '<tab>' ] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                [ '<s-tab>' ] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                [ '<cr>' ] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = 'luasnip' },
                { name = 'buffer' },
            }),
        })
    end },

    { 'l3mon4d3/luasnip', build = 'make install_jsregexp', config = function ()
        ls = require('luasnip')
        ls.setup({
            ext_prio_increase = 1,
            enable_autosnippets = true,
        })
        require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/snippets'})

        vim.keymap.set('i', '<c-a>', function ()
            if ls.choice_active() then
                ls.change_choice(1)
            else
                ls.jump(1)
            end
        end )
    end },

    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
}
