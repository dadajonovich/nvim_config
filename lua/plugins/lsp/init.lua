return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
	},
	config = function()
		require("plugins.lsp.keymaps").setup()
		require("plugins.lsp.diagnostics").setup()

		local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()
		require("plugins.lsp.servers").setup(cmp_capabilities)
	end,
}
