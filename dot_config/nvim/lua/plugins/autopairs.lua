return {
    { 'windwp/nvim-autopairs', config = function ()
        local npairs = require('nvim-autopairs')
        local Rule = require('nvim-autopairs.rule')
        local cond = require('nvim-autopairs.conds')
        npairs.setup({ map_cr = false })

        _G.MUtils= {}
        MUtils.CR = function()
            if vim.fn.pumvisible() ~= 0 then
                if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
                    return npairs.esc('<c-y>')
                else
                    return npairs.esc('<c-e>') .. npairs.autopairs_cr()
                end
            else
                return npairs.autopairs_cr()
            end
        end
        vim.api.nvim_set_keymap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

        npairs.add_rules({
            -- Rule(' ', ' ')
            --     :with_pair(cond.before_regex('[%[({%$]',1))
            --     :with_pair(cond.after_regex('[%])}%$]', 1))
            --     :with_del(cond.not_before_regex('%w%s', 2))
            --     :with_move(cond.after_regex('%s[%])}%$]', 2)),
            Rule('$', '$', 'tex'):with_move(cond.done()):with_cr(cond.none()),
            Rule('$$', '$$', 'tex'):end_wise(cond.after_regex('$', 1)),
        })
    end },
}
