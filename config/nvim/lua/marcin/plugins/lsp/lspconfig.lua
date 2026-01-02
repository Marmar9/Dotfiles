return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- "hrsh7th/cmp-nvim-lsp",
		"saghen/blink.cmp",
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
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

				vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { buffer = true, desc = "Code Action" })
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local lsp_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")

		-- vim.lsp.config("*", {
		-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(),
		-- })

		-- vim.lsp.config["luals"] =  Old way

		local lazy_root = require("lazy.core.config").options.root
		vim.lsp.config("luals", {
			-- cmd = { "lua-language-server" }, Does work from some reason
			cmd = { lsp_path .. "/lua-language-server" },
			filetypes = { "lua" },
			root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
			-- specific settings to send to the server. the schema is server-defined.
			-- example: https://raw.githubusercontent.com/luals/vscode-lua/master/setting/schema.json

			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT", -- Neovim uses LuaJIT
						path = vim.split(package.path, ";"), -- ensures standard Lua module resolution patterns
					},
					diagnostics = {
						globals = { "vim" }, -- prevent "undefined global 'vim'" warnings
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME, -- only include Neovim runtime
							lazy_root,
						},
						checkThirdParty = false, -- don’t scan random folders like .vscode
					},
					telemetry = {
						enable = false, -- disable sending telemetry data
					},
				},
			},
		})
		vim.lsp.enable("luals")

		-- Typescript linter
		vim.lsp.config("biome", {})
		vim.lsp.enable("biome")

		-- Typescript lsp
		--vim.lsp.config("tsgo", {
		--	cmd = { os.getenv("XDG_CACHE_HOME") .. "/.bun/bin/tsgo", "--lsp", "--stdio" },
		--	filetypes = { "typescriptreact", "typescript" },
		--	root_markers = { "package.json", ".git" },
		--})

		--vim.lsp.enable("tsgo")

		-- Typescript lsp
		vim.lsp.config("ts_ls", {})

		vim.lsp.enable("ts_ls")

		-- Css lsp
		vim.lsp.config("cssls", {})

		vim.lsp.enable("cssls")

		-- Tailwind lsp
		vim.lsp.config("tailwindcss", {})
		vim.lsp.enable("tailwindcss")

		-- Json lsp
		vim.lsp.config("jsonls", {})
		vim.lsp.enable("jsonls")

		-- Cpp lsp
		vim.lsp.config("clangd", {})
		vim.lsp.enable("clangd")
	end,
}
