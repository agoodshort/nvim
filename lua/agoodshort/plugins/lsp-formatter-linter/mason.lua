return {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile" },
	build = ":MasonUpdate",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "neovim/nvim-lspconfig", dependencies = { "nvimdev/lspsaga.nvim" } },
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim",
		"kevinhwang91/nvim-ufo",
		"b0o/schemastore.nvim",
		"stevearc/conform.nvim",
		"mrcjkb/rustaceanvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})

		require("neodev").setup({
			library = { plugins = { "nvim-dap-ui" }, types = true },
		})

		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Add folding capabilities required by ufo.nvim
		lsp_capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		-- local lsp_attach = function(client, bufnr)
		--              -- Create your keybindings here...
		--              -- Could it be used to display the name of the schema?
		--              -- SchemaStore.nvim cannot do it for us
		-- end

		-- Adds capabilities to rustaceanvim
		vim.g.rustacenvim = {
			server = {
				capabilities = lsp_capabilities,
			},
		}

		local lspconfig = require("lspconfig")
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					-- on_attach = lsp_attach,
					capabilities = lsp_capabilities,
				})
			end,

			-- Rust
			-- Do not spin up rust-analyzer automatically because it starts with rustacenvim
			["rust_analyzer"] = function() end,

			-- Lua (to use with v0.10 for inlay-hints)
            -- https://www.youtube.com/watch?v=DYaTzkw3zqQ
			-- ["lua_ls"] = function()
			-- 	lspconfig.lua_ls.setup({
			-- 		settings = {
			-- 			Lua = {
			-- 				hint = {
			-- 					enable = true,
			-- 				},
			-- 			},
			-- 		},
			-- 	})
			-- end,

			-- JSON
			["jsonls"] = function()
				lspconfig.jsonls.setup({
					capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				})
			end,

			-- YAML
			["yamlls"] = function()
				lspconfig.yamlls.setup({
					capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
					settings = {
						yaml = {
							keyOrdering = false,
							schemaStore = {
								-- You must disable built-in schemaStore support if you want to use this plugin and its advanced options like `ignore`.
								enable = false,
								-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				})
			end,
		})
	end,
}
