return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"vue_ls",
					"vtsls",
					"html",
					"stylelint_lsp",
					"cssls",
					"css_variables",
					"cssmodules_ls",
					"eslint",
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = { "stylua", "prettier" },
				auto_update = true,
			})
		end,
	},
}
