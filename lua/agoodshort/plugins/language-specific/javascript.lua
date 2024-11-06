return {
	{
		"vuki656/package-info.nvim",
		event = { "BufRead package.json" },
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("package-info").setup()

			require("which-key").add({
				{
					"<leader>n",
					group = "NPM Package Info",
				},
				{
					"<leader>ns",
					function()
						require("package-info").toggle()
					end,
					desc = "Show NPM Package Info",
				},
				{
					"<leader>nd",
					function()
						require("package-info").delete()
					end,
					desc = "Delete NPM Package",
				},
				{
					"<leader>nv",
					function()
						require("package-info").change_version()
					end,
					desc = "Change NPM Package Version",
				},
				{
					"<leader>ni",
					function()
						require("package-info").install()
					end,
					desc = "Install NPM Package",
				},
			})
		end,
	},
	{
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh npm",
		opts = {},
	},
}
