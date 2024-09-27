return {
	"williamboman/mason.nvim",

	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"lua_ls",
				"jdtls",
				"kotlin_language_server",
				"clangd",
				"pyright",
				"tsserver",
				"tailwindcss",
				"emmet_ls",
				"cssls",
				"html",
				"gopls",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"ktlint",
			},
		})
	end,
}
