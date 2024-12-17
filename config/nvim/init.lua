vim.g.mapleader = " "

vim.cmd("set mouse=")

require("marcin.lazy")

vim.o.termguicolors = true
vim.cmd("colorscheme catppuccin")

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
vim.api.nvim_set_keymap("n", "<leader>d", '"_d', { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>d", '"_d', { noremap = true })

-- Define mappings for moving line up or down
-- in normal and visual mode currently: <space> + (j for down k for up)
vim.api.nvim_set_keymap("n", "<leader>j", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>j", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>k", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.diagnostic.config({
	virtual_text = false,
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

-- Some customization fixes

-- Remap 'n' to repeat search and center the screen
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true, silent = true })

-- Remap 'Ctrl + d' to scroll down and center the screen
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- Remap 'Ctrl + u' to scroll up and center the screen
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
