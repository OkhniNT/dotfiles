-- Plugins --

-- Editor Configuation --
vim.opt.number = true
vim.opt.relativenumber = true


vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Bindings --
vim.keymap.set ('n', '<F5>', '<cmd>:set nu! rnu! <CR>')
vim.keymap.set ('n', '<F7>', '<cmd>:setlocal spell! spelllang=en_au <CR>')
vim.keymap.set ('n', '<F9>', '<cmd>:redraw! <CR>')
vim.keymap.set ('n', '==', '<cmd>:w <CR>')

-- TODO: add latex scripts
-- " latex figures
-- inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "figures"'<CR><CR>:w<CR>
-- vim.keymap.set ('n', '<C-f>', ':silent exec "!inkscape-figures edit figures > /dev/null 2>&1 &"<CR><CR>:!redraw<CR>')
-- latex pictures
vim.keymap.set ('n', '<Leader>f', ':silent exec ".!$HOME/.config/nvim/scripts/latex_diagrams"<CR><CR>:w<CR>f[')

vim.keymap.set ('n', '<Leader>dp', ':diffput <CR>')
vim.keymap.set ('n', '<Leader>dg', ':diffget <CR>')

-- Commands --
vim.api.nvim_create_user_command ('Z', ":silent !zth '%:r'.pdf", {})

-- Autocommands --
vim.api.nvim_create_autocmd ({ 'BufRead, BufReadPre, BufNewFile' }, {
    pattern = { '*.tex' },
    callback = function () vim.keymap.set ('n', '==', "<cmd>:w <CR>:!pdflatex '%'; rm *.log *.aux <CR>") end,
})
