return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
	opts = {
		auto_update = true,
		run_on_start = true,
		ensure_installed = {
			-- LSP servers
			"json-lsp",
			"lua-language-server",
			"typescript-language-server",
			"yaml-language-server",
			"marksman",
			"beautysh",
			"bash-language-server",
			"rust-analyzer",

			-- Formatters
			"stylua",
			"shfmt",
			"markdown-toc",
			"codespell",
			"xmlformatter",
			"taplo",
			"prettier",
			"black",

			-- Linters
			"markdownlint", -- and formatter
			"alex",
			"proselint",
			"write-good",
			"eslint_d",
			"yamllint",
			"jsonlint",
			"shellcheck", -- used by bash-language-server, no config required in nvim-lint
		},
	},
}
