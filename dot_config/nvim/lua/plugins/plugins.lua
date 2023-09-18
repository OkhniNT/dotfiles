return {
    { 'rebelot/kanagawa.nvim', config = function ()
        require('kanagawa').setup({
            theme = 'dragon',
            transparent = true,
            colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
        })
        vim.cmd.colorscheme('kanagawa-dragon')
    end },

    { 'nvim-treesitter/nvim-treesitter' , build = ':TSUpdate', config = function ()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { 'c', 'python', 'lua', 'markdown', 'markdown_inline', 'diff', 'latex' },
            highlight = {
                enable = true,
                disable = { 'latex' },
            },
            indent = { enable = false },
        })

        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end },

    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' , 'burntsushi/ripgrep' }, config = function ()
        local telescope = require('telescope.builtin')

        vim.keymap.set('n', '<leader>tt', telescope.find_files, { noremap = true })
        vim.keymap.set('n', '<leader>tg', telescope.live_grep, { noremap = true })
        vim.keymap.set('n', '<leader>tb', telescope.buffers, { noremap = true })
    end },

    { 'ms-jpq/coq-nvim', branch = 'coq', config = function ()
        vim.g.coq_settings = { ['keymap.jump_to_mark'] = '<c-a>', ['keymap.recommended'] = false }

        vim.keymap.set('i', '<tab>', [[pumvisible() ? '<c-n>' : '<tab>']], { expr = true, noremap = true })
        vim.keymap.set('i', '<esc>', [[pumvisible() ? '<c-e><esc>' : '<esc>']], { expr = true, noremap = true })

        vim.keymap.set('n', '<leader>cx', ':COQnow -s <cr>', { noremap = true })
        vim.keymap.set('n', '<leader>cse', ':COQsnips edit <cr>', { noremap = true })
        vim.keymap.set('n', '<leader>csc', ':COQsnips compile <cr>', { noremap = true })
    end },

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
            Rule(' ', ' ')
                :with_pair(cond.before_regex('[%[({%$]',1))
                :with_pair(cond.after_regex('[%])}%$]', 1))
                :with_del(cond.not_before_regex('%w%s', 2))
                :with_move(cond.after_regex('%s[%])}%$]', 2)),
            Rule('$', '$', 'tex'):with_move(cond.done()):with_cr(cond.none()),
            Rule('$$', '$$', 'tex'):end_wise(cond.after_regex('$', 1)),
        })
    end },

    { 'kylechui/nvim-surround', opts = {} },

    { 'folke/zen-mode.nvim', config = function ()
        require('zen-mode').setup({
            window = {
                width = 90,
                options = {
                    number = false,
                    relativenumber = false,
                }, }
        })

        vim.keymap.set('n', '<leader>z', ':ZenMode <cr>', { noremap = true })
    end },

    { 'akinsho/toggleterm.nvim', config = function () 
        require('toggleterm').setup()
        vim.keymap.set('n', '<leader>s', ':ToggleTerm direction=float <cr>')
    end },

    { 'jinh0/eyeliner.nvim', config = function ()
        require('eyeliner').setup({
            highlight_on_key = true,
            dim = true,
        })
        vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
        vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })
    end },
}

