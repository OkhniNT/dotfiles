return {
    { 'rebelot/kanagawa.nvim', config = function ()
        require('kanagawa').setup({
            transparent = true,
            colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
        })
        vim.cmd.colorscheme('kanagawa')
    end },

    { 'nvim-treesitter/nvim-treesitter' , build = ':TSUpdate', config = function ()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { 'c', 'python', 'lua', 'markdown', 'markdown_inline', 'diff', 'latex', 'yuck' },
            highlight = {
                enable = true,
                disable = { 'latex' },
            },
            indent = { enable = false },
        })

        -- vim.opt.foldmethod = 'expr'
        -- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end },

    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' , 'burntsushi/ripgrep' }, config = function ()
        local telescope = require('telescope.builtin')

        vim.keymap.set('n', '<leader>tt', telescope.find_files, { noremap = true })
        vim.keymap.set('n', '<leader>tg', telescope.live_grep, { noremap = true })
        vim.keymap.set('n', '<leader>tb', telescope.buffers, { noremap = true })
    end },

    -- { 'ms-jpq/coq-nvim', branch = 'coq', config = function ()
    --     vim.g.coq_settings = { ['keymap.jump_to_mark'] = '<c-a>', ['keymap.recommended'] = false }

    --     vim.keymap.set('i', '<tab>', [[pumvisible() ? '<c-n>' : '<tab>']], { expr = true, noremap = true })
    --     vim.keymap.set('i', '<esc>', [[pumvisible() ? '<c-e><esc>' : '<esc>']], { expr = true, noremap = true })

    --     vim.keymap.set('n', '<leader>cx', ':COQnow -s <cr>', { noremap = true })
    --     vim.keymap.set('n', '<leader>cse', ':COQsnips edit <cr>', { noremap = true })
    --     vim.keymap.set('n', '<leader>csc', ':COQsnips compile <cr>', { noremap = true })
    -- end },

    { 'kylechui/nvim-surround', opts = {} },

    { 'folke/zen-mode.nvim', config = function ()
        require('zen-mode').setup({
            window = {
                width = 85,
                options = {
                    number = true,
                    relativenumber = true,
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

