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
				rust = { "rustfmt" }, -- Installed manually through brew
				["_"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" }, -- Run on filetypes that don't have a formatter, pseudo formatters from conform.nvim
				["*"] = { "codespell" }, -- Run on all filetypes
			},
			prettier = {
				command = require("conform.util").find_executable({
					"node_modules/.bin/prettier",
				}, "prettier"),
			},
		}

		for _, lang in ipairs(prettier_langs) do
			options.formatters_by_ft[lang] = { "prettier" }
		end

		require("conform").setup(options)

		-- Optional config per formatter
		require("conform").formatters.yamlfmt = {
			prepend_args = { "-formatter", "retain_line_breaks=true" },
		}
	end,
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
