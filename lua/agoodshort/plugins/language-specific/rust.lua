return {
	{
		"mrcjkb/rustaceanvim",
		version = "^3", -- Recommended
		ft = { "rust" },
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		tag = "stable",
		dependencies = "hrsh7th/nvim-cmp",
		config = function()
			require("crates").setup()
			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
				pattern = "Cargo.toml",
				callback = function()
					require("cmp").setup.buffer({ sources = { { name = "crates" } } })
				end,
			})
		end,
	},
}
