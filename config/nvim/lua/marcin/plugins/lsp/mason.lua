return {
	"williamboman/mason.nvim",

	-- dependencies = {
	-- 	"williamboman/mason-lspconfig.nvim",
	-- 	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- },
	config = function()
		function log(message)
			vim.notify(message, vim.log.levels.INFO)
		end

		local mason = require("mason")
		local registry = require("mason-registry")
		-- import mason-lspconfig
		-- local mason_lspconfig = require("mason-lspconfig")

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

		local lsps = {
			"lua-language-server",
			"stylua",
			"jdtls",
			"kotlin-language-server",
			"clangd",
			"pyright",
			"biome",
			"tailwindcss-language-server", --
                        "typescript-language-server",
			-- "emmet_ls",
			"css-lsp",
			"html-lsp",
			"gopls",
			"sqls",
			"json-lsp",
		}

		for _, lsp in ipairs(lsps) do
			if not registry.is_installed(lsp) then
				registry.get_package(lsp):install()
			end
		end

		-- require("mason-tool-installer").setup({
		-- 	ensure_installed = {
		-- 		"ktlint",
		-- 		"sql-formatter",
		-- 	},
		-- })
	end,
}
