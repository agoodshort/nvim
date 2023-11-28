return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		local prettier_langs =
			{ "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "html", "json" }

		local options = {
			notify_on_error = true,
			formatters_by_ft = {
				lua = { "stylua" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
				toml = { "taplo" },
				markdown = { "markdownlint", "markdown-toc", "injected" },
				xml = { "xmlformat" },
				yaml = { "yamlfmt" },
				["_"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" }, -- pseudo formatters from conform.nvim
				["*"] = { "codespell" },
			},
		}

		for _, lang in ipairs(prettier_langs) do
			options.formatters_by_ft[lang] = { "prettier" }
		end

		require("conform").setup(options)
	end,
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
