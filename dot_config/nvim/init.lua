-- Plugins --

-- set leader
vim.g.mapleader = ' '
-- load lazy
require('plugins')

-- telescope config
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', telescope.find_files, { noremap = true })
vim.keymap.set('n', '<leader>tg', telescope.live_grep, { noremap = true })
vim.keymap.set('n', '<leader>tb', telescope.buffers, { noremap = true })

-- coq config
vim.g.coq_settings = { ['keymap.jump_to_mark'] = '<c-a>', ['keymap.recommended'] = false }

vim.keymap.set('i', '<cr>', [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]], { expr = true, noremap = true })
vim.keymap.set('i', '<bs>', [[pumvisible() ? "\<C-e><BS>"  : "\<BS>"]], { expr = true, noremap = true })
vim.keymap.set('i', '<tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, noremap = true })

vim.keymap.set('n', '<leader>cx', ':COQnow -s <CR>', { noremap = true })
vim.keymap.set('n', '<leader>cse', ':COQsnips edit <CR><CR>', { noremap = true })
vim.keymap.set('n', '<leader>csc', ':COQsnips compile <CR>', { noremap = true })

-- treesitter config
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Editor Configuation --

-- redirect viminfo to .config
vim.opt.viminfo:append('n~/.config/nvim/viminfo')

-- colorscheme
vim.cmd.colorscheme('kanagawa')
vim.cmd.highlight({ 'Normal', 'guibg=NONE', 'ctermbg=NONE' })
vim.cmd.highlight({ 'EndOfBuffer', 'guibg=NONE', 'ctermbg=NONE' })
vim.cmd.highlight({ 'LineNr', 'guibg=NONE', 'ctermbg=NONE' })

-- set number lines
vim.opt.number = true
vim.opt.relativenumber = true

-- set tab sizes
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- set search
vim.opt.ignorecase = true
-- set list chars
vim.opt.lcs = 'eol:$,trail:~,extends:>,precedes:<,space:·'
-- set conceal level
vim.opt.cole = 1

-- Bindings --

-- save
vim.keymap.set('n', '==', ':w <CR>', { noremap = true })
-- terminal commands
vim.keymap.set('t', '<esc>', [[<c-\><c-n>]])
vim.keymap.set('t', '<c-w>', [[<c-\><c-n><c-w>]])
-- function keys
vim.keymap.set('n', '<F5>', ':set nu! rnu! <CR>', { noremap = true })
vim.keymap.set('n', '<F7>', ':setlocal spell! spelllang=en_au <CR>', { noremap = true })
vim.keymap.set('n', '<F8>', ':set list! <CR>', { noremap = true })

-- latex figures
vim.keymap.set('i', '<c-f>', [[<Esc>:silent exec '.!inkscape-figures create "'.getline('.').'" "figures"'<CR><CR>:w<CR>]], { noremap = true })
vim.keymap.set('n', '<c-f>', [[:silent exec '!inkscape-figures edit "figures" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>]], { noremap = true })
vim.keymap.set('n', '<leader>f', [[:silent exec '.!$HOME/.config/nvim/scripts/latex_diagrams'<CR><CR>:w<CR><CR>f[]], { noremap = true })

-- vimdiff
vim.keymap.set('n', '<leader>dp', ':diffput <CR>', { noremap = true })
vim.keymap.set('n', '<leader>dg', ':diffget <CR>', { noremap = true })

-- Commands --

-- reload file
vim.api.nvim_create_user_command('WE', 'w | e %', { bang = true })
-- open in zathura
vim.api.nvim_create_user_command('Z', 'silent !zth "%:r".pdf', { bang = true })

-- Autocommands --

vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost' }, {
    pattern = '*',
    command = ':norm zR'
})
-- vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
--     pattern = '*.tex',
--     callback = function () vim.keymap.set('n', '==', ':w <CR>:silent !pdflatex "%"; rm *.log *.aux <CR>:silent redraw! <CR>') end,
-- })
