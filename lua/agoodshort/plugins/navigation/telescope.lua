return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"LinArcX/telescope-env.nvim",
			"jvgrootveld/telescope-zoxide",
			"keyvchan/telescope-find-pickers.nvim",
			"debugloop/telescope-undo.nvim",
			"agoodshort/telescope-git-submodules.nvim",
			"AckslD/nvim-neoclip.lua",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-node-modules.nvim",
			"tsakirist/telescope-lazy.nvim",
			"paopaol/telescope-git-diffs.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"piersolenski/telescope-import.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "tiagovla/scope.nvim", opts = {} },
			{ "ziontee113/icon-picker.nvim", opts = { disable_legacy_commands = true } },
		},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-s>"] = actions.select_vertical,
							["<C-?>"] = actions.which_key,
							["<C-c>"] = actions.close,
							["<tab>"] = actions.toggle_selection,
						},
						n = {
							["k"] = actions.move_selection_previous,
							["j"] = actions.move_selection_next,
							["s"] = actions.select_vertical,
							["?"] = actions.which_key,
							["<C-c>"] = actions.close,
							["<tab>"] = actions.toggle_selection,
						},
					},
				},
				pickers = {
					live_grep = {
						additional_args = function(opts)
							if opts.custom_hidden == true then
								return { "--hidden", "-g", "!{.git,node_modules}/*" }
							end
						end,
					},
				},
				extensions = {
					git_submodules = {
						git_cmd = "lazygit",
						previewer = true,
						terminal_id = 9,
						find_subdirectories = {
							enabled = true,
							depth = 2,
						},
					},
					-- git_diffs = {
					-- 	initial_mode = "normal",
					-- },
					undo = {
						-- initial_mode = "normal",
						use_delta = true,
						use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
						side_by_side = false,
						vim_diff_opts = {
							ctxlen = vim.o.scrolloff,
						},
						entry_format = "state #$ID, $STAT, $TIME",
						mappings = {
							i = {
								["<CR>"] = require("telescope-undo.actions").restore,
							},
						},
					},
					lazy = {
						-- Whether or not to show the icon in the first column
						show_icon = true,
						-- Mappings for the actions
						mappings = {
							open_in_browser = "<C-o>",
							open_in_file_browser = "<M-b>",
							open_in_find_files = "<C-f>",
							open_in_live_grep = "<C-g>",
							open_plugins_picker = "<C-b>", -- Works only after having called first another action
							open_lazy_root_find_files = "<C-r>f",
							open_lazy_root_live_grep = "<C-r>g",
						},
						-- Other telescope configuration options
					},
					package_info = {
						-- Optional theme (the extension doesn't set a default theme)
						theme = "ivy",
					},
					zoxide = {
						prompt_title = "[ Zoxide List ]",

						-- Zoxide list command with score
						list_command = "zoxide query -ls",
						mappings = {
							default = {
								action = function(selection)
									vim.cmd.edit(selection.path)
									vim.cmd("Neotree position=current")
								end,
								after_action = function(selection)
									print("Directory changed to " .. selection.path)
								end,
							},
						},
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("env")
			require("telescope").load_extension("zoxide")
			require("telescope").load_extension("find_pickers")
			require("telescope").load_extension("undo")
			require("telescope").load_extension("neoclip")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("git_submodules")
			require("telescope").load_extension("node_modules")
			require("telescope").load_extension("lazy")
			require("telescope").load_extension("git_diffs")
			require("telescope").load_extension("noice")
			require("telescope").load_extension("scope")
			require("telescope").load_extension("package_info")
			require("telescope").load_extension("live_grep_args")
			require("telescope").load_extension("import")
		end,
	},
}
