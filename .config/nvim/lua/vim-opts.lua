vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 15
vim.opt.signcolumn = 'yes'

vim.keymap.set('n', '<leader><leader>', ':noh<CR>', { silent = true })
vim.keymap.set('n', '<leader>ft', ':Ex<CR>', { silent = true })
