return {
	"uga-rosa/ccc.nvim", -- displays colour on codes
	event = "BufReadPost",
	opts = {
		highlighter = {
			auto_enable = true,
		},
	},
}
