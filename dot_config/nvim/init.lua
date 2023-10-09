-- Plugins --

-- load lazy
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

-- set term colours
vim.g.termguicolors = true
-- set leader
vim.g.mapleader = ','

require('lazy').setup('plugins')

-- Editor Configuation --

-- redirect viminfo to .config
vim.opt.viminfo:append('n~/.config/nvim/viminfo')

-- set number lines
vim.opt.number = true
vim.opt.relativenumber = true

-- set tab sizes
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- set search
vim.opt.ignorecase = true
-- set linebreak at words
vim.opt.linebreak = true
-- set list chars
vim.opt.lcs = 'eol:$,trail:~,extends:>,precedes:<,space:·'
-- set conceal level
vim.opt.cole = 0

-- Bindings --

-- save
vim.keymap.set('n', '==', ':w <cr>', { noremap = true })
-- terminal commands
vim.keymap.set('t', '<esc>', [[<c-\><c-n>]])
vim.keymap.set('t', '<c-w>', [[<c-\><c-n><c-w>]])
-- function keys
vim.keymap.set('n', '<F2>', 'za', { noremap = true })
vim.keymap.set('n', '<F5>', ':set nu! rnu! <cr>', { noremap = true })
vim.keymap.set('n', '<F7>', ':setlocal spell! spelllang=en_au <cr>', { noremap = true })
vim.keymap.set('n', '<F8>', ':set list! <cr>', { noremap = true })
vim.keymap.set('n', '<F12>', function ()
    if vim.o.background == 'dark' then vim.o.background = 'light'
    else vim.o.background = 'dark' end
end, { noremap = true })

-- latex figures
vim.keymap.set('i', '<c-f>', [[<esc>:silent exec '.!inkscape-figures create "'.getline('.').'" "figures"'<cr><cr>:w<cr>]], { noremap = true })
vim.keymap.set('n', '<c-f>', [[:silent exec '!inkscape-figures edit "figures" > /dev/null 2>&1 &'<cr><cr>:redraw!<cr>]], { noremap = true })
vim.keymap.set('n', '<leader>f', [[:silent exec '.!$HOME/.config/nvim/scripts/latex_diagrams'<cr><cr>:w<cr><cr>f[]], { noremap = true })

-- vimdiff
vim.keymap.set('n', '<leader>dp', ':diffput <cr>', { noremap = true })
vim.keymap.set('n', '<leader>dg', ':diffget <cr>', { noremap = true })

-- Commands --

-- W saves
vim.api.nvim_create_user_command('W', 'w', {})
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
--     callback = function () vim.keymap.set('n', '==', ':w <cr>:silent !pdflatex "%"; rm *.log *.aux <cr>:silent redraw! <cr>') end,
-- })

