return {
	"b0o/incline.nvim",
	event = "VeryLazy",
	config = function()
		local function get_diagnostic_label(props)
			local icons = {
				Error = "",
				Warn = "",
				Info = "",
				Hint = "",
			}

			local label = {}
			for severity, icon in pairs(icons) do
				local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
				if n > 0 then
					table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
				end
			end
			return label
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
			},
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":~:.")

				local filetype_icon, color = require("nvim-web-devicons").get_icon_color(filename)
				local diagnostics = get_diagnostic_label(props)

				local buffer = {
					{
						filetype_icon,
						guifg = color,
					},
					{ " " },
					{
						filename,
					},
				}

				if #diagnostics > 0 then
					table.insert(diagnostics, { "| ", guifg = "grey" })
				end

				if vim.api.nvim_buf_get_option(props.buf, "modified") then
					table.insert(buffer, { " [+]", guifg = "green", gui = "bold" })
				end

				if
					not vim.api.nvim_buf_get_option(props.buf, "modifiable")
					or vim.api.nvim_buf_get_option(props.buf, "readonly")
				then
					table.insert(buffer, { " ", guifg = "orange", gui = "bold" })
				end

				for _, buffer_ in ipairs(buffer) do
					table.insert(diagnostics, buffer_)
				end

				return diagnostics
			end,
		})
	end,
}
