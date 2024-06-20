return {
	{
		"vuki656/package-info.nvim",
		event = { "BufRead package.json" },
		dependencies = "MunifTanjim/nui.nvim",
		opts = {},
	},
	{
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh npm",
		opts = {},
	},
}
