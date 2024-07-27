return {
	{
		"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...
		event = "InsertEnter",
		config = true,
	},
	{
		"David-Kunz/cmp-npm",
		lazy = true,
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
			ignore = {},
			only_semantic_versions = false,
			only_latest_version = false,
		},
	},
	{
		"hrsh7th/nvim-cmp", -- Autocompletion
		event = "InsertEnter",
		dependencies = {
			-- LuaSnip required
			{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" }, build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
			-- Recommended
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			-- My own
			"hrsh7th/cmp-nvim-lua",
			"David-Kunz/cmp-npm", -- Configured above
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			---@diagnostic disable-next-line: missing-fields
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "codeium" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "npm", keyword_length = 4 },
					{
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					},
				},
				mapping = {
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				---@diagnostic disable-next-line: missing-fields
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						symbol_map = { Codeium = "" },
					}),
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load() -- Load friendly-snippets
		end,
	},
}
