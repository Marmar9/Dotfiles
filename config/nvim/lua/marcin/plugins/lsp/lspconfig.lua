return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { silent = true }
				-- set keybinds
				opts.desc = "Show LSP references"

				vim.api.nvim_buf_set_keymap(ev.buf, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

				vim.api.nvim_buf_set_keymap(ev.buf, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
				vim.api.nvim_set_keymap(
					"n",
					"<leader>rn",
					"<cmd>lua vim.lsp.buf.rename()<CR>",
					{ noremap = true, silent = true }
				) -- Rename symbol
			end,
		})
		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["sqls"] = function()
				lspconfig["sqls"].setup({
					capabilities = capabilities,
					cmd = {
						"/home/" .. os.getenv("USER") .. "/.local/share/nvim/mason/bin/sqls",
						"-config",
						"config.yml",
					},
				})
			end,

			["jdtls"] = function()
				lspconfig["jdtls"].setup({
					capabilities = capabilities,
					cmd = { "/home/" .. os.getenv("USER") .. "/.local/share/nvim/mason/bin/jdtls" },
				})
			end,

			["kotlin_language_server"] = function()
				lspconfig["kotlin_language_server"].setup({
					capabilities = capabilities,
					cmd = { "/home/" .. os.getenv("USER") .. "/.local/share/nvim/mason/bin/kotlin-language-server" },
				})
			end,

			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
