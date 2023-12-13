return {
	"rebelot/heirline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"Exafunction/codeium.vim",
	},
	event = "VeryLazy",
	config = function()
		local icons = require("agoodshort.icons")
		local colors = require("kanagawa.colors").setup()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		local Align = { provider = "%=" }
		local Space = { provider = " " }

		-- --------------------------------------------------
		-- Project location
		-- --------------------------------------------------
		local WorkDir = {

			utils.surround({ "", "" }, utils.get_highlight("Directory").fg, {
				provider = function()
					local icon = icons.misc.folder
					local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
					if not conditions.width_percent_below(#cwd, 0.25) then
						cwd = vim.fn.pathshorten(cwd)
					end
					return icon .. " " .. cwd
				end,
				hl = { fg = "black" },
			}),
		}
		-- --------------------------------------------------
		-- Mode
		-- --------------------------------------------------

		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			static = {
				mode_names = { -- change the strings if you like it vvvvverbose!
					n = "Normal",
					no = "N?",
					nov = "N?",
					noV = "N?",
					["no\22"] = "N?",
					niI = "Ni",
					niR = "Nr",
					niV = "Nv",
					nt = "Nt",
					v = "Visual",
					vs = "Vs",
					V = "V_",
					Vs = "Vs",
					["\22"] = "^V",
					["\22s"] = "^V",
					s = "Select",
					S = "S_",
					["\19"] = "^S",
					i = "Insert",
					ic = "Ic",
					ix = "Ix",
					R = "R",
					Rc = "Rc",
					Rx = "Rx",
					Rv = "Rv",
					Rvc = "Rv",
					Rvx = "Rv",
					c = "CmdLine",
					cv = "Ex",
					r = "...",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "Terminal",
				},
				mode_colors = {
					n = "red",
					i = "green",
					v = "cyan",
					V = "cyan",
					["\22"] = "cyan",
					c = "orange",
					s = "purple",
					S = "purple",
					["\19"] = "purple",
					R = "orange",
					r = "orange",
					["!"] = "red",
					t = "grey",
				},
			},
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
			-- Return
			{
				provider = function()
					return ""
				end,
				hl = function(self)
					return { fg = self.mode_colors[self.mode:sub(1, 1)] }
				end,
			},
			{
				provider = function(self)
					return "  %2(" .. self.mode_names[self.mode] .. "%)"
				end,
				hl = function(self)
					return { fg = "black", bg = self.mode_colors[self.mode:sub(1, 1)], bold = true }
				end,
			},
			{
				provider = function()
					return ""
				end,
				hl = function(self)
					return { fg = self.mode_colors[self.mode:sub(1, 1)] }
				end,
			},
		}

		-- --------------------------------------------------
		-- LSP
		-- --------------------------------------------------

		local LSPActive = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },
			on_click = {
				callback = function()
					vim.defer_fn(function()
						vim.cmd("LspInfo")
					end, 100)
				end,
				name = "heirline_LSP",
			},
			utils.surround({ "", "" }, "green", {
				provider = function()
					local names = {}
					for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
						table.insert(names, server.name)
					end
					return "󰒍 " .. table.concat(names, " ")
				end,
				hl = { fg = "white" },
			}),
		}

		-- --------------------------------------------------
		-- Linter
		-- --------------------------------------------------

		local LinterActive = {
			condition = function()
				if require("lazy.core.config").plugins["nvim-lint"]._.loaded then
					return true
				else
					return false
				end
			end,
			update = { "BufEnter", "WinEnter", "BufWritePost" },
			utils.surround({ "", "" }, "orange", {
				provider = function()
					local linters = require("lint").get_running()
					if #linters == 0 then
						return "󰦕"
					end
					return "󱉶 " .. table.concat(linters, ", ")
				end,
				hl = { fg = "black" },
			}),
		}
		-- --------------------------------------------------
		-- Git
		-- --------------------------------------------------

		local Git = {
			condition = function()
				local path = vim.loop.cwd() .. "/.git"
				local ok = vim.loop.fs_stat(path)
				if not ok then
					return false
				end
				return true
			end,
			on_click = {
				callback = function()
					vim.defer_fn(function()
						vim.cmd("Telescope git_submodules")
					end, 100)
				end,
				name = "heirline_git",
			},
			update = { "DirChanged", "BufWritePost" },

			init = function(self)
				self.current_dir_head = vim.fn.system("git rev-parse --abbrev-ref HEAD")
				self.current_dir_status = vim.fn.system("git status -bs")
				self.git_status_current = ""
				for s in string.gmatch(self.current_dir_status, "[^" .. "\n" .. "]+") do
					for w in string.gmatch(s, "[^" .. " " .. "]+") do
						if w == "M" and string.find(self.git_status_current, "!") == nil then
							self.git_status_current = self.git_status_current .. "!"
						elseif w == "??" and string.find(self.git_status_current, "+") == nil then
							self.git_status_current = self.git_status_current .. "+"
						elseif w == "D" and string.find(self.git_status_current, "✘") == nil then
							self.git_status_current = self.git_status_current .. "✘"
						end
						if
							w == "##"
							and string.find(self.git_status_current, "⇡") == nil
							and string.match(s, "ahead")
						then
							self.git_status_current = self.git_status_current .. "⇡"
						end
						if
							w == "##"
							and string.find(self.git_status_current, "⇣") == nil
							and string.match(s, "behind")
						then
							self.git_status_current = self.git_status_current .. "⇣"
						end
					end
				end
			end,

			utils.surround({ "", "" }, "orange", {
				provider = function(self)
					return icons.git.branch
						.. " "
						.. self.current_dir_head:gsub("%\n", "")
						.. " "
						.. self.git_status_current
				end,
				hl = { fg = "black" },
			}),
		}

		-- --------------------------------------------------
		-- Codeium
		-- --------------------------------------------------
		local Codeium = {
			utils.surround({ "", "" }, "lightblue", {
				provider = function()
					return " " .. vim.fn["codeium#GetStatusString"]()
				end,
				hl = { fg = "black" },
			}),
		}

		-- --------------------------------------------------
		-- Lazy
		-- --------------------------------------------------
		local Lazy = {
			condition = require("lazy.status").has_updates,
			update = { "User", pattern = "LazyUpdate" },
			utils.surround({ "", "" }, "lightblue", {
				provider = function()
					return require("lazy.status").updates()
				end,
				on_click = {
					callback = function()
						vim.cmd("Lazy")
					end,
					name = "update_plugins",
				},
				hl = { fg = "black" },
			}),
		}

		-- --------------------------------------------------
		-- Recorder
		-- --------------------------------------------------
		local Recorder = {
			condition = function()
				if require("lazy.core.config").plugins["nvim-recorder"]._.loaded then
					return true
				else
					return false
				end
			end,
			utils.surround({ "", "" }, "black", {
				init = function(self)
					self.displaySlots = require("recorder").displaySlots()
					self.recordingStatus = require("recorder").recordingStatus()
				end,
				provider = function(self)
					return self.displaySlots .. " " .. self.recordingStatus
				end,
			}),
		}

		-- --------------------------------------------------
		-- Plugin init
		-- --------------------------------------------------

		require("heirline").setup({
			statusline = {
				Space,
				ViMode,
				Space,
				WorkDir,
				Space,
				Git,
				Align,
				Align,
				Lazy,
				Align,
				Align,
				Align,
				Recorder,
				Space,
				LSPActive,
				Space,
				LinterActive,
				Space,
				Codeium,
				Space,
			},
			opts = {
				colors = colors,
			},
		})
	end,
}
