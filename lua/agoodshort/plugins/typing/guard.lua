return {
	"nvimdev/guard.nvim",
	lazy = true,
	dependencies = {
		"nvimdev/guard-collection",
		"williamboman/mason.nvim", -- To use LSP as default formatter
	},
	config = function()
		local ft = require("guard.filetype")

		-- stylua
		ft("lua"):fmt("stylua")

		-- prettier
		ft("markdown"):fmt("prettier")
		ft("json"):fmt("prettier")
		ft("yaml"):fmt("prettier")
		ft("typescript,javascript,typescriptreact"):fmt("prettier")

		-- sh
		ft("sh,zsh"):fmt("shfmt")

		-- use lsp to format first then use golines to format
		-- ft('go'):fmt('lsp')
		--     :append('golines')
		--     :lint('golangci')

		-- call setup LAST
		require("guard").setup({
			fmt_on_save = false,
			lsp_as_default_formatter = true,
		})
	end,
}
