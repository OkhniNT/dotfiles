local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = {
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

        vim.keymap.set('i', '<cr>', [[pumvisible() ? (complete_info().selected == -1 ? '\<c-e><cr>' : '\<c-y>') : '<cr>']], { expr = true, noremap = true })
        vim.keymap.set('i', '<tab>', [[pumvisible() ? '<c-n>' : '<tab>']], { expr = true, noremap = true })
        vim.keymap.set('i', '<esc>', [[pumvisible() ? '<c-e><esc>' : '<esc>']], { expr = true, noremap = true })

        vim.keymap.set('n', '<leader>cx', ':COQnow -s <cr>', { noremap = true })
        vim.keymap.set('n', '<leader>cse', ':COQsnips edit <cr>', { noremap = true })
        vim.keymap.set('n', '<leader>csc', ':COQsnips compile <cr>', { noremap = true })
    end },

    { 'cohama/lexima.vim', config = function ()
        vim.fn['lexima#add_rule']({ char = '$', input_after = '$', filetype = 'tex' })
        vim.fn['lexima#add_rule']({ char = '$', at = [[\%#\$]], leave = 1, filetype = 'tex' })
        vim.fn['lexima#add_rule']({ char = '<space>', at = [[\%#\$]], input = '<space>', input_after = '<space>', filetype = 'tex' })
        vim.fn['lexima#add_rule']({ char = '<bs>', at = [[\$\%#\$]], delete = 1, filetype = 'tex' })
        vim.fn['lexima#add_rule']({ char = '<bs>', at = [[\$\s\%#\s\$]], delete = 1, filetype = 'tex' })
    end },

    { 'kylechui/nvim-surround', config = function()
        require("nvim-surround").setup()
    end },

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

}

require('lazy').setup(plugins)
