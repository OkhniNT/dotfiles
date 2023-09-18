return {
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
            mapping = cmp.mapping.preset.insert({
                [ '<c-space>' ] = cmp.mapping.complete(),
                [ '<c-e>' ] = cmp.mapping.abort(),
                [ '<tab>' ] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                [ '<s-tab>' ] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                [ '<cr>' ] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = 'snippy' },
                { name = 'buffer' },
            }),
        })
    end },
    { 'hrsh7th/cmp-buffer' },

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
