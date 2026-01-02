return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "biome-check" },
				typescript = { "biome-check" },
				javascriptreact = { "biome-check" },
				typescriptreact = { "biome-check" },
				go = { "biome-check" },
				css = { "biome-check" },
				html = { "biome-check" },
				json = { "biome-check" },
				yaml = { "biome-check" },
				markdown = { "biome-check" },
				graphql = { "biome-check" },
				liquid = { "biome-check" },
				lua = { "stylua" },
				python = { "isort", "black" },
				sql = { "sql_formatter" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 3000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 3000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
