vim.g.mapleader = " "

require("marcin.lazy")

vim.o.termguicolors = true
vim.cmd'colorscheme catppuccin'

-- Set indentation level to 4 spaces
vim.opt.shiftwidth = 4

-- Use spaces instead of tabs
vim.opt.expandtab = true
vim.o.clipboard = "unnamedplus"

-- Line number configuration - Use relative
vim.o.relativenumber = true
vim.opt.number = true
vim.opt.commentstring = ""

-- Black hole register mappings
-- Define a keybind prefix for the black hole register
vim.api.nvim_set_keymap('n', '<leader>d', '"_d', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>d', '"_d', { noremap = true })



-- Define mappings for moving line up or down
-- in normal and visual mode currently: <space> + (j for down k for up)
vim.api.nvim_set_keymap('n', '<leader>j', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>j', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>k', ':m \'<-2<CR>gv=gv', { noremap = true, silent = true })
