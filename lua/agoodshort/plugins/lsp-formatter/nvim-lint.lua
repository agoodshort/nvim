return {
	"mfussenegger/nvim-lint",
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "markdown" },
	config = function()
		local eslint_langs = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
		local filetypes = {
			markdown = { "markdownlint" },
		}

		for _, lang in ipairs(eslint_langs) do
			filetypes[lang] = { "eslint_d" }
		end

		require("lint").linters_by_ft = filetypes

		-- Lint on save
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
