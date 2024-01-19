return {
	"b0o/incline.nvim",
	event = "VeryLazy",
	config = function()
		local icons = require("agoodshort.icons")
		local kana_colors = require("kanagawa.colors").setup()
		local theme = kana_colors.theme

		local function get_diagnostic_label(props)
			local icons_diagnostic = icons.diagnostic

			local label = {}
			for severity, icon in pairs(icons_diagnostic) do
				local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
				if n > 0 then
					table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
				end
			end
			return label
		end

		local function get_git_diff(props)
			local icons_git = icons.git
			local labels = {}
			local status, signs = pcall(function()
				vim.api.nvim_buf_get_var(props.buf, "gitsigns_status_dict")
			end)
			if status then
				for name, icon in pairs(icons_git) do
					if tonumber(signs[name]) and signs[name] > 0 then
						table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
					end
				end
			end
			return labels
		end

		require("incline").setup({
			window = {
				placement = {
					horizontal = "center",
					vertical = "bottom",
				},
				margin = {
					horizontal = 2,
					vertical = 2,
				},
				padding = 0,
			},
			hide = {
				cursorline = "focused_win",
			},
			render = function(props)
				local diagnostics = get_diagnostic_label(props)
				local git_diffs = get_git_diff(props)

				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":~:.")
				local filetype_icon, filetype_color = require("nvim-web-devicons").get_icon_color(filename)

				local bg_color, fg_color, editor_bg_color
				if props.focused == true then
					bg_color = "black"
					fg_color = theme.ui.fg
					editor_bg_color = theme.ui.bg
				else
					bg_color = theme.ui.bg
					fg_color = theme.ui.nontext
					editor_bg_color = theme.ui.bg_dim
				end

				local buffer = {
					{
						filetype_icon,
						guifg = filetype_color,
					},
					{ " " },
					{
						filename,
						guifg = fg_color,
					},
				}

				if vim.api.nvim_buf_get_option(props.buf, "modified") then
					table.insert(buffer, { " " .. icons.file.modified, guifg = "green", gui = "bold" })
				end

				-- Check if buffer is modifiable
				if
					not vim.api.nvim_buf_get_option(props.buf, "modifiable")
					or vim.api.nvim_buf_get_option(props.buf, "readonly")
				then
					table.insert(buffer, { " " .. icons.file.readonly, guifg = "orange", gui = "bold" })
				end

				-- Add separators
				if #diagnostics > 0 then
					table.insert(diagnostics, { "| ", guifg = "grey" })
				end

				if #git_diffs > 0 then
					table.insert(git_diffs, { "| ", guifg = "grey" })
				end

				-- Add diagnostics and git diffs
				for _, buffer_ in ipairs(buffer) do
					table.insert(diagnostics, buffer_)
				end

				for _, diagnostics_ in ipairs(diagnostics) do
					table.insert(git_diffs, diagnostics_)
				end

				return {
					{ "", guifg = bg_color, guibg = editor_bg_color },
					{ git_diffs, guibg = bg_color },
					{ "", guifg = bg_color, guibg = editor_bg_color },
				}
			end,
		})
	end,
}
