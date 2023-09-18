return {
    { 'hrsh7th/nvim-cmp', config = function ()
        local cmp = require('cmp')
        cmp.setup({
            snippet = {},
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
                { name = 'buffer' },
            }),
        })
    end },
    { 'hrsh7th/cmp-buffer' },
    -- { 'saadparwaiz1/cmp_luasnip' },
}
