return {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile" },
	build = ":MasonUpdate",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "neovim/nvim-lspconfig", dependencies = { "nvimdev/lspsaga.nvim" } },
		"hrsh7th/cmp-nvim-lsp",
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

		-- Auto update schemastore at startup
		require("lazy").update({ plugins = { "schemastore.nvim" }, show = false })

		vim.api.nvim_create_user_command("InlayHintToggle", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
			vim.cmd([[doautocmd LspAttach]]) -- hacky way to trigger heirline update
		end, { desc = "Enable/Disable inlay hint on current buffer" })

		-- see https://github.com/rcarriga/nvim-dap-ui/issues/367
		-- require("neodev").setup({
		-- 	library = { plugins = { "nvim-dap-ui" }, types = true },
		-- })

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
				settings = {
					["rust-analyzer"] = {
						inlayHints = {
							bindingModeHints = {
								enable = false,
							},
							chainingHints = {
								enable = true,
							},
							closingBraceHints = {
								enable = true,
								minLines = 25,
							},
							closureReturnTypeHints = {
								enable = "never",
							},
							lifetimeElisionHints = {
								enable = "never",
								useParameterNames = false,
							},
							maxLength = 25,
							parameterHints = {
								enable = true,
							},
							reborrowHints = {
								enable = "never",
							},
							renderColons = true,
							typeHints = {
								enable = true,
								hideClosureInitialization = false,
								hideNamedConstructor = false,
							},
						},
					},
				},
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

			-- Cypress Cucumber preprocessor https://github.com/badeball/cypress-cucumber-preprocessor
			["cucumber_language_server"] = function()
				lspconfig.cucumber_language_server.setup({
					capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
					settings = {
						cucumber = {
							features = { "cypress/e2e/**/*.feature" },
							glue = { "cypress/e2e/**/*.ts" },
						},
					},
				})
			end,

			-- Lua
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
					settings = {
						Lua = {
							hint = {
								enable = true,
							},
						},
					},
				})
			end,

			-- TSServer
			["ts_ls"] = function()
				lspconfig.ts_ls.setup({
					capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				})
			end,

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
