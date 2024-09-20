return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "jay-babu/mason-nvim-dap.nvim" },
	opts = {
		auto_update = true,
		run_on_start = true,
		ensure_installed = {
			-- LSP servers
			"json-lsp",
			"lua-language-server",
			"typescript-language-server",
			"angular-language-server",
			"cucumber-language-server",
			"yaml-language-server",
			"marksman",
			"bash-language-server",
			"rust-analyzer",
			"hyprls",

			-- Formatters
			"stylua",
			"beautysh",
			"markdown-toc",
			"codespell",
			"xmlformatter",
			"taplo",
			"prettier",
			"black",

			-- Linters
			"markdownlint", -- and formatter
			"cfn-lint",
			"alex",
			"actionlint",
			"luacheck",
			"proselint",
			"write-good",
			"yamllint",
			"jsonlint",
			"eslint_d",
			"shellcheck", -- used by bash-language-server, no config required in nvim-lint

			-- DAP
			"js-debug-adapter",
		},
	},
}
