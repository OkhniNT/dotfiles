-- Plugins --

-- set leader
vim.g.mapleader = ','
-- load lazy
require('plugins')

-- telescope config
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>tt', telescope.find_files, { noremap = true })
vim.keymap.set('n', '<leader>tg', telescope.live_grep, { noremap = true })
vim.keymap.set('n', '<leader>tb', telescope.buffers, { noremap = true })

-- coq config
vim.g.coq_settings = { ['keymap.jump_to_mark'] = '<c-a>', ['keymap.recommended'] = false }

vim.keymap.set('i', '<cr>', [[pumvisible() ? (complete_info().selected == -1 ? "\<c-e><cr>" : "\<c-y>") : "\<cr>"]], { expr = true, noremap = true })
vim.keymap.set('i', '<tab>', [[pumvisible() ? "\<c-n>" : "\<tab>"]], { expr = true, noremap = true })
vim.keymap.set('i', '<esc>', [[pumvisible() ? "\<c-e><esc>" : "\<esc>"]], { expr = true, noremap = true })

vim.keymap.set('n', '<leader>cx', ':COQnow -s <cr>', { noremap = true })
vim.keymap.set('n', '<leader>cse', ':COQsnips edit <cr><cr>', { noremap = true })
vim.keymap.set('n', '<leader>csc', ':COQsnips compile <cr>', { noremap = true })

-- treesitter config
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- lexima config
vim.fn['lexima#add_rule']({ char = '$', input_after = '$', filetype = 'tex' })
vim.fn['lexima#add_rule']({ char = ']', at = [[\%#\$]], leave = 1, filetype = 'tex' })
vim.fn['lexima#add_rule']({ char = '<space>', at = [[\%#\$]], input = '<space>', input_after = '<space>', filetype = 'tex' })
vim.fn['lexima#add_rule']({ char = '<bs>', at = [[\$\%#\$]], delete = 1, filetype = 'tex' })
vim.fn['lexima#add_rule']({ char = '<bs>', at = [[\$\s\%#\s\$]], delete = 1, filetype = 'tex' })

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
vim.opt.cole = 2

-- Bindings --

-- save
vim.keymap.set('n', '==', ':w <cr>', { noremap = true })
-- terminal commands
vim.keymap.set('t', '<esc>', [[<c-\><c-n>]])
vim.keymap.set('t', '<c-w>', [[<c-\><c-n><c-w>]])
-- function keys
vim.keymap.set('n', '<F5>', ':set nu! rnu! <cr>', { noremap = true })
vim.keymap.set('n', '<F7>', ':setlocal spell! spelllang=en_au <cr>', { noremap = true })
vim.keymap.set('n', '<F8>', ':set list! <cr>', { noremap = true })

-- latex figures
vim.keymap.set('i', '<c-f>', [[<esc>:silent exec '.!inkscape-figures create "'.getline('.').'" "figures"'<cr><cr>:w<cr>]], { noremap = true })
vim.keymap.set('n', '<c-f>', [[:silent exec '!inkscape-figures edit "figures" > /dev/null 2>&1 &'<cr><cr>:redraw!<cr>]], { noremap = true })
vim.keymap.set('n', '<leader>f', [[:silent exec '.!$HOME/.config/nvim/scripts/latex_diagrams'<cr><cr>:w<cr><cr>f[]], { noremap = true })

-- vimdiff
vim.keymap.set('n', '<leader>dp', ':diffput <cr>', { noremap = true })
vim.keymap.set('n', '<leader>dg', ':diffget <cr>', { noremap = true })

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
--     callback = function () vim.keymap.set('n', '==', ':w <cr>:silent !pdflatex "%"; rm *.log *.aux <cr>:silent redraw! <cr>') end,
-- })
