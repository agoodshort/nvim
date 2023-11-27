return {
	"m4xshen/hardtime.nvim",
	event = "VeryLazy",
	opts = {
		max_time = 1000,
		max_count = 5,
		disable_mouse = false,
		hint = true,
		notification = true,
		allow_different_key = false,
		resetting_keys = {
			["1"] = { "n", "x" },
			["2"] = { "n", "x" },
			["3"] = { "n", "x" },
			["4"] = { "n", "x" },
			["5"] = { "n", "x" },
			["6"] = { "n", "x" },
			["7"] = { "n", "x" },
			["8"] = { "n", "x" },
			["9"] = { "n", "x" },
			["c"] = { "n" },
			["C"] = { "n" },
			["d"] = { "n" },
			["x"] = { "n" },
			["X"] = { "n" },
			["y"] = { "n" },
			["Y"] = { "n" },
			["p"] = { "n" },
			["P"] = { "n" },
		},
		restricted_keys = {
			["h"] = {},
			["j"] = { "n", "x" },
			["k"] = { "n", "x" },
			["l"] = {},
			["-"] = { "n", "x" },
			["+"] = { "n", "x" },
			["gj"] = { "n", "x" },
			["gk"] = { "n", "x" },
			["<CR>"] = { "n", "x" },
			["<C-M>"] = { "n", "x" },
			["<C-N>"] = { "n", "x" },
			["<C-P>"] = { "n", "x" },
		},
		disabled_keys = {
			["<UP>"] = {},
			["<DOWN>"] = {},
			["<LEFT>"] = {},
			["<RIGHT>"] = {},
			-- ["<UP>"] = { "", "i" },
			-- ["<DOWN>"] = { "", "i" },
			-- ["<LEFT>"] = { "", "i" },
			-- ["<RIGHT>"] = { "", "i" },
		},
		disabled_filetypes = {
			"qf",
			"netrw",
			"neo-tree",
			"neo-tree-popup",
			"lazy",
			"mason",
			"help",
			"noice",
			"toggleterm",
			"undotree",
			"diff",
			"sagarename",
		},
	},
}
