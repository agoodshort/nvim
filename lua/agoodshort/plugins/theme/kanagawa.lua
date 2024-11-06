return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			variablebuiltinStyle = { italic = true },
			specialReturn = true, -- special highlight for the return keyword
			specialException = true, -- special highlight for exception handling keywords
			transparent = false, -- sets background color
			dimInactive = true, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = {
				palette = {},
				theme = {
					all = {
						ui = {
							bg_gutter = "none", --removes the background LineNr
						},
					},
				},
			},
			theme = "wave", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		})

		-- setup must be called before loading
		vim.cmd("colorscheme kanagawa")
	end,
}
