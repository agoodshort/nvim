return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		{ "s1n7ax/nvim-window-picker", version = "v1.*" }, -- only needed if you want to use the commands with "_with_window_picker" suffix
	},
	config = function()
		require("window-picker").setup({
			autoselect_one = true,
			include_current = false,
			filter_rules = {
				-- filter using buffer options
				bo = {
					-- if the file type is one of following, the window will be ignored
					filetype = { "neo-tree", "neo-tree-popup", "notify" },

					-- if the buffer type is one of following, the window will be ignored
					buftype = { "terminal", "quickfix" },
				},
			},
			other_win_hl_color = "#e35e4f",
		})

		-- Unless you are still migrating, remove the deprecated commands from v1.x
		vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

		-- If you want icons for diagnostic errors, you'll need to define them somewhere:
		vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
		-- NOTE: this is changed from v1.x, which used the old style of highlight groups
		-- in the form "LspDiagnosticsSignWarning"

		require("neo-tree").setup({
			sources = {
				"filesystem",
				"buffers",
				-- "git_status",
				"document_symbols",
			},
			close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			use_default_mappings = false,
			sort_case_insensitive = false, -- used when sorting files and directories in the tree
			sort_function = nil, -- use a custom function for sorting files and directories in the tree
			source_selector = {
				winbar = true,
				sources = { -- table
					{
						source = "filesystem", -- string
						display_name = "  Files ", -- string | nil
					},
					{
						source = "buffers",
						display_name = "  Buffers ",
					},
					{ source = "document_symbols", display_name = "  Symbols " },
				},
			},
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				indent = {
					indent_size = 2,
					padding = 1, -- extra padding on left hand side
					-- indent guides
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					-- expander config, needed for nesting files
					with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "ﰊ",
					-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
					-- then these will never be used.
					default = "*",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			window = {
				position = "left",
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<space>"] = {
						"toggle_node",
						nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
					},
					["<2-LeftMouse>"] = "open",
					["<esc>"] = "revert_preview",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["S"] = "open_split",
					["s"] = "open_vsplit",
					-- ["<cr>"] = "open",
					-- ["t"] = "open_tabnew",
					["<cr>"] = "open_drop",
					["t"] = "open_tab_drop",
					["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["Z"] = "expand_all_nodes",
					["r"] = "rename",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["["] = "prev_source",
					["]"] = "next_source",
				},
			},
			nesting_rules = {},
			filesystem = {
				filtered_items = {
					visible = false, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_hidden = true, -- only works on Windows for hidden files/directories
					hide_by_name = {
						--"node_modules"
					},
					hide_by_pattern = { -- uses glob style patterns
						--"*.meta",
						--"*/src/*/tsconfig.json",
					},
					always_show = { -- remains visible even if other settings would normally hide it
						--".gitignored",
					},
					never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
						--".DS_Store",
						--"thumbs.db"
					},
					never_show_by_pattern = { -- uses glob style patterns
						--".null-ls_*",
					},
				},
				bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
				cwd_target = {
					sidebar = "tab", -- sidebar is when position = left or right
					current = "tab", -- current is when position = current
				},
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--               -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				group_empty_dirs = false,
				hijack_netrw_behavior = "open_default",
				use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
				-- instead of relying on nvim autocmd events.
				window = {
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = function(state)
							local node = state.tree:get_node()
							if node.type == "directory" then
								vim.cmd("tcd " .. node.path)
							end
						end,
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						["f"] = "filter_on_submit",
						["<c-x>"] = "clear_filter",
						["g["] = "prev_git_modified",
						["g]"] = "next_git_modified",
						["d"] = "delete",
						["p"] = "paste_from_clipboard",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["a"] = {
							"add",
							config = {
								show_path = "relative", -- "none", "relative", "absolute"
							},
						},
						["A"] = {
							"add_directory",
							config = {
								show_path = "relative", -- "none", "relative", "absolute"
							},
						},
						["c"] = {
							"copy",
							config = {
								show_path = "relative", -- "none", "relative", "absolute"
							},
						},
						["m"] = {
							"move",
							config = {
								show_path = "relative",
							},
						},
					},
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--               -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				group_empty_dirs = true, -- when true, empty folders will be grouped together
				show_unloaded = false,
				window = {
					mappings = {
						["d"] = "buffer_delete",
					},
				},
			},
			document_symbols = {
				follow_cursor = true,
				client_filters = "first",
				renderers = {
					root = {
						{ "indent" },
						{ "icon", default = "C" },
						{ "name", zindex = 10 },
					},
					symbol = {
						{ "indent", with_expanders = true },
						{ "kind_icon", default = "?" },
						{
							"container",
							content = {
								{ "name", zindex = 10 },
								{ "kind_name", zindex = 20, align = "right" },
							},
						},
					},
				},
			},
			-- document_symbols = {
			-- 	kinds = {
			-- 		File = { icon = "󰈙", hl = "Tag" },
			-- 		Namespace = { icon = "󰌗", hl = "Include" },
			-- 		Package = { icon = "󰏖", hl = "Label" },
			-- 		Class = { icon = "󰌗", hl = "Include" },
			-- 		Property = { icon = "󰆧", hl = "@property" },
			-- 		Enum = { icon = "󰒻", hl = "@number" },
			-- 		Function = { icon = "󰊕", hl = "Function" },
			-- 		String = { icon = "󰀬", hl = "String" },
			-- 		Number = { icon = "󰎠", hl = "Number" },
			-- 		Array = { icon = "󰅪", hl = "Type" },
			-- 		Object = { icon = "󰅩", hl = "Type" },
			-- 		Key = { icon = "󰌋", hl = "" },
			-- 		Struct = { icon = "󰌗", hl = "Type" },
			-- 		Operator = { icon = "󰆕", hl = "Operator" },
			-- 		TypeParameter = { icon = "󰊄", hl = "Type" },
			-- 		StaticMethod = { icon = "󰠄 ", hl = "Function" },
			-- 	},
			-- },
		})
	end,
}
