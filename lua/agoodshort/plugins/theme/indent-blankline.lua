return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPost",
	main = "ibl",
	dependencies = { "HiPhish/rainbow-delimiters.nvim", "nvim-treesitter/nvim-treesitter" },
	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}
		local highlightDark = {
			"RainbowRedDark",
			"RainbowYellowDark",
			"RainbowBlueDark",
			"RainbowOrangeDark",
			"RainbowGreenDark",
			"RainbowVioletDark",
			"RainbowCyanDark",
		}
		local hooks = require("ibl.hooks")
		local rainbow_delimiters = require("rainbow-delimiters")
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75", bold = true })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B", bold = true })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF", bold = true })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66", bold = true })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379", bold = true })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD", bold = true })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2", bold = true })
			vim.api.nvim_set_hl(0, "RainbowRedDark", { fg = "#b79597" })
			vim.api.nvim_set_hl(0, "RainbowYellowDark", { fg = "#c0b5a0" })
			vim.api.nvim_set_hl(0, "RainbowBlueDark", { fg = "#9aa9b6" })
			vim.api.nvim_set_hl(0, "RainbowOrangeDark", { fg = "#ac9b8b" })
			vim.api.nvim_set_hl(0, "RainbowGreenDark", { fg = "#9ca993" })
			vim.api.nvim_set_hl(0, "RainbowVioletDark", { fg = "#b39bba" })
			vim.api.nvim_set_hl(0, "RainbowCyanDark", { fg = "#7c999c" })
		end)

		vim.g.rainbow_delimiters = {
			strategy = {
				[""] = rainbow_delimiters.strategy["global"],
				vim = rainbow_delimiters.strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			highlight = highlight,
		}

		require("ibl").setup({
			scope = {
				highlight = highlight,
				char = "▎",
			},
			indent = {
				highlight = highlightDark,
				char = "▏",
			},
			exclude = {
				filetypes = {
					"lspinfo",
					"packer",
					"checkhealth",
					"help",
					"man",
					"gitcommit",
					"TelescopePrompt",
					"TelescopeResults",
					"",
					"dashboard",
				},
			},
		})
	end,
}
