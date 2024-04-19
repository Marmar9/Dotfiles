vim.g.mapleader = " "

require("marcin.lazy")

vim.o.termguicolors = true
vim.cmd'colorscheme catppuccin'

-- Set indentation level to 4 spaces
vim.opt.shiftwidth = 4

-- Use spaces instead of tabs
vim.opt.expandtab = true

vim.o.clipboard = "unnamedplus"

-- For line numbers
vim.o.relativenumber = true
vim.opt.number = true

vim.opt.commentstring = ""
