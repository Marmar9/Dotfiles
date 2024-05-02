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

-- Black hole register mappings

-- Define a keybind prefix for the black hole register
vim.api.nvim_set_keymap('n', '<leader>d', '"_d', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>d', '"_d', { noremap = true })
