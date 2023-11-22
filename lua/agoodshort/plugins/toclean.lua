return {
	-- simple plugin
	"wakatime/vim-wakatime",
	"alker0/chezmoi.vim",
	{ "sitiom/nvim-numbertoggle", event = "BufReadPost" }, -- toggles relative number off when leaving buffer
	{ "numToStr/Comment.nvim", event = "BufReadPost", opts = {} }, -- comment with gc
	{
		"vuki656/package-info.nvim",
		ft = "json",
		dependencies = "MunifTanjim/nui.nvim",
		opts = {},
	},
}
