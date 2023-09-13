local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = {
    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' , 'burntsushi/ripgrep' } },
    { 'kylechui/nvim-surround', config = function () require('nvim-surround').setup() end },
    { 'ms-jpq/coq-nvim', branch = 'coq' },
    { 'rebelot/kanagawa.nvim' },
    { 'cohama/lexima.vim' },
    { 'nvim-treesitter/nvim-treesitter' , build = ':TSUpdate', config = function ()
        local configs = require('nvim-treesitter.configs')

        configs.setup({
            ensure_installed = { 'c', 'python', 'lua', 'latex', 'markdown', 'markdown_inline', 'diff' },
            highlight = {
                enable = true,
                disable = { 'latex' },
                disable = function (lang, buf)
                    local max_filesize = 100 * 1024
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size < max_filesize then
                        return true
                    end
                end
            },
            indent = { enable = false },
        })
    end },
}

require("lazy").setup(plugins)
