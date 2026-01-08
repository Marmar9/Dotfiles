return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			sync_install = true,
			ensure_installed = {},
			ignore_install = {},
			modules = {},
			highlight = {
				enable = true,
				disable = {},
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
