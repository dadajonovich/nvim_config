return {
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			local conform = require("conform")

			-- настройка форматтеров
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					vue = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					markdown = { "prettier" },
				},
			})

			-- автокоманда для форматирования
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					conform.format({
						bufnr = args.buf,
						async = false,
					})
				end,
			})
		end,
	},
}
