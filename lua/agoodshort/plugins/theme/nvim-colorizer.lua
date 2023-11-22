return {
	"norcalli/nvim-colorizer.lua", -- displays color on codes
	event = "BufReadPost",
	config = function()
		require("colorizer").setup()
	end,
}
