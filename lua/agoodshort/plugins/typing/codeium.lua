return {
	"Exafunction/codeium.nvim",
	event = "BufEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			enable_chat = true,
		})
	end,
}
