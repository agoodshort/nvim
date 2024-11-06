return {
	"danymat/neogen",
	config = true,
	keys = {
		{
			"<leader>D",
			function()
				require("neogen").generate({})
			end,
			desc = "Generate Documentation",
		},
	},
}
