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
    { 'l3mon4d3/luasnip' }
}
opts = {}

require("lazy").setup(plugins, opts)