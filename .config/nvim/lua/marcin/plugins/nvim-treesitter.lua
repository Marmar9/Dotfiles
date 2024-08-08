return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "c", "lua", "cpp", "typescript", "javascript", "vim", "go", "yaml" },
			sync_install = false,
			highlight = {
				enable = true,
				disable = { "" },
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
